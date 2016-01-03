//camera friendly version of CreateSubspace2d
private ["_i", "_j", "_k", "_center", "_performanceCap", "_return", "_orgK"];
_k = [] + (_this select 0);
_orgK = [] + _k;
_center = [] + (_this select 1);
_performanceCap = 0.05;

//_k = vectorNormalized _k
if(isNil "iconObj") then
{
	iconObj = "logic" createVehicleLocal [0,0,0];
	iconObj setVariable ["PERM_OBJ", true];
	iconObj setPosATL _center;
	iconLastTime = diag_tickTime;
}
else
{
	if (diag_tickTime > (iconLastTime + _performanceCap)) then
	{
		iconObj setPosATL _center;
	};
};
//iconObj setVectorDir _k;

//iconObj setVectorDir (PCS_CAMERA_TOP vectorDiff PCS_CAMERA_CENTER);
//iconObj setVectorDirAndUp [[0,-1,0], _k]
//iconObj setVectorDirAndUp [(PCS_CAMERA_TOP vectorDiff PCS_CAMERA_CENTER), [0,0,-1]];
iconObj setVectorUp [0,0,1]; //the y axis will point in a camera friendly orientation
iconObj setVectorDir _k;
iconObj setVectorUp _k;
_i = ((iconObj modelToWorldVisual [1,0,0]) vectorDiff _center);
_j = ((iconObj modelToWorldVisual [0,1,0]) vectorDiff _center);
if (([0,0,-1] vectorCos _k) < 0) then
{
		_j = ([0,0,0] vectorDiff _j);
		_i = ([0,0,0] vectorDiff _i);
}
else
{
	if ((abs (_k select 2)) < 0.001) then
	{
		player sideChat "SINGULARITY";
		_k = vectorNormalized _orgK;
		_j = vectorNormalized ((positionCameraToWorld [0,1,0]) vectorDiff (positionCameraToWorld [0,0,0]));
		_i = [[(_k select 1), (-1) * (_k select 0), 0], [(-1) * (_k select 1), (_k select 0), 0]] select ((_k select 2) > (-0.001));
	};
};
_k = nil;
_center = nil;

_return = [_i, _j];
_return;