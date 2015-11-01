Installation von DayZ Namalsk
=============================


Alle Verzeichnisnamen werden als Variablen geschrieben:
* `%INST_NAME%`: Name der Instanz. Verzeichnis, wo u.a. basic.cfg, server.cfg und HiveExt.ini liegen
* 



Arma 2 Operation Arrowhead Programmverzeichnis
----------------------------------------------
Falls mehrere Instanzen parallel laufen sollen, empfiehlt es sich das Programmverzeichnis von _Arma 2 Operation Arrowhead_
für jede Instanz zu kopieren. Namensvorschlag: `A2OA_%INST_NAME%`.
Das Programmverzeichnis muss im File `%INST_NAME%\Tools\_set_RCON_variables.cmd` bekannt gegeben werden.



Mods und Mission installieren
-----------------------------
Entsprechende Mods, server.pbo und Mission installieren.
Keys nicht vergessen! 

http://download.nightstalkers.cz/ns2/nc_pathfinder4_full.7z
http://download.nightstalkers.cz/dzn/dayz_namalsk_v0.75.7z



Instanz anlegen
---------------
Im Programmverzeichnis muss ein Instanz-Verzeichnis `%INST_NAME%` angelegt werden.
Der Name der Instanz muss im File `%INST_NAME%\Tools\_set_RCON_variables.cmd` bekannt gegeben werden.
Vorlage aus `Server Files` in das Instanz-Verzeichnis kopieren.



Datenbank
---------
Datenbank anlegen für die Instanz. Leere DB unter `SQL\playZ\INITIAL_*.sql`.
Backup-Benutzer einrichten (Benötigte Rechte auf DB: `SELECT` und `SHOW VIEW`.
Ereignis `playZ_1min_scheduler` aktivieren.


Server und Hive konfigurieren
-----------------------------
Die Files `server.cfg` und `HiveExt.ini` anpassen.



BattlEye konfigurieren
----------------------
Im Verzeichnis `%INST_NAME%\BattlEye\` müssen die Dateien, die mit einem Unterstrich (_) beginnen umbenannt werden.
Insbesondere muss in `BEServer.cfg` das RCON-Passwort gesetzt werden.



BEC konfigurieren
-----------------
Unter `%INST_NAME%\BEC\Config\` liegt die Konfiguration für BEC.
In `Config.cfg` müssen Pfad und ggf. IP angepasst werden.
In `Admins.xml` sind die GUID's der Admins/Mods vermerkt.
In `Scheduler.xml` stehen die geplanten Tasks, wie z.B. automatischer Restart.



Tools konfigurieren
-------------------
In `%INST_NAME%\Tools\_set_RCON_variables.cmd` die Variablen definieren.
In `%INST_NAME%\Tools\_BACKUP_DB.cmd` den Datenbank-Backup-User definieren und ggf. den Pfad zu
`mysqldump` anpassen.
Geplanten Task erstellen für die Datenbank-Sicherung.

`%INST_NAME%\Tools\_START_Server.cmd` anpassen. Wenn Instanzen parallel laufen sollen, muss ggf. der -ip Parameter angegeben werden.






