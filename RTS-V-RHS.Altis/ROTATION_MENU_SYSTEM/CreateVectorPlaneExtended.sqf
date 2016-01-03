private ["_k", "_j", "_center", "_return", "_performance"];
_center = _this select 2;
_performance = 0.05;
_k = vectorNormalized (_this select 0);
_j = vectorNormalized (_this select 1);
RTMS_CreateVectorPlaneExtended_SNS setVectorDirAndUp [_k, _j];
if (!((RTMS_CreateVectorPlaneExtended_SNS getVariable "LAST_POS") isEqualTo _center)) then
{
		RTMS_CreateVectorPlaneExtended_SNS setPosATL _center;
		RTMS_CreateVectorPlaneExtended_SNS setVariable ["LAST_POS", _center];
};
	
RTMS_CreateVectorPlaneExtended_SNS setVectorDirAndUp [_k, _j];
_return = [vectorNormalized ((RTMS_CreateVectorPlaneExtended_SNS modelToWorldVisual [-1,0,0]) vectorDiff _center), _j, _k];
_return;
