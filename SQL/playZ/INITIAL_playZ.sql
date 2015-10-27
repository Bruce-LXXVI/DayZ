-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 23. Okt 2015 um 23:42
-- Server-Version: 5.6.24
-- PHP-Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `dayz_namalsk`
--

DELIMITER $$
--
-- Prozeduren
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pCleanup`()
BEGIN 
#Last ran
	update event_scheduler set LastRun = NOW() where System = "pCleanup";

#starts outofbounds cleanup
        CALL pCleanupOOB();
 
#move dead players to character_dead
        Insert

                INTO character_dead
                SELECT *
                FROM character_data
                        WHERE Alive=0;
 
#remove damaged objects
        DELETE
                FROM object_data
                WHERE Damage = 1;

#remove empty tents older than seven days
        DELETE
                FROM object_data
                WHERE (Classname = 'TentStorage%' or Classname = 'StashSmall%' or Classname = 'StashMedium%')
                        AND DATE(last_updated) < CURDATE() - INTERVAL 7 DAY
                        AND Inventory = '[[[],[]],[[],[]],[[],[]]]';
       
        DELETE
                FROM object_data
                WHERE (Classname = 'TentStorage%' or Classname = 'StashSmall%' or Classname = 'StashMedium%')
                        AND DATE(last_updated) < CURDATE() - INTERVAL 7 DAY
                        AND Inventory = '[]';          
 
#remove barbed wire older than two days
        DELETE
                FROM object_data
                WHERE Classname = 'Wire_cat1'
                        AND DATE(last_updated) < CURDATE() - INTERVAL 2 DAY;
                       
#remove Tank Traps older than fifteen days
        DELETE
                FROM object_data
                WHERE Classname = 'Hedgehog_DZ'
                        AND DATE(last_updated) < CURDATE() - INTERVAL 15 DAY;
 
#remove Sandbags older than twenty days
        DELETE
                FROM object_data
                WHERE Classname = 'Sandbag1_DZ'
                        AND DATE(last_updated) < CURDATE() - INTERVAL 20 DAY;
 
#remove Traps older than five days
        DELETE
                FROM object_data
                WHERE (Classname = 'BearTrap_DZ' or Classname = 'TrapBearTrapFlare' or Classname = 'TrapBearTrapSmoke' or Classname = 'Trap_Cans' or Classname = 'TrapTripwireFlare' or Classname = 'TrapTripwireGrenade' or Classname = 'TrapTripwireSmoke')
                        AND DATE(last_updated) < CURDATE() - INTERVAL 5 DAY; 
                        
#remove incomplete fence's after 1 Day								
        DELETE
                FROM object_data
                WHERE (Classname = 'WoodenFence_1_foundation')
                        AND DATE(last_updated) < CURDATE() - INTERVAL 1 Day;  
                        
#remove incomplete fence's after 3 Dayz								
        DELETE
                FROM object_data
                WHERE (Classname = 'WoodenFence_1_frame' or Classname = 'WoodenFence_quaterpanel' or Classname = 'WoodenFence_halfpanel' or Classname = 'WoodenFence_thirdpanel')
                        AND DATE(last_updated) < CURDATE() - INTERVAL 3 Day; 
                       
#remove dead players from data table
        DELETE
                FROM character_data
                WHERE Alive=0;                                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pCleanupOOB`()
BEGIN

	DECLARE intLineCount	INT DEFAULT 0;
	DECLARE intDummyCount	INT DEFAULT 0;
	DECLARE intDoLine			INT DEFAULT 0;
	DECLARE intWest				INT DEFAULT 0;
	DECLARE intNorth			INT DEFAULT 0;

	SELECT COUNT(*)
		INTO intLineCount
		FROM Object_DATA;

	SELECT COUNT(*)
		INTO intDummyCount
		FROM Object_DATA
		WHERE Classname = 'dummy';

	WHILE (intLineCount > intDummyCount) DO
	
		SET intDoLine = intLineCount - 1;

		SELECT ObjectUID, Worldspace
			INTO @rsObjectUID, @rsWorldspace
			FROM Object_DATA
			LIMIT intDoLine, 1;

		SELECT REPLACE(@rsWorldspace, '[', '') INTO @rsWorldspace;
		SELECT REPLACE(@rsWorldspace, ']', '') INTO @rsWorldspace;
		SELECT REPLACE(SUBSTRING(SUBSTRING_INDEX(@rsWorldspace, ',', 2), LENGTH(SUBSTRING_INDEX(@rsWorldspace, ',', 2 -1)) + 1), ',', '') INTO @West;
		SELECT REPLACE(SUBSTRING(SUBSTRING_INDEX(@rsWorldspace, ',', 3), LENGTH(SUBSTRING_INDEX(@rsWorldspace, ',', 3 -1)) + 1), ',', '') INTO @North;

		SELECT INSTR(@West, '-') INTO intWest;
		SELECT INSTR(@North, '-') INTO intNorth;


		IF (intNorth = 0) THEN
			SELECT CONVERT(@North, DECIMAL(16,8)) INTO intNorth;
		END IF;

		IF (intWest > 0 OR intNorth > 15360) THEN
			DELETE FROM Object_DATA
				WHERE ObjectUID = @rsObjectUID;
		END IF;
			
		SET intLineCount = intLineCount - 1;

	END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pMain`(IN `i` INT)
    MODIFIES SQL DATA
BEGIN
# maximum number of INSTANCE id's USED.
#-----------------------------------------------
	DECLARE sInstance VARCHAR(8) DEFAULT i;
#-----------------------------------------------
#maximum number of vehicles allowed !!! theoretical max. amount
#-----------------------------------------------
	DECLARE iVehSpawnMax INT DEFAULT 85;
#-----------------------------------------------	

# DECLARE iVehSpawnMin				INT DEFAULT 0;		#ToDo !!!
	DECLARE iTimeoutMax 				INT DEFAULT 250;	#number of loops before timeout
	DECLARE iTimeout 						INT DEFAULT 0;		#internal counter for loops done; used to prevent infinite loops - DO NOT CHANGE
	DECLARE iNumVehExisting 		INT DEFAULT 0;		#internal counter for already existing vehicles - DO NOT CHANGE
	DECLARE iNumClassExisting 	INT DEFAULT 0;		#internal counter for already existing class types - DO NOT CHANGE
	DECLARE i INT DEFAULT 1; #internal counter for vehicles spawns - DO NOT CHANGE

#Last Ran
	update event_scheduler set LastRun = NOW() where System = "pMain";

#Starts Cleanup
	CALL pCleanup();
	
		SELECT COUNT(*) 				#retrieve the amount of already spawned vehicles...
			INTO iNumVehExisting
			FROM object_data
			WHERE Instance = sInstance
			AND CharacterID = 0;

		WHILE (iNumVehExisting < iVehSpawnMax) DO		#loop until maximum amount of vehicles is reached

			#select a random vehicle class
			SELECT Classname, Chance, MaxNum, Damage
				INTO @rsClassname, @rsChance, @rsMaxNum, @rsDamage
				FROM object_classes ORDER BY RAND() LIMIT 1;

			#count number of same class already spawned
			SELECT COUNT(*) 
				INTO iNumClassExisting 
				FROM object_data
				WHERE Instance = sInstance
				AND Classname = @rsClassname;

			IF (iNumClassExisting < @rsMaxNum) THEN

				IF (rndspawn(@rschance) = 1) THEN
				
					INSERT INTO object_data (ObjectUID, Instance, Classname, Damage, CharacterID, Worldspace, Inventory, Hitpoints, Fuel, Datestamp)
						SELECT ObjectUID, sInstance, Classname, RAND(@rsDamage), '0', Worldspace, Inventory, Hitpoints, RAND(1), SYSDATE() 
							FROM object_spawns 
							WHERE Classname = @rsClassname 
								AND NOT ObjectUID IN (select objectuid from object_data where instance = sInstance)
							ORDER BY RAND()
							LIMIT 0, 1;
							
					SELECT COUNT(*) 
						INTO iNumVehExisting 
						FROM Object_DATA 
						WHERE Instance = sInstance
						AND CharacterID = 0;	
					#update number of same class already spawned
					SELECT COUNT(*) 
						INTO iNumClassExisting 
						FROM Object_DATA
						WHERE Instance = sInstance
						AND Classname = @rsClassname;
				
				END IF;
			END IF;	
			
			SET iTimeout = iTimeout + 1; #raise timeout counter
			IF (iTimeout >= iTimeoutMax) THEN
				SET iNumVehExisting = iVehSpawnMax;
			END IF;
		END WHILE;
	SET i = i + 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pPlayZ_Cleanup`(IN `i` INT)
    MODIFIES SQL DATA
BEGIN
# Server instance ID.
#-----------------------------------------------
	DECLARE sInstance VARCHAR(8) DEFAULT i;
#-----------------------------------------------
#Last Ran
	update event_scheduler set LastRun = NOW() where System = "pPlayZ_Cleanup";
#Starts Cleanup

	INSERT INTO object_data_deleted (SELECT *, NULL, NOW() FROM object_data WHERE `Instance`=sInstance AND `Damage`>=1);
	DELETE FROM `object_data` WHERE `Instance`=sInstance AND `Damage`>=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pPlayZ_UID2ID`(IN `i` INT)
    MODIFIES SQL DATA
BEGIN
# Server instance ID.
#-----------------------------------------------
	DECLARE sInstance VARCHAR(8) DEFAULT i;
#-----------------------------------------------
#Last Ran
	update event_scheduler set LastRun = NOW() where System = "pPlayZ_UID2ID";
#Starts setting ID
	UPDATE `object_data` SET `ObjectID`=fPlayZ_generateID(i, `ObjectUID`) WHERE `Instance`=sInstance AND (`ObjectID`<300000 OR `ObjectID`>=2147483647);
END$$

--
-- Funktionen
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fPlayZ_generateID`(`inst` int, `ObjectUID` bigint(20)) RETURNS bigint(20)
BEGIN
	DECLARE Min BIGINT DEFAULT 10000000;
	DECLARE Max BIGINT DEFAULT 99999999;
	DECLARE ID BIGINT DEFAULT 0;

	IF (ObjectUID < 2147483647) THEN
		SET ID = ObjectUID;
	END IF;

	IF (ObjectUID < 300000) THEN
		SET ID = ObjectUID + 100000000;
	END IF;

	IF (ID IN (SELECT ObjectID FROM object_data WHERE Instance = inst)) THEN
		SET ID = 0;
	END IF;
	
	
	WHILE (ID = 0) DO
		SET ID = ROUND(Min + RAND() * (Max - Min)) + 100000000;
		
		IF (ID IN (SELECT ObjectID FROM object_data WHERE Instance = inst)) THEN
			SET ID = 0;
		END IF;
	END WHILE;
	
	RETURN ID;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `rndspawn`(`chance` double) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN

	DECLARE bspawn tinyint(1) DEFAULT 0;

	IF (RAND() <= chance) THEN
		SET bspawn = 1;
	END IF;

	RETURN bspawn;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accesslvl`
--

CREATE TABLE IF NOT EXISTS `accesslvl` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `access` varchar(128) NOT NULL DEFAULT '[]'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `accesslvl`
--

INSERT INTO `accesslvl` (`id`, `name`, `access`) VALUES
(1, 'full', '["true", "true", "true", "true", "true", "true", "true"]'),
(2, 'semi', '["false", "false", "true", "false", "true", "true", "false"]');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_data`
--

CREATE TABLE IF NOT EXISTS `character_data` (
  `CharacterID` int(11) NOT NULL,
  `PlayerID` int(11) NOT NULL DEFAULT '1000',
  `PlayerUID` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `InstanceID` int(11) NOT NULL DEFAULT '0',
  `Datestamp` datetime DEFAULT NULL,
  `LastLogin` datetime NOT NULL,
  `Inventory` longtext CHARACTER SET latin1,
  `Backpack` longtext CHARACTER SET latin1,
  `Worldspace` varchar(70) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Medical` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Alive` tinyint(4) NOT NULL DEFAULT '1',
  `Generation` int(11) NOT NULL DEFAULT '1',
  `LastAte` datetime NOT NULL,
  `LastDrank` datetime NOT NULL,
  `KillsZ` int(11) NOT NULL DEFAULT '0',
  `HeadshotsZ` int(11) NOT NULL DEFAULT '0',
  `distanceFoot` int(11) NOT NULL DEFAULT '0',
  `duration` int(11) NOT NULL DEFAULT '0',
  `currentState` varchar(1000) CHARACTER SET latin1 NOT NULL DEFAULT '[[],[]]',
  `KillsH` int(11) NOT NULL DEFAULT '0',
  `Model` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '"Survivor2_DZ"',
  `KillsB` int(11) NOT NULL DEFAULT '0',
  `Humanity` int(11) NOT NULL DEFAULT '2500',
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_dead`
--

CREATE TABLE IF NOT EXISTS `character_dead` (
  `CharacterID` int(11) NOT NULL,
  `PlayerID` int(11) NOT NULL DEFAULT '0',
  `PlayerUID` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `InstanceID` int(11) NOT NULL DEFAULT '0',
  `Datestamp` datetime DEFAULT NULL,
  `LastLogin` datetime NOT NULL,
  `Inventory` longtext CHARACTER SET latin1,
  `Backpack` longtext CHARACTER SET latin1,
  `Worldspace` varchar(70) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Medical` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Alive` tinyint(4) NOT NULL DEFAULT '1',
  `Generation` int(11) NOT NULL DEFAULT '1',
  `LastAte` datetime NOT NULL,
  `LastDrank` datetime NOT NULL,
  `KillsZ` int(11) NOT NULL DEFAULT '0',
  `HeadshotsZ` int(11) NOT NULL DEFAULT '0',
  `distanceFoot` int(11) NOT NULL DEFAULT '0',
  `duration` int(11) NOT NULL DEFAULT '0',
  `currentState` varchar(1000) CHARACTER SET latin1 NOT NULL DEFAULT '[[],[]]',
  `KillsH` int(11) NOT NULL DEFAULT '0',
  `Model` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '"Survivor2_DZ"',
  `KillsB` int(11) NOT NULL DEFAULT '0',
  `Humanity` int(11) NOT NULL DEFAULT '2500',
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `event_scheduler`
--

CREATE TABLE IF NOT EXISTS `event_scheduler` (
  `id` int(11) NOT NULL,
  `System` text CHARACTER SET latin1,
  `LastRun` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `event_scheduler`
--

INSERT INTO `event_scheduler` (`id`, `System`, `LastRun`) VALUES
(1, '3hRespawns', NULL),
(2, 'pCleanup', NULL),
(3, 'pMain', NULL),
(4, 'pCleanupBase', NULL),
(5, 'playZ_1min_scheduler', NULL),
(6, 'pPlayZ_UID2ID', NULL),
(7, 'pPlayZ_Cleanup', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(10) unsigned NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `user` varchar(255) NOT NULL DEFAULT '',
  `timestamp` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `object_classes`
--

CREATE TABLE IF NOT EXISTS `object_classes` (
  `Classname` varchar(32) NOT NULL DEFAULT '',
  `Chance` varchar(4) NOT NULL DEFAULT '0',
  `MaxNum` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Damage` varchar(20) NOT NULL DEFAULT '0',
  `Type` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `object_data`
--

CREATE TABLE IF NOT EXISTS `object_data` (
  `ObjectID` bigint(20) NOT NULL,
  `ObjectUID` bigint(20) NOT NULL DEFAULT '0',
  `Instance` int(11) NOT NULL,
  `Classname` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `Datestamp` datetime NOT NULL,
  `CharacterID` int(11) NOT NULL DEFAULT '0',
  `Worldspace` varchar(70) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Inventory` longtext CHARACTER SET latin1,
  `Hitpoints` varchar(500) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `Damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `object_data_deleted`
--

CREATE TABLE IF NOT EXISTS `object_data_deleted` (
  `ObjectID` bigint(20) NOT NULL,
  `ObjectUID` bigint(20) NOT NULL DEFAULT '0',
  `Instance` int(11) NOT NULL,
  `Classname` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `Datestamp` datetime NOT NULL,
  `CharacterID` int(11) NOT NULL DEFAULT '0',
  `Worldspace` varchar(70) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Inventory` longtext CHARACTER SET latin1,
  `Hitpoints` varchar(500) CHARACTER SET latin1 NOT NULL DEFAULT '[]',
  `Fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `Damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `object_spawns`
--

CREATE TABLE IF NOT EXISTS `object_spawns` (
  `ObjectUID` bigint(20) NOT NULL DEFAULT '0',
  `Classname` varchar(32) DEFAULT NULL,
  `Worldspace` varchar(64) DEFAULT NULL,
  `Inventory` longtext,
  `Hitpoints` varchar(999) NOT NULL DEFAULT '[]',
  `MapID` varchar(255) NOT NULL DEFAULT '',
  `Last_changed` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `player_data`
--

CREATE TABLE IF NOT EXISTS `player_data` (
  `playerID` int(11) NOT NULL DEFAULT '0',
  `playerUID` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `playerName` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT 'Null',
  `playerMorality` int(11) NOT NULL DEFAULT '0',
  `playerSex` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `player_login`
--

CREATE TABLE IF NOT EXISTS `player_login` (
  `LoginID` int(11) NOT NULL,
  `PlayerUID` varchar(45) CHARACTER SET latin1 NOT NULL,
  `CharacterID` int(11) NOT NULL DEFAULT '0',
  `datestamp` datetime NOT NULL,
  `Action` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `playz_player_loggedin`
--
CREATE TABLE IF NOT EXISTS `playz_player_loggedin` (
`playerName` varchar(50)
,`CharacterID` int(11)
,`PlayerID` int(11)
,`PlayerUID` varchar(45)
,`InstanceID` int(11)
,`Datestamp` datetime
,`LastLogin` datetime
,`Inventory` longtext
,`Backpack` longtext
,`Worldspace` varchar(70)
,`Medical` varchar(200)
,`Alive` tinyint(4)
,`Generation` int(11)
,`LastAte` datetime
,`LastDrank` datetime
,`KillsZ` int(11)
,`HeadshotsZ` int(11)
,`distanceFoot` int(11)
,`duration` int(11)
,`currentState` varchar(1000)
,`KillsH` int(11)
,`Model` varchar(50)
,`KillsB` int(11)
,`Humanity` int(11)
,`last_updated` timestamp
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `playz_player_logins`
--
CREATE TABLE IF NOT EXISTS `playz_player_logins` (
`datestamp` datetime
,`playerName` varchar(50)
,`playerUID` varchar(45)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `playz_player_login_count`
--
CREATE TABLE IF NOT EXISTS `playz_player_login_count` (
`playerName` varchar(50)
,`playerUID` varchar(45)
,`last_login` datetime
,`first_login` datetime
,`login_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `toption`
--

CREATE TABLE IF NOT EXISTS `toption` (
  `optname` varchar(20) CHARACTER SET latin1 NOT NULL,
  `optvalue` varchar(100) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `toption`
--

INSERT INTO `toption` (`optname`, `optvalue`) VALUES
('dbversion', '2015-08-25 23:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` smallint(8) unsigned NOT NULL,
  `login` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `accesslvl` varchar(16) DEFAULT '',
  `salt` char(3) NOT NULL DEFAULT '',
  `lastlogin` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur des Views `playz_player_loggedin`
--
DROP TABLE IF EXISTS `playz_player_loggedin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `playz_player_loggedin` AS select `player_data`.`playerName` AS `playerName`,`character_data`.`CharacterID` AS `CharacterID`,`character_data`.`PlayerID` AS `PlayerID`,`character_data`.`PlayerUID` AS `PlayerUID`,`character_data`.`InstanceID` AS `InstanceID`,`character_data`.`Datestamp` AS `Datestamp`,`character_data`.`LastLogin` AS `LastLogin`,`character_data`.`Inventory` AS `Inventory`,`character_data`.`Backpack` AS `Backpack`,`character_data`.`Worldspace` AS `Worldspace`,`character_data`.`Medical` AS `Medical`,`character_data`.`Alive` AS `Alive`,`character_data`.`Generation` AS `Generation`,`character_data`.`LastAte` AS `LastAte`,`character_data`.`LastDrank` AS `LastDrank`,`character_data`.`KillsZ` AS `KillsZ`,`character_data`.`HeadshotsZ` AS `HeadshotsZ`,`character_data`.`distanceFoot` AS `distanceFoot`,`character_data`.`duration` AS `duration`,`character_data`.`currentState` AS `currentState`,`character_data`.`KillsH` AS `KillsH`,`character_data`.`Model` AS `Model`,`character_data`.`KillsB` AS `KillsB`,`character_data`.`Humanity` AS `Humanity`,`character_data`.`last_updated` AS `last_updated` from (`character_data` left join `player_data` on((`character_data`.`PlayerUID` = `player_data`.`playerUID`))) where ((`character_data`.`Alive` = 1) and (`character_data`.`last_updated` > (now() - 600))) group by `character_data`.`PlayerUID`;

-- --------------------------------------------------------

--
-- Struktur des Views `playz_player_logins`
--
DROP TABLE IF EXISTS `playz_player_logins`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `playz_player_logins` AS select `player_login`.`datestamp` AS `datestamp`,`player_data`.`playerName` AS `playerName`,`player_data`.`playerUID` AS `playerUID` from ((`player_data` left join `player_login` on((`player_data`.`playerUID` = `player_login`.`PlayerUID`))) left join `character_data` on((`character_data`.`CharacterID` = `player_login`.`CharacterID`))) order by `player_login`.`datestamp` desc;

-- --------------------------------------------------------

--
-- Struktur des Views `playz_player_login_count`
--
DROP TABLE IF EXISTS `playz_player_login_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `playz_player_login_count` AS select `player_data`.`playerName` AS `playerName`,`player_data`.`playerUID` AS `playerUID`,max(`player_login`.`datestamp`) AS `last_login`,min(`player_login`.`datestamp`) AS `first_login`,count(`player_login`.`LoginID`) AS `login_count` from ((`player_data` left join `player_login` on((`player_data`.`playerUID` = `player_login`.`PlayerUID`))) left join `character_data` on((`character_data`.`CharacterID` = `player_login`.`CharacterID`))) group by `player_data`.`playerUID` order by `last_login` desc;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `accesslvl`
--
ALTER TABLE `accesslvl`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `character_data`
--
ALTER TABLE `character_data`
  ADD PRIMARY KEY (`CharacterID`), ADD KEY `PlayerID` (`PlayerID`), ADD KEY `Alive_PlayerID` (`Alive`,`LastLogin`,`PlayerID`), ADD KEY `PlayerUID` (`PlayerUID`), ADD KEY `Alive_PlayerUID` (`Alive`,`LastLogin`,`PlayerUID`);

--
-- Indizes für die Tabelle `character_dead`
--
ALTER TABLE `character_dead`
  ADD PRIMARY KEY (`CharacterID`), ADD KEY `PlayerID` (`PlayerID`), ADD KEY `Alive_PlayerID` (`Alive`,`LastLogin`,`PlayerID`), ADD KEY `PlayerUID` (`PlayerUID`), ADD KEY `Alive_PlayerUID` (`Alive`,`LastLogin`,`PlayerUID`);

--
-- Indizes für die Tabelle `event_scheduler`
--
ALTER TABLE `event_scheduler`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `logs`
--
ALTER TABLE `logs`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indizes für die Tabelle `object_classes`
--
ALTER TABLE `object_classes`
  ADD PRIMARY KEY (`Classname`);

--
-- Indizes für die Tabelle `object_data`
--
ALTER TABLE `object_data`
  ADD PRIMARY KEY (`ObjectID`), ADD UNIQUE KEY `CheckUID` (`ObjectUID`,`Instance`), ADD KEY `ObjectUID` (`ObjectUID`), ADD KEY `Instance` (`Damage`,`Instance`);

--
-- Indizes für die Tabelle `object_data_deleted`
--
ALTER TABLE `object_data_deleted`
  ADD PRIMARY KEY (`id`), ADD KEY `ObjectID` (`ObjectID`), ADD KEY `ObjectUID` (`ObjectUID`), ADD KEY `Classname` (`Classname`), ADD KEY `Datestamp` (`Datestamp`), ADD KEY `CharacterID` (`CharacterID`), ADD KEY `last_updated` (`last_updated`), ADD KEY `deleted` (`deleted`);

--
-- Indizes für die Tabelle `object_spawns`
--
ALTER TABLE `object_spawns`
  ADD PRIMARY KEY (`ObjectUID`,`MapID`);

--
-- Indizes für die Tabelle `player_data`
--
ALTER TABLE `player_data`
  ADD KEY `playerID` (`playerID`), ADD KEY `playerUID` (`playerUID`);

--
-- Indizes für die Tabelle `player_login`
--
ALTER TABLE `player_login`
  ADD PRIMARY KEY (`LoginID`), ADD KEY `datestamp` (`datestamp`), ADD KEY `CharacterID` (`CharacterID`), ADD KEY `PlayerUID` (`PlayerUID`);

--
-- Indizes für die Tabelle `toption`
--
ALTER TABLE `toption`
  ADD PRIMARY KEY (`optname`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `accesslvl`
--
ALTER TABLE `accesslvl`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT für Tabelle `character_data`
--
ALTER TABLE `character_data`
  MODIFY `CharacterID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `character_dead`
--
ALTER TABLE `character_dead`
  MODIFY `CharacterID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `event_scheduler`
--
ALTER TABLE `event_scheduler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT für Tabelle `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `object_data`
--
ALTER TABLE `object_data`
  MODIFY `ObjectID` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `object_data_deleted`
--
ALTER TABLE `object_data_deleted`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `player_login`
--
ALTER TABLE `player_login`
  MODIFY `LoginID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint(8) unsigned NOT NULL AUTO_INCREMENT;
DELIMITER $$
--
-- Ereignisse
--
CREATE DEFINER=`root`@`localhost` EVENT `playZ_1min_scheduler` ON SCHEDULE EVERY 1 MINUTE STARTS '2015-07-25 00:00:00' ON COMPLETION NOT PRESERVE DISABLE DO BEGIN
	update event_scheduler set LastRun = NOW() where System = "playZ_1min_scheduler";
	
	CALL `pPlayZ_UID2ID`('1');
	CALL `pPlayZ_Cleanup`('1');
	
END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
