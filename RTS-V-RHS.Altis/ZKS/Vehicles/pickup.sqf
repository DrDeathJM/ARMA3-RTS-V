_veh = vehicle cursorTarget;
_player = player;


if (local _veh) then {_player assignAsCargo _veh;[_player] orderGetIn true;_veh domove position _player;}else{


				_ordercode = {
				private ["_veh","_player"];
				_veh = _this select 0;
				_player = _this select 1;
				_player assignAsCargo _veh;
				[_player] orderGetIn true;
				_veh domove position _player;
				_veh setvariable ["patrol",position _player,false];
				};
				serverorders = [_veh,_player,_ordercode];

publicVariableServer "serverorders";
};