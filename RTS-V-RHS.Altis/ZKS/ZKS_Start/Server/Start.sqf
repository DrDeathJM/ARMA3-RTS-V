

West setFriend [RESISTANCE, 0];
RESISTANCE setFriend [West, 0]; 
West setFriend [East, 0]; 
East setFriend [West, 0];
RESISTANCE setFriend [East, 0];
East setFriend [RESISTANCE, 0]; 

sleep .1;
[] execVM "ZKS\Code\server\CodeStarter.sqf";


