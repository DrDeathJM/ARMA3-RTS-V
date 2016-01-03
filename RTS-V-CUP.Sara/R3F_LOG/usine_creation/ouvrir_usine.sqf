/**
 * Ouvre la boîte de dialogue du contenu de l'usine
 * 
 * @param 0 l'usine qu'il faut ouvrir
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "dlg_constantes.h"

disableSerialization; // A cause des displayCtrl

private ["_usine", "_credits_usine", "_dlg_liste_objets", "_ctrl_liste_categories", "_sel_categorie"];

R3F_LOG_objet_selectionne = objNull;

_usine = _this select 0;
uiNamespace setVariable ["R3F_LOG_dlg_LO_usine", _usine];

call R3F_LOG_VIS_FNCT_demarrer_visualisation;

// Pré-calculer une fois pour toutes les usines la liste des objets du CfgVehicles classés par catégorie
if (isNil {_usine getVariable "R3F_LOG_cfgVehicles_par_categories"}) then
{
	private ["_cfgVehicles_categories", "_cfgVehicles_par_categories", "_nb_config", "_categorie", "_idx_categorie", "_idx_config", "_config"];
	_cfgVehicles_categories = [];
	_cfgVehicles_par_categories = [];
	
	// Récupération de la liste des catégories de véhicules
	_nb_config = count (configFile >> "CfgVehicleClasses");
	for [{_idx_config = 0}, {_idx_config < _nb_config}, {_idx_config = _idx_config+1}] do
	{
		_config = (configFile >> "CfgVehicleClasses") select _idx_config;
		if (isClass _config) then
		{
			// Si la catégorie est autorisé (en fonction de la white ou black list)
			if ((_usine getVariable "R3F_LOG_CF_blackwhitelist_mode" == "white") isEqualTo (configName _config in (_usine getVariable "R3F_LOG_CF_blackwhitelist_categories"))) then
			{
				_cfgVehicles_categories = _cfgVehicles_categories + [configName _config];
				_cfgVehicles_par_categories = _cfgVehicles_par_categories + [[]];
			};
		};
	};
	
	// Création de la liste des véhicules, classés par catégorie
	_nb_config = count (configFile >> "CfgVehicles");
	for [{_idx_config = 0}, {_idx_config < _nb_config}, {_idx_config = _idx_config+1}] do
	{
		_config = (configFile >> "CfgVehicles") select _idx_config;
		if (isClass _config) then
		{
			// Objet instanciable
			if (getNumber (_config >> "scope") == 2 && !(configName _config isKindOf "Man")) then
			{
				// Si l'objet correspond à une side valide
				if (getNumber (_config >> "side") in (_usine getVariable "R3F_LOG_CF_num_sides")) then
				{
					_categorie = getText (_config >> "vehicleClass");
					_idx_categorie = _cfgVehicles_categories find _categorie;
					
					if (_idx_categorie != -1) then
					{
						(_cfgVehicles_par_categories select _idx_categorie) set [count (_cfgVehicles_par_categories select _idx_categorie), configName _config];
					};
				};
			};
		};
	};
	
	// Suppression des catégories ne possédant aucun objet
	_tmp_cfgVehicles_categories = [];
	_tmp_cfgVehicles_par_categories = [];
	{
		if (count (_cfgVehicles_par_categories select _forEachIndex) > 0) then
		{
			_tmp_cfgVehicles_categories = _tmp_cfgVehicles_categories + [_x];
			_tmp_cfgVehicles_par_categories = _tmp_cfgVehicles_par_categories + [_cfgVehicles_par_categories select _forEachIndex];
		};
	} forEach _cfgVehicles_categories;
	
	_usine setVariable ["R3F_LOG_CF_cfgVehicles_categories", + _tmp_cfgVehicles_categories];
	_usine setVariable ["R3F_LOG_CF_cfgVehicles_par_categories", + _tmp_cfgVehicles_par_categories];
};

createDialog "R3F_LOG_dlg_liste_objets";
_dlg_liste_objets = findDisplay R3F_LOG_IDD_dlg_liste_objets;

/**** DEBUT des traductions des labels ****/
(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_titre) ctrlSetText STR_R3F_LOG_dlg_LO_titre;
(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_btn_creer) ctrlSetText STR_R3F_LOG_dlg_LO_btn_creer;
(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_btn_fermer) ctrlSetText STR_R3F_LOG_dlg_LO_btn_fermer;
(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_infos_titre) ctrlSetText STR_R3F_LOG_nom_fonctionnalite_proprietes;
/**** FIN des traductions des labels ****/

_ctrl_liste_categories = _dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_liste_categories;
_sel_categorie = 0 max (_usine getVariable "R3F_LOG_CF_mem_idx_categorie");

// Insertion de chaque catégories disponibles dans la liste
{
	private ["_categorie", "_config", "_nom"];
	
	_categorie = _x;
	_config = configFile >> "CfgVehicleClasses" >> _categorie;
	_nom = getText (_config >> "displayName");
	
	_index = _ctrl_liste_categories lbAdd format ["%1", _nom];
	_ctrl_liste_categories lbSetData [_index, _categorie];
} forEach (_usine getVariable "R3F_LOG_CF_cfgVehicles_categories");

_ctrl_liste_categories lbSetCurSel _sel_categorie;

while {!isNull _dlg_liste_objets} do
{
	_credits_usine = _usine getVariable "R3F_LOG_CF_credits";
	
	// Activer le bouton de création que s'il y a assez de crédits
	(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_btn_creer) ctrlEnable (_credits_usine != 0);
	
	if (_credits_usine == -1) then
	{
		(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_credits_restants) ctrlSetText (format [STR_R3F_LOG_dlg_LO_credits_restants, "unlimited"]);
	}
	else
	{
		(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_credits_restants) ctrlSetText (format [STR_R3F_LOG_dlg_LO_credits_restants, _credits_usine]);
	};
	
	// Afficher les infos de l'objet
	if (lbCurSel R3F_LOG_IDC_dlg_LO_liste_objets != -1) then
	{
		(_dlg_liste_objets displayCtrl R3F_LOG_IDC_dlg_LO_infos) ctrlSetStructuredText ([lbData [R3F_LOG_IDC_dlg_LO_liste_objets, lbCurSel R3F_LOG_IDC_dlg_LO_liste_objets]] call R3F_LOG_FNCT_formater_fonctionnalites_logistique);
	};
	
	// Fermer la boîte de dialogue si l'usine n'est plus accessible
	if (!alive _usine || (_usine getVariable "R3F_LOG_CF_disabled")) then
	{
		closeDialog 0;
	};
	
	sleep 0.15;
};

call R3F_LOG_VIS_FNCT_terminer_visualisation;