rts_debug = true;
mapDebug = true;
param3 = 0;
// StopMsg = false;
ShowStats = false;
Dedicated = isDedicated;
// Hosted = isMultiplayer && !(isDedicated);
ColorCivilian = "ColorCivilian";
// ListFlag6 = ListFlag7;
// updbg = false;
// WestGearLevel1 = [];
// WestPrimaryLevel1 = [];
// WestPrimaryLevel3 = [];
// arms_refresh = true;
// noBuildZone = [];

aiLimit = 10;
// rts_unitnum = 0;
// WestSoldiers = [];

// vd = 500;
// oilWest = 1;
// oreWest = 1;
// energyWest = 1;

// oilEast = 1;
// oreEast = 1;
// energyEast = 1;

// WestBaseUnits = 0;
// EastBaseUnits = 0;

// Westtransport1  = [];
// Easttransport1  = [];
// WestLightGround = [];
// EastLightGround = [];
// Westair4        = [];
// Eastair4        = [];
// Westair5        = [];
// Eastair5        = [];
// Westair6        = [];
// Eastair6        = [];
// WestAllGround   = [];
// WestAllAir      = [];
// AllGround       = [];
// WestMedium1     = [];
// EastMedium1     = [];
// WestSupport     = [];
// EastSupport     = [];
// WestAAA         = [];
// EastAAA         = [];
// WestHeavyGround = [];
// EastHeavyGround = [];

// These variable set all build queue info.  Forward base variables are initialized in the territory monitor file.
// rts_maxQueueSize = 10;

// WestBarracksQActive = FALSE;
// WestLightFacQActive = FALSE;
// WestHeavyFacQActive = FALSE;
// WestAirFacQActive = FALSE;

// EastBarracksQActive = FALSE;
// EastLightFacQActive = FALSE;
// EastHeavyFacQActive = FALSE;
// EastAirFacQActive = FALSE;

// WestBarracksQNum = 0;
// WestLightFacQNum = 0;
// WestHeavyFacQNum = 0;
// WestAirFacQNum = 0;

// EastBarracksQNum = 0;
// EastLightFacQNum = 0;
// EastHeavyFacQNum = 0;
// EastAirFacQNum = 0;

// Upgrade Variables
// WestBarracksLevel = 0;
// WestLightFacLevel = 0;
// WestHeavyFacLevel = 0;
// WestAirFacLevel = 0;
// WestForwardBaseLevel = 0;
// WestGearLevel = 1;

// EastBarracksLevel = 0;
// EastLightFacLevel = 0;
// EastHeavyFacLevel = 0;
// EastAirFacLevel = 0;
// EastForwardBaseLevel = 0;
// EastGearLevel = 1;

rts_hq = [SIDE Player,"HQ"];

//--- Non-dedicated Client Variables.
if !(isDedicated) then {
    call compile format ["xp%1 = 0",Player];
    // sideID = (side player) Call GetSideID;
    // clientID = player Call GetClientID;
    // clientTeam = group player;
    // clientTeams = (Format["WFBE_%1TEAMS", str side player] Call GetNamespace);
    // playerType = typeOf player;
    // rts_camSides = [SIDE player];
};

GUER = Independent;
CIV = CIVILIAN;
undefined_var = "scalar bool array string 0xe0ffffef";
undefined_any = "any";

rts_Initialized = FALSE;
rts_arrays_initialized = FALSE;
// rts_PlayerInit = FALSE;

// rts_buildDistLimit = 800;
// rts_viewdistanceindex = 0;
// customSquadSizeLimit = 15;

// Vars if the player wants manned vehicles to have gunners/commanders/driver
// rts_driver = true;
// rts_gunner = true;
// rts_commander = true;

rts_killedSld = ["killed",{_this execVM "rts-event-RemoveDeadEH.sqf"}];
// rts_killedBase = ["killed",{_this execVM "rts-event-baseKilledEH.sqf"}];
rts_killedRsc = ["killed",{_this exec "rts-event-resourceKilled.sqs"}];

// Amount of time til player can re-deploy - set in description.ext parameters
rts_playerRespawnDelay = 0;

// Economy
// rts_moneyMonitorActive = FALSE;
idMoney = 1037;
idSupply = 1038;
idFPS = 666;
// SupplyFactor - Increases with level of captured territories and increases supply income
// WestSupplyFactor = 0;
// EastSupplyFactor = 0;
// CIVSupplyFactor = 0;

if (rts_debug) then {
    playerMoney = 100000;
    Eastsupply = 100000;
    WestSupply = 100000;
};

Zen_RTS_Show_Preview = false;
