/**
 * Restore the objects passed in the array to a given marker position if they were transported in a vehicle/cargo which have been destroyed.
 * 
 * Note : it does not protect the objects to be destroyed when they are not transported.
 * If you need that, add this command in the initialization line of each object :
 * this addEventHandler ["HandleDamage", {0}];
 * 
 * @param 0 the array of objects to restore if they are in a destroyed transport vehicle/cargo
 * @param 1 the name of the marker where to restore the objects
 * 
 * @usage [[my_object1, my_object2], "respawn_West"] execVM "R3F_LOG\USER_FUNCT\watch_objects_to_not_lose.sqf";
 */

if (isServer) then
{
	waitUntil {!isNil "R3F_LOG_active"};
	
	if (R3F_LOG_active) then
	{
		private ["_objets_a_ne_pas_perdre", "_marqueur_ou_restaurer", "_objet", "_bbox_dim", "_pos_degagee", "_rayon"];
		
		_objets_a_ne_pas_perdre = _this select 0;
		_marqueur_ou_restaurer = _this select 1;
		
		while {true} do
		{
			// Pour chaque objet à ne pas perdre
			{
				_objet = _x;
				
				// Si l'objet est transporté
				if !(isNull (_objet getVariable ["R3F_LOG_est_transporte_par", objNull])) then
				{
					// Mais que le transporteur est détruit
					if !(alive (_objet getVariable "R3F_LOG_est_transporte_par")) then
					{
						_bbox_dim = (vectorMagnitude (boundingBoxReal _objet select 0)) max (vectorMagnitude (boundingBoxReal _objet select 1));
						
						// Recherche d'une position dégagée (on augmente progressivement le rayon jusqu'à trouver une position)
						for [{_rayon = 5 max (2*_bbox_dim); _pos_degagee = [];}, {count _pos_degagee == 0 && _rayon <= 100 + (8*_bbox_dim)}, {_rayon = _rayon + 20 + (5*_bbox_dim)}] do
						{
							_pos_degagee = [
								_bbox_dim,
								getMarkerPos _marqueur_ou_restaurer,
								_rayon,
								100 min (5 + _rayon^1.2)
							] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
						};
						
						// En cas d'échec de la recherche de position dégagée
						if (count _pos_degagee == 0) then {_pos_degagee = getMarkerPos _marqueur_ou_restaurer;};
						
						// On ramène l'objet sur la position
						detach _objet;
						_objet setPos _pos_degagee;
						
						// L'objet n'est plus transporté
						_objets_charges = (_objet  getVariable "R3F_LOG_est_transporte_par") getVariable ["R3F_LOG_objets_charges", []];
						_objets_charges = _objets_charges - [_objet];
						(_objet getVariable "R3F_LOG_est_transporte_par") setVariable ["R3F_LOG_objets_charges", _objets_charges, true];
						_objet setVariable ["R3F_LOG_est_transporte_par", objNull, true];
						
						sleep 1;
					};
				};
			} forEach _objets_a_ne_pas_perdre;
			
			sleep 15;
		};
	};
};