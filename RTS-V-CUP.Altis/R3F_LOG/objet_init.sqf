/**
 * Initialise un objet déplaçable/héliportable/remorquable/transportable
 * 
 * @param 0 l'objet
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_objet"];

_objet = _this select 0;

// Définition locale de la variable si elle n'est pas définie sur le réseau
if (isNil {_objet getVariable "R3F_LOG_est_transporte_par"}) then
{
	_objet setVariable ["R3F_LOG_est_transporte_par", objNull, false];
};

// Définition locale de la variable si elle n'est pas définie sur le réseau
if (isNil {_objet getVariable "R3F_LOG_est_deplace_par"}) then
{
	_objet setVariable ["R3F_LOG_est_deplace_par", objNull, false];
};

// Si on peut embarquer dans l'objet
if (isNumber (configfile >> "CfgVehicles" >> (typeOf _objet) >> "preciseGetInOut")) then
{
	// Ne pas monter dans un véhicule qui est en cours de transport
	_objet addEventHandler ["GetIn",
	{
		if (local (_this select 2)) then
		{
			_this spawn
			{
				sleep 0.1;
				if ((!(isNull (_this select 0 getVariable "R3F_LOG_est_deplace_par")) && (alive (_this select 0 getVariable "R3F_LOG_est_deplace_par")) && (isPlayer (_this select 0 getVariable "R3F_LOG_est_deplace_par"))) || !(isNull (_this select 0 getVariable "R3F_LOG_est_transporte_par"))) then
				{
					(_this select 2) action ["GetOut", _this select 0];
					(_this select 2) action ["Eject", _this select 0];
					if (player == _this select 2) then {systemChat format [STR_R3F_LOG_objet_en_cours_transport, getText (configFile >> "CfgVehicles" >> (typeOf (_this select 0)) >> "displayName")];};
				};
			};
		};
	}];
};

if ({_objet isKindOf _x} count R3F_LOG_CFG_can_be_moved_by_player > 0) then
{
	_objet addAction [("<t color=""#00eeff"">" + format [STR_R3F_LOG_action_deplacer_objet, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")] + "</t>"), {_this call R3F_LOG_FNCT_objet_deplacer}, false, 5, false, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_deplacer_objet_valide"];
};

if ({_objet isKindOf _x} count R3F_LOG_CFG_can_be_towed > 0) then
{
	if ({_objet isKindOf _x} count R3F_LOG_CFG_can_be_moved_by_player > 0) then
	{
		_objet addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_remorquer_deplace + "</t>"), {_this call R3F_LOG_FNCT_remorqueur_remorquer_deplace}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_joueur_deplace_objet == _target && R3F_LOG_action_remorquer_deplace_valide"];
	};
	
	_objet addAction [("<t color=""#00dd00"">" + format [STR_R3F_LOG_action_selectionner_objet_remorque, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")] + "</t>"), {_this call R3F_LOG_FNCT_remorqueur_selectionner_objet}, nil, 5, false, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_selectionner_objet_remorque_valide"];
	
	_objet addAction [("<t color=""#00dd00"">" + STR_R3F_LOG_action_detacher + "</t>"), {_this call R3F_LOG_FNCT_remorqueur_detacher}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_detacher_valide"];
};

if ({_objet isKindOf _x} count R3F_LOG_classes_objets_transportables > 0) then
{
	if ({_objet isKindOf _x} count R3F_LOG_CFG_can_be_moved_by_player > 0) then
	{
		_objet addAction [("<t color=""#dddd00"">" + STR_R3F_LOG_action_charger_deplace + "</t>"), {_this call R3F_LOG_FNCT_transporteur_charger_deplace}, nil, 6, true, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_joueur_deplace_objet == _target && R3F_LOG_action_charger_deplace_valide"];
	};
	
	_objet addAction [("<t color=""#dddd00"">" + format [STR_R3F_LOG_action_selectionner_objet_charge, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")] + "</t>"), {_this call R3F_LOG_FNCT_transporteur_selectionner_objet}, nil, 5, false, true, "", "!R3F_LOG_mutex_local_verrou && R3F_LOG_objet_addAction == _target && R3F_LOG_action_selectionner_objet_charge_valide"];
};