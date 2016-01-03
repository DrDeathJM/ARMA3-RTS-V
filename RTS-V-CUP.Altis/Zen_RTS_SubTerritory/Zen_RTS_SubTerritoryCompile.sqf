/**
    Zen_RTS_SubTerritoryCompile
    by Zenophon
    for RTS V

    This is the complete compiler for the Zen RTS Sub-Territory system.
    Run on all machines.
    Usage:
        call compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryCompile.sqf";
//*/

Zen_RTS_SubTerritory_Data = [];

Zen_RTS_SubTerritoryManager= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryManager.sqf";
Zen_RTS_SubTerritoryEventCaptured= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryEventCaptured.sqf";

Zen_RTS_SubTerritoryUpdateVisual= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryUpdateVisual.sqf";
Zen_RTS_SubTerritoryCreate= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryCreate.sqf";
// Zen_RTS_SubTerritoryRemove= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryRemove.sqf";
Zen_RTS_SubTerritoryUpdate= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryUpdate.sqf";

Zen_RTS_SubTerritoryGetData= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryGetData.sqf";
Zen_RTS_SubTerritorySearch= compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritorySearch.sqf";
