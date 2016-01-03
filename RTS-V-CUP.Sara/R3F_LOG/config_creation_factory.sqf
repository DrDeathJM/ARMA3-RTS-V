/**
 * CREATION FACTORY CONFIGURATION FILE
 * 
 * English and French comments
 * Commentaires anglais et français
 * 
 * This file contains the predefined lists of available categories in the creation factory.
 * The objects/vehicles categories are the same as in the mission editor.
 * It corresponds to the tree CfgVehicleClasses in the config file.
 * To add a category in one of the lists, you must write its class name. Use the BIS' "Config viewer".
 * 
 * To understand the white or black list system, read also the needed parameters in USER_FUNCT\init_creation_factory.sqf
 * There are three white list "FULL", "MEDIUM" and "LIGHT", and a black list.
 * The black list is used if no white list is mentioned when calling USER_FUNCT\init_creation_factory.sqf.
 * 
 * 
 * Ce fichier contient la liste des catégories disponibles dans l'usine de création.
 * Les catégories d'objets/véhicules sont les mêmes que dans l'éditeur de mission.
 * Cela correspond à l'arborescence CfgVehicleClasses dans le config file.
 * Pour ajouter une catégorie dans une des listes, vous devez écrire son nom de classe. Utilisez le "Config viewer" de BIS.
 * 
 * Pour comprendre le système de white/black list, consultez les paramètres requis par USER_FUNCT\init_creation_factory.sqf
 * Il y a trois white list "FULL", "MEDIUM" and "LIGHT", et une black list.
 * La black list est utilisée si aucune white list n'est mentionnée lors de l'appel de USER_FUNCT\init_creation_factory.sqf.
 */

/**
 * LIGHT WHITE LIST
 * Categories of objects/vehicles available in a "LIGHT" factory (see USER_FUNCT\init_creation_factory.sqf).
 */
R3F_LOG_CFG_CF_whitelist_light_categories =
[
	"Objects",
	"Armory",
	"Targets",
	"Cargo",
	"Flag",
	"Lamps",
	"Communication",
	"Furniture",
	"Misc",
	"Signs",
	"Small_items",
	"Training",
	"Shelters",
	"Fortifications",
	"Tents",
	"Market",
	"Structures",
	"Structures_Cultural",
	"Structures_Industrial",
	"Structures_Military",
	"Structures_Transport",
	"Structures_Village",
	"Structures_Walls",
	"Structures_Fences",
	"Structures_Slums",
	"Objects_Sports",
	"city_W10_A0_573_R1000"
];

/**
 * MEDIUM WHITE LIST
 * Categories of objects/vehicles available in a "MEDIUM" factory (see USER_FUNCT\init_creation_factory.sqf).
 * It includes all the categories of the "LIGHT" list, and the listed categories below.
 */
R3F_LOG_CFG_CF_whitelist_medium_categories = R3F_LOG_CFG_CF_whitelist_light_categories +
[
	"Ammo",
	"Static",
	"Container"
];

/**
 * FULL WHITE LIST
 * Categories of objects/vehicles available in a "FULL" factory (see USER_FUNCT\init_creation_factory.sqf).
 * It includes all the categories of the "MEDIUM" list, and the listed categories below.
 */
R3F_LOG_CFG_CF_whitelist_full_categories = R3F_LOG_CFG_CF_whitelist_medium_categories +
[
	"Car",
	"Armored",
	"Air",
	"Support",
	"Ship",
	"Autonomous",
	"Submarine",
	"Wreck",
	"Wreck_sub",
	"Submerged",
	"Military",
	"Structures_Commercial",
	"Structures_Infrastructure",
	"Structures_Town"
];

/**
 * BLACK LIST
 * Categories of objects/vehicles to deny if no white list is set to the factory (see USER_FUNCT\init_creation_factory.sqf).
 */
R3F_LOG_CFG_CF_blacklist_categories =
[
	"Camera",
	"Sounds",
	"Mines",
	"Backpacks",
	"Uniforms",
	"Anomalies",
	"Test",
	"Locations",
	"Modules",
	"Emitters",
	"WeaponsPrimary",
	"WeaponsSecondary",
	"WeaponsHandguns",
	"WeaponAccessories",
	"Magazines",
	"Items",
	"ItemsHeadgear",
	"ItemsVests",
	"ItemsUniforms",
	"Intel",
	"Virtual",
	"Garbage",
	"Helpers",
	"Dead_bodies",
	"SystemLocations",
	"SystemSides",
	"SystemMisc",
	"Objects_Sports",
	"Structures_Sports",
	"Explosives",
	"Respawn"
];