/**
 * Remorque l'objet déplacé par le joueur avec un remorqueur
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (R3F_LOG_mutex_local_verrou) then
{
	systemChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;
	
	private ["_objet", "_remorqueur"];
	
	_objet = R3F_LOG_joueur_deplace_objet;
	_remorqueur = [_objet, 5] call R3F_LOG_FNCT_3D_cursorTarget_virtuel;
	
	if (!isNull _remorqueur && {
		{_remorqueur isKindOf _x} count R3F_LOG_CFG_can_tow > 0 && alive _remorqueur && isNull (_remorqueur getVariable "R3F_LOG_remorque") &&
		(vectorMagnitude velocity _remorqueur < 6) && !(_remorqueur getVariable "R3F_LOG_disabled")
	}) then
	{
		_remorqueur setVariable ["R3F_LOG_remorque", _objet, true];
		_objet setVariable ["R3F_LOG_est_transporte_par", _remorqueur, true];
		
		// On place le joueur sur le côté du véhicule en fonction qu'il se trouve à sa gauche ou droite
		if ((_remorqueur worldToModel (player modelToWorld [0,0,0])) select 0 > 0) then
		{
			player attachTo [_remorqueur, [
				(boundingBoxReal _remorqueur select 1 select 0) + 0.5,
				(boundingBoxReal _remorqueur select 0 select 1),
				(boundingBoxReal _remorqueur select 0 select 2) - (boundingBoxReal player select 0 select 2)
			]];
			
			player setDir 270;
		}
		else
		{
			player attachTo [_remorqueur, [
				(boundingBoxReal _remorqueur select 0 select 0) - 0.5,
				(boundingBoxReal _remorqueur select 0 select 1),
				(boundingBoxReal _remorqueur select 0 select 2) - (boundingBoxReal player select 0 select 2)
			]];
			
			player setDir 90;
		};
		
		// Faire relacher l'objet au joueur
		R3F_LOG_joueur_deplace_objet = objNull;
		
		player playMove format ["AinvPknlMstpSlay%1Dnon_medic", switch (currentWeapon player) do
		{
			case "": {"Wnon"};
			case primaryWeapon player: {"Wrfl"};
			case secondaryWeapon player: {"Wlnr"};
			case handgunWeapon player: {"Wpst"};
			default {"Wrfl"};
		}];
		sleep 2;
		
		// Attacher à l'arrière du véhicule au ras du sol
		_objet attachTo [_remorqueur, [
			(boundingCenter _objet select 0),
			(boundingBoxReal _remorqueur select 0 select 1) + (boundingBoxReal _objet select 0 select 1),
			(boundingBoxReal _remorqueur select 0 select 2) - (boundingBoxReal _objet select 0 select 2)
		]];
		
		detach player;
		
		// Si l'objet est une arme statique, on corrige l'orientation en fonction de la direction du canon
		if (_objet isKindOf "StaticWeapon") then
		{
			private ["_azimut_canon"];
			
			_azimut_canon = ((_objet weaponDirection (weapons _objet select 0)) select 0) atan2 ((_objet weaponDirection (weapons _objet select 0)) select 1);
			
			// Seul le D30 a le canon pointant vers le véhicule
			/* Obsolète pour l'instant (A2)
			if !(_objet isKindOf "D30_Base") then
			{
				_azimut_canon = _azimut_canon + 180;
			};*/
			
			[_objet, "setDir", (getDir _objet)-_azimut_canon] call R3F_LOG_FNCT_exec_commande_MP;
		};
		
		sleep 8;
	};
	
	R3F_LOG_mutex_local_verrou = false;
};