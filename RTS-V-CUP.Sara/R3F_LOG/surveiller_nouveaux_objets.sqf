/**
 * Recherche périodiquement les nouveaux objets pour leur ajouter les fonctionnalités de logistique si besoin
 * Script à faire tourner dans un fil d'exécution dédié
 * 
 * Copyright (C) 2014 Team ~R3F~
 * 
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

sleep 2;

private ["_compteur_cyclique", "_liste_nouveaux_objets", "_liste_vehicules_connus", "_liste_statiques",
	"_liste_nouveaux_statiques", "_liste_statiques_connus", "_liste_statiques_cycle_precedent", "_count_liste_objets", "_i"];

// Contiendra la liste des objets déjà parcourus récupérés avec la commande "vehicles"
_liste_vehicules_connus = [];
// Contiendra la liste des objets dérivant de "Static" (caisse de mun, drapeau, ...) déjà parcourus récupérés avec la commande "nearestObjects"
_liste_statiques_connus = [];
// Contiendra la liste des objets "Static" récupérés lors du tour de boucle précécent (optimisation des opérations sur les tableaux)
_liste_statiques_cycle_precedent = [];

// Période de recherche des objets dérivant de "Static"
#define __tempo 3
// Utiliser la commande vehicles une fois tout les X cycles de période __tempo
#define __nb_cycles_commande_vehicles 4

_compteur_cyclique = 0;

while {true} do
{
	if (!isNull player) then
	{
		// Tout les __nb_cycles_commande_vehicles ou sur ordre, on récupère les nouveaux véhicules du jeu
		if (_compteur_cyclique == 0 || R3F_LOG_PUBVAR_nouvel_objet_a_initialiser) then
		{
			R3F_LOG_PUBVAR_nouvel_objet_a_initialiser = false; // Acquittement local
			
			_liste_nouveaux_objets = vehicles - _liste_vehicules_connus;
			_liste_vehicules_connus = _liste_vehicules_connus + _liste_nouveaux_objets;
		}
		else
		{
			_liste_nouveaux_objets = [];
		};
		_compteur_cyclique = (_compteur_cyclique + 1) mod __nb_cycles_commande_vehicles;
		
		// En plus des nouveaux véhicules, on récupère les statiques (caisse de mun, drapeau, ...) proches du joueur non connus
		// Optimisation "_liste_statiques_cycle_precedent" : et qui n'étaient pas proches du joueur au cycle précédent
		_liste_statiques = nearestObjects [player, ["Static"], 50];
		_liste_nouveaux_statiques = _liste_statiques - _liste_statiques_cycle_precedent - _liste_statiques_connus;
		_liste_statiques_connus = _liste_statiques_connus + _liste_nouveaux_statiques;
		_liste_statiques_cycle_precedent = _liste_statiques;
		
		_liste_nouveaux_objets = _liste_nouveaux_objets + _liste_nouveaux_statiques;
		_count_liste_objets = count _liste_nouveaux_objets;
		
		if (_count_liste_objets > 0) then
		{
			// On parcoure tous les nouveaux objets en __tempo secondes
			for [{_i = 0}, {_i < _count_liste_objets}, {_i = _i + 1}] do
			{
				private ["_objet", "_au_moins_une_categorie"];
				
				_objet = _liste_nouveaux_objets select _i;
				_au_moins_une_categorie = false;
				
				// Si l'objet est un objet déplaçable/héliportable/remorquable/transportable
				if ({_objet isKindOf _x} count R3F_LOG_objets_depl_heli_remorq_transp > 0) then
				{
					[_objet] call R3F_LOG_FNCT_objet_init;
					_au_moins_une_categorie = true;
				};
				
				// Si l'objet est un véhicule héliporteur
				if ({_objet isKindOf _x} count R3F_LOG_CFG_can_lift > 0) then
				{
					[_objet] call R3F_LOG_FNCT_heliporteur_init;
					_au_moins_une_categorie = true;
				};
				
				// Si l'objet est un véhicule remorqueur
				if ({_objet isKindOf _x} count R3F_LOG_CFG_can_tow > 0) then
				{
					[_objet] call R3F_LOG_FNCT_remorqueur_init;
					_au_moins_une_categorie = true;
				};
				
				// Si l'objet est un véhicule transporteur
				if ({_objet isKindOf _x} count R3F_LOG_classes_transporteurs > 0) then
				{
					[_objet] call R3F_LOG_FNCT_transporteur_init;
					_au_moins_une_categorie = true;
				};
				
				if (_au_moins_une_categorie) then
				{
					if (isNil {_objet getVariable "R3F_LOG_disabled"}) then
					{
						_objet setVariable ["R3F_LOG_disabled", R3F_LOG_CFG_disabled_by_default, false];
					};
				};
				
				sleep (__tempo / _count_liste_objets);
			};
		}
		else
		{
			sleep __tempo;
		};
	}
	else
	{
		sleep 2;
	};
};