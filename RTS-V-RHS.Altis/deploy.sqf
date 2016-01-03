// get the original orientation of the weapon
_orgdir = player weaponDirection (primaryWeapon player); 
// place it somewhat in front and above player
_orgpos = [0,1.5,.6]; 

// deploy the weapon
player deployWeapon [_orgpos,_orgdir];
// allow movement 45º to the left & right, and 30º up & down
player setDeployedWeaponLimits [-45,45,30,-30]; 

// when the player starts moving, cancel the deployment
_currAnim = animationState player;
waitUntil {(animationState player)!=_currAnim};
player deployWeapon [];
