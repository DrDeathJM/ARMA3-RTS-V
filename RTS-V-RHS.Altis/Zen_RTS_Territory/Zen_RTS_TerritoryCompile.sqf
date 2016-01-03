/**
    Zen_RTS_TerritoryCompile
    by Zenophon
    for RTS V

    This is the complete compiler for the Zen RTS Territory system.
    Run on all machines.
    Usage:
        call compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryCompile.sqf";
//*/

Zen_RTS_Territory_Data = [];

Zen_RTS_TerritoryManager= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryManager.sqf";
Zen_RTS_TerritoryEventCaptured= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryEventCaptured.sqf";

Zen_RTS_TerritoryUpdateVisual= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryUpdateVisual.sqf";
// Zen_RTS_TerritoryUpdateSubMarker = compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryUpdateSubMarker.sqf";

Zen_RTS_TerritoryCreate= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryCreate.sqf";
Zen_RTS_TerritoryRemove= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryRemove.sqf";
Zen_RTS_TerritoryUpdate= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryUpdate.sqf";

Zen_RTS_TerritoryGetData= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryGetData.sqf";
Zen_RTS_TerritorySearch= compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritorySearch.sqf";
