

////////////////////////////////////////
// Globale Optionen
////////////////////////////////////////

// Fahrzeug-Management aktiv?
PLAYZ_enableVehicleManagement=true;

// Löschen/Spawnen/Zerstören nur, wenn kein Spieler innerhalb x Meter
PLAYZ_playerDistance=1000;
//PLAYZ_playerDistance=30;

// Wartezeit zwischen den Durchläufen des Fahrzeug-Management
PLAYZ_waitTimeBeforeNextRun=300;
//PLAYZ_waitTimeBeforeNextRun=30;


////////////////////////////////////////
// Fahrzeuge zerstören
////////////////////////////////////////

// Fahrzeuge mit einer damage >=x werden ganz zerstört
PLAYZ_destroyVehiclesMoreDamaged=0.8;



////////////////////////////////////////
// Zerstörte Fahrzeuge löschen
////////////////////////////////////////

// Zerstörte Fahrzeuge nach x Sekunden löschen
PLAYZ_deleteDestroyedVehiclesAfter=21601; // 6h



////////////////////////////////////////
// Fehlende Fahrzeuge spawnen
////////////////////////////////////////

// Anzahl der maximal vorhandenen Fahrzeuge
PLAYZ_totalVehicles=200;

// Fahrzeugklassen, die in ihrer Anzahl limitiert sind
PLAYZ_limitedClasses = ["UH1H_DZ", "UH1H_2_DZ", "AH6X_DZ", "Mi17_DZ", "AN2_DZ", "AN2_2_DZ", "MH6J_DZ", "HMMWV_DZ", "SUV_DZ", "Offroad_DSHKM_INS", "Pickup_PK_INS"];
PLAYZ_classLimits    = [1        , 1          , 1        , 1        , 1       , 1         , 1        , 3         , 3       , 3                  , 3];


////////////////////////////////////////
// Statische spawns aktivieren. Die statischen Spawns sind im File playZ_spawnpoints.sqf vordefiniert.
PLAYZ_enableStaticSpawns=true;

// Vermisstes (weil gelöschtes) Fahrzeug nach x Sekunden wieder spawnen
//PLAYZ_respawnMissingVehicleAfter=60; // NICHT IMPLEMENTIERT //

// Static spawn nur, wenn anderes Fahrzeug innerhalb x Meter
PLAYZ_staticSpawnOtherVehicleDistance=25;

// Static spawn Fahrzeuge sind immer ohne loot
PLAYZ_staticSpawnAlwaysEmpty=true;

// Static spawn Fahrzeuge sind immer voll repariert
PLAYZ_staticSpawnFullyRepaired=false;

////////////////////////////////////////
// Dynamische spawns aktivieren.
// NOT IMPEMENTED!
/*
PLAYZ_enableDynamicSpawns=false;

// Dynamic spawn nur, wenn kein anderes Fahrzeug innerhalb x Meter
PLAYZ_dynamicSpawnOtherVehicleDistance=150;

// Fahrzeugklassen, die dynamisch gespawnt werden können
PLAYZ_dynamicVehicles = ["UAZ_Unarmed_TK_EP1", "UAZ_Unarmed_TK_CIV_EP1", "UAZ_Unarmed_UN_EP1", "UAZ_RU", "ATV_US_EP1", "ATV_CZ_EP1", "SkodaBlue", "Skoda", "SkodaGreen", "TT650_Ins", "TT650_TK_EP1", "TT650_TK_CIV_EP1", "Old_bike_TK_CIV_EP1", "Old_bike_TK_INS_EP1", "UH1H_DZ", "hilux1_civil_3_open", "Ikarus_TK_CIV_EP1", "Ikarus", "Tractor", "S1203_TK_CIV_EP1", "V3S_Civ", "UralCivil", "car_hatchback", "Volha_2_TK_CIV_EP1", "Volha_1_TK_CIV_EP1", "SUV_DZ", "car_sedan", "AH6X_DZ", "Mi17_DZ", "AN2_DZ", "AN2_2_DZ", "BAF_Offroad_D", "BAF_Offroad_W", "MH6J_DZ", "HMMWV_DZ", "Pickup_PK_INS", "Offroad_DSHKM_INS"];
*/





