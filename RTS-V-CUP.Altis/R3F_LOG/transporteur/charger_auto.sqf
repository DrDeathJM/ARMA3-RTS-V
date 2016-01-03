/**
 * Charger automatiquement l'objet en paramêtre dans un transporteur
 * Si le premier paramètre est un nom de classe, l'objet sera créé
 * 
 * @param 0 l'objet ou le nom de classe à charger
 * @param 1 le transporteur
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// Waiting for the mutex
waitUntil
{
	if (R3F_LOG_mutex_local_verrou) then
	{
		false
	}
	else
	{
		R3F_LOG_mutex_local_verrou = true;
		true
	}
};

private ["_objet", "_transporteur"];

_transporteur = _this select 1;

// S'assurer que l'objet à charger est transportable
if !({(_this select 0) isKindOf _x} count R3F_LOG_classes_objets_transportables > 0) exitWith
{
	private ["_classe"];
	
	_classe = if (typeName (_this select 0) == "STRING") then {_this select 0} else {typeOf (_this select 0)};
	
	diag_log format ["[Auto-load ""%1"" in ""%2""] : %3",
		getText (configFile >> "CfgVehicles" >> _classe >> "displayName"),
		getText (configFile >> "CfgVehicles" >> (typeOf _transporteur) >> "displayName"),
		"The object is not a transporable class."];
	
	systemChat format ["[Auto-load ""%1"" in ""%2""] : %3",
		getText (configFile >> "CfgVehicles" >> _classe >> "displayName"),
		getText (configFile >> "CfgVehicles" >> (typeOf _transporteur) >> "displayName"),
		"The object is not a transporable class."];
		
	R3F_LOG_mutex_local_verrou = false;
};

// Si l'objet à charger est donné en tant que nom de classe, on le crée
if (typeName (_this select 0) == "STRING") then
{
	private ["_classe", "_pos_degagee"];
	
	_classe = _this select 0;
	
	// Recherche d'une position dégagée. Les véhicules doivent être créé au niveau du sol sinon ils ne peuvent être utilisés.
	if (_classe isKindOf "AllVehicles") then
	{
		private ["_bbox", "_bbox_dim"];
		
		_bbox = [_classe] call R3F_LOG_FNCT_3D_get_bounding_box_depuis_classname;
		_bbox_dim = (vectorMagnitude (_bbox select 0)) max (vectorMagnitude (_bbox select 1));
		
		_pos_degagee = [_bbox_dim, getPos _transporteur, 200, 50] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
	}
	else
	{
		_pos_degagee = call R3F_LOG_FNCT_3D_tirer_position_degagee_ciel;
	};
	
	if (count _pos_degagee == 0) then {_pos_degagee = getPosATL _transporteur;};
	
	_objet = _classe createVehicle _pos_degagee;
	_objet setVectorDirAndUp [[-cos getDir _transporteur, sin getDir _transporteur, 0] vectorCrossProduct surfaceNormal _pos_degagee, surfaceNormal _pos_degagee];
	_objet setVelocity [0, 0, 0];
}
else
{
	_objet = _this select 0;
};

// S'assurer que l'objet ne soit pas désactivé par ailleurs
_objet setVariable ["R3F_LOG_disabled", false, true];

if (!isNull _objet) then
{
	// Vérifier qu'il n'est pas déjà transporté
	if (isNull (_objet getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
		(isNull (_objet getVariable ["R3F_LOG_est_deplace_par", objNull]) || (!alive (_objet getVariable ["R3F_LOG_est_deplace_par", objNull])) || (!isPlayer (_objet getVariable ["R3F_LOG_est_deplace_par", objNull])))
	) then
	{
		if (isNull (_objet getVariable ["R3F_LOG_remorque", objNull])) then
		{
			private ["_objets_charges", "_chargement", "_cout_chargement_objet"];
			
			_chargement = [_transporteur] call R3F_LOG_FNCT_calculer_chargement_vehicule;
			_cout_chargement_objet = [_objet] call R3F_LOG_FNCT_determiner_cout_chargement;
			
			// Si l'objet loge dans le véhicule
			if ((_chargement select 0) + _cout_chargement_objet <= (_chargement select 1)) then
			{
				// On mémorise sur le réseau le nouveau contenu du véhicule
				_objets_charges = _transporteur getVariable ["R3F_LOG_objets_charges", []];
				_objets_charges = _objets_charges + [_objet];
				_transporteur setVariable ["R3F_LOG_objets_charges", _objets_charges, true];
				
				_objet setVariable ["R3F_LOG_est_transporte_par", _transporteur, true];
				
				_objet attachTo [R3F_LOG_PUBVAR_point_attache, call R3F_LOG_FNCT_3D_tirer_position_degagee_ciel];
			}
			else
			{
				diag_log format ["[Auto-load ""%1"" in ""%2""] : %3",
					getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName"),
					getText (configFile >> "CfgVehicles" >> (typeOf _transporteur) >> "displayName"),
					STR_R3F_LOG_action_charger_pas_assez_de_place];
				
				systemChat format ["[Auto-load ""%1"" in ""%2""] : %3",
					getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName"),
					getText (configFile >> "CfgVehicles" >> (typeOf _transporteur) >> "displayName"),
					STR_R3F_LOG_action_charger_pas_assez_de_place];
				
				if (typeName (_this select 0) == "STRING") then
				{
					deleteVehicle _objet;
				};
			};
		}
		else
		{
			systemChat format [STR_R3F_LOG_objet_remorque_en_cours, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
		};
	}
	else
	{
		diag_log format [STR_R3F_LOG_objet_en_cours_transport, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
		systemChat format [STR_R3F_LOG_objet_en_cours_transport, getText (configFile >> "CfgVehicles" >> (typeOf _objet) >> "displayName")];
	};
};

R3F_LOG_mutex_local_verrou = false;