/**
 * Evalue régulièrement les conditions à vérifier pour autoriser les actions logistiques
 * Permet de diminuer la fréquence des vérifications des conditions normalement faites
 * dans les addAction (~60Hz) et donc de limiter la consommation CPU.
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

private ["_joueur", "_vehicule_joueur", "_cursorTarget_distance", "_objet_pointe", "_objet_pointe_autre_que_deplace", "_objet_pas_en_cours_de_deplacement"];

sleep 2;

while {true} do
{
	_joueur = player;
	_vehicule_joueur = vehicle _joueur;
	
	_cursorTarget_distance = call R3F_LOG_FNCT_3D_cursorTarget_distance_bbox;
	_objet_pointe = _cursorTarget_distance select 0;
	
	if (call compile R3F_LOG_CFG_string_condition_allow_logistics_on_this_client &&
		!R3F_LOG_mutex_local_verrou && _vehicule_joueur == _joueur && !isNull _objet_pointe && _cursorTarget_distance select 1 < 3.75
	) then
	{
		R3F_LOG_objet_addAction = _objet_pointe;
		
		_objet_pointe_autre_que_deplace = [R3F_LOG_joueur_deplace_objet, 3.75] call R3F_LOG_FNCT_3D_cursorTarget_virtuel;
		
		_objet_pas_en_cours_de_deplacement = (isNull (_objet_pointe getVariable ["R3F_LOG_est_deplace_par", objNull]) ||
			{(!alive (_objet_pointe getVariable "R3F_LOG_est_deplace_par")) || (!isPlayer (_objet_pointe getVariable "R3F_LOG_est_deplace_par"))});
		
		// Si l'objet est un objet déplaçable
		if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_can_be_moved_by_player > 0) then
		{
			// Condition action deplacer_objet
			R3F_LOG_action_deplacer_objet_valide = (count crew _objet_pointe == 0) && (isNull R3F_LOG_joueur_deplace_objet) &&
				_objet_pas_en_cours_de_deplacement && isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") && !(_objet_pointe getVariable "R3F_LOG_disabled");
		};
		
		// Si l'objet est un objet remorquable
		if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_can_be_towed > 0) then
		{
			// Et qu'il est déplaçable
			if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_can_be_moved_by_player > 0) then
			{
				// Condition action remorquer_deplace
				R3F_LOG_action_remorquer_deplace_valide = !(_objet_pointe getVariable "R3F_LOG_disabled") && (count crew _objet_pointe == 0) &&
					(R3F_LOG_joueur_deplace_objet == _objet_pointe) && !isNull _objet_pointe_autre_que_deplace &&
					{
						{_objet_pointe_autre_que_deplace isKindOf _x} count R3F_LOG_CFG_can_tow > 0 && alive _objet_pointe_autre_que_deplace &&
						isNull (_objet_pointe_autre_que_deplace getVariable "R3F_LOG_est_transporte_par") && isNull (_objet_pointe_autre_que_deplace getVariable "R3F_LOG_remorque") &&
						(vectorMagnitude velocity _objet_pointe_autre_que_deplace < 6) && !(_objet_pointe_autre_que_deplace getVariable "R3F_LOG_disabled")
					};
			};
			
			// Condition action selectionner_objet_remorque
			R3F_LOG_action_selectionner_objet_remorque_valide = (count crew _objet_pointe == 0) &&
				isNull R3F_LOG_joueur_deplace_objet && isNull R3F_LOG_objet_selectionne &&
				isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") && isNull (_objet_pointe getVariable ["R3F_LOG_remorque", objNull]) && 
				_objet_pas_en_cours_de_deplacement && !(_objet_pointe getVariable "R3F_LOG_disabled");
			
			// Condition action detacher
			R3F_LOG_action_detacher_valide = (isNull R3F_LOG_joueur_deplace_objet) &&
				!isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") && !(_objet_pointe getVariable "R3F_LOG_disabled");
		};
		
		// Si l'objet est un objet transportable
		if ({_objet_pointe isKindOf _x} count R3F_LOG_classes_objets_transportables > 0) then
		{
			// Et qu'il est déplaçable
			if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_can_be_moved_by_player > 0) then
			{
				// Condition action charger_deplace
				R3F_LOG_action_charger_deplace_valide = (count crew _objet_pointe == 0) && (R3F_LOG_joueur_deplace_objet == _objet_pointe) &&
					!(_objet_pointe getVariable "R3F_LOG_disabled") && !isNull _objet_pointe_autre_que_deplace &&
					{
						{_objet_pointe_autre_que_deplace isKindOf _x} count R3F_LOG_classes_transporteurs > 0 &&
						alive _objet_pointe_autre_que_deplace && (vectorMagnitude velocity _objet_pointe_autre_que_deplace < 6) &&
						!(_objet_pointe_autre_que_deplace getVariable "R3F_LOG_disabled")
					};
			};
			
			// Condition action selectionner_objet_charge
			R3F_LOG_action_selectionner_objet_charge_valide = (count crew _objet_pointe == 0) && isNull R3F_LOG_joueur_deplace_objet &&
				isNull R3F_LOG_objet_selectionne && isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") &&
				_objet_pas_en_cours_de_deplacement && !(_objet_pointe getVariable "R3F_LOG_disabled");
		};
		
		// Si l'objet est un véhicule remorqueur
		if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_can_tow > 0) then
		{
			// Condition action remorquer_deplace
			R3F_LOG_action_remorquer_deplace_valide = (alive _objet_pointe) && (!isNull R3F_LOG_joueur_deplace_objet) &&
				!(R3F_LOG_joueur_deplace_objet getVariable "R3F_LOG_disabled") && (R3F_LOG_joueur_deplace_objet != _objet_pointe) &&
				({R3F_LOG_joueur_deplace_objet isKindOf _x} count R3F_LOG_CFG_can_be_towed > 0) &&
				isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") &&
				isNull (_objet_pointe getVariable "R3F_LOG_remorque") && (vectorMagnitude velocity _objet_pointe < 6) &&
				!(_objet_pointe getVariable "R3F_LOG_disabled");
			
			// Condition action remorquer_selection
			R3F_LOG_action_remorquer_selection_valide = (alive _objet_pointe) && (isNull R3F_LOG_joueur_deplace_objet) &&
				(!isNull R3F_LOG_objet_selectionne) && (R3F_LOG_objet_selectionne != _objet_pointe) &&
				!(R3F_LOG_objet_selectionne getVariable "R3F_LOG_disabled") &&
				({R3F_LOG_objet_selectionne isKindOf _x} count R3F_LOG_CFG_can_be_towed > 0) &&
				isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") &&
				isNull (_objet_pointe getVariable "R3F_LOG_remorque") && (vectorMagnitude velocity _objet_pointe < 6) &&
				!(_objet_pointe getVariable "R3F_LOG_disabled");
		};
		
		// Si l'objet est un véhicule transporteur
		if ({_objet_pointe isKindOf _x} count R3F_LOG_classes_transporteurs > 0) then
		{
			// Condition action charger_deplace
			R3F_LOG_action_charger_deplace_valide = alive _objet_pointe && (!isNull R3F_LOG_joueur_deplace_objet) &&
				!(R3F_LOG_joueur_deplace_objet getVariable "R3F_LOG_disabled") && (R3F_LOG_joueur_deplace_objet != _objet_pointe) &&
				({R3F_LOG_joueur_deplace_objet isKindOf _x} count R3F_LOG_classes_objets_transportables > 0) &&
				(vectorMagnitude velocity _objet_pointe < 6) && !(_objet_pointe getVariable "R3F_LOG_disabled");
			
			// Condition action charger_selection
			R3F_LOG_action_charger_selection_valide = alive _objet_pointe && (isNull R3F_LOG_joueur_deplace_objet) &&
				(!isNull R3F_LOG_objet_selectionne) && (R3F_LOG_objet_selectionne != _objet_pointe) &&
				!(R3F_LOG_objet_selectionne getVariable "R3F_LOG_disabled") &&
				({R3F_LOG_objet_selectionne isKindOf _x} count R3F_LOG_classes_objets_transportables > 0) &&
				(vectorMagnitude velocity _objet_pointe < 6) && !(_objet_pointe getVariable "R3F_LOG_disabled");
			
			// Condition action contenu_vehicule
			R3F_LOG_action_contenu_vehicule_valide = alive _objet_pointe && (isNull R3F_LOG_joueur_deplace_objet) && isNull R3F_LOG_objet_selectionne &&
				(vectorMagnitude velocity _objet_pointe < 6) && !(_objet_pointe getVariable "R3F_LOG_disabled");
		};
		
		// Condition action ouvrir_usine
		R3F_LOG_action_ouvrir_usine_valide = call compile R3F_LOG_CFG_string_condition_allow_creation_factory_on_this_client &&
			isNull R3F_LOG_joueur_deplace_objet && !(_objet_pointe getVariable "R3F_LOG_CF_disabled") && alive _objet_pointe &&
			_objet_pointe getVariable ["R3F_LOG_CF_side_addAction", side group _joueur] == side group _joueur;
	}
	else
	{
		R3F_LOG_action_deplacer_objet_valide = false;
		R3F_LOG_action_selectionner_objet_remorque_valide = false;
		R3F_LOG_action_detacher_valide = false;
		R3F_LOG_action_selectionner_objet_charge_valide = false;
		R3F_LOG_action_remorquer_deplace_valide = false;
		R3F_LOG_action_remorquer_selection_valide = false;
		R3F_LOG_action_charger_deplace_valide = false;
		R3F_LOG_action_charger_selection_valide = false;
		R3F_LOG_action_contenu_vehicule_valide = false;
		R3F_LOG_action_ouvrir_usine_valide = false;
	};
	
	// Si le joueur est pilote dans un héliporteur
	if (call compile R3F_LOG_CFG_string_condition_allow_logistics_on_this_client &&
		!R3F_LOG_mutex_local_verrou && _vehicule_joueur != _joueur && driver _vehicule_joueur == _joueur && {{_vehicule_joueur isKindOf _x} count R3F_LOG_CFG_can_lift > 0}
	) then
	{
		R3F_LOG_objet_addAction = _vehicule_joueur;
		
		// Condition action heliporter
		R3F_LOG_action_heliporter_valide = !(_vehicule_joueur getVariable "R3F_LOG_disabled") &&
			isNull (_vehicule_joueur getVariable "R3F_LOG_heliporte") && (vectorMagnitude velocity _vehicule_joueur < 6) &&
			{
				{_x != _vehicule_joueur && !(_x getVariable "R3F_LOG_disabled") &&
				((getPosASL _vehicule_joueur select 2) - (getPosASL _x select 2) > 2 && (getPosASL _vehicule_joueur select 2) - (getPosASL _x select 2) < 15)
			} count (nearestObjects [_vehicule_joueur, R3F_LOG_CFG_can_be_lifted, 15]) > 0};
		
		// Condition action heliport_larguer
		R3F_LOG_action_heliport_larguer_valide = !isNull (_vehicule_joueur getVariable "R3F_LOG_heliporte") && !(_vehicule_joueur getVariable "R3F_LOG_disabled") &&
			(vectorMagnitude velocity _vehicule_joueur < 25) && ((getPosASL _vehicule_joueur select 2) - (0 max getTerrainHeightASL getPos _vehicule_joueur) < 40);
	}
	else
	{
		R3F_LOG_action_heliporter_valide = false;
		R3F_LOG_action_heliport_larguer_valide = false;
	};
	
	sleep 0.4;
};