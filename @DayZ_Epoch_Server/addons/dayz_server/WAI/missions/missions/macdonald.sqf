private ["_rndnum","_mission","_position","_aiType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] The Farm]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_MacDonald select 0;} else {Loot_MacDonald select 1;};

//Spawn Crates
[[
	[_loot,crates_small,[.02,0,.15]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_sara_stodola",[4,-5,-0.12]],
	["MAP_HouseV_2T2",[18,-11,-0.14]],
	["MAP_t_quercus3s",[32.4,-32,-0.14]],
	["MAP_t_quercus2f",[14,-3,-0.14]],
	["MAP_t_pinusN2s",[-12,5,-0.14]],
	["datsun01Wreck",[-10,-1,-0.02]],
	["Haystack",[-1,-32,-0.02]],
	["Haystack_small",[-25,-36,-0.16]],
	["Haystack_small",[33,-43,-0.02]],
	["Haystack_small",[10,-49,-0.02]],
	["Haystack_small",[13,60,-0.02]],
	["Haystack_small",[-33,-51,-0.02]],
	["Haystack_small",[20,-67,-0.02]],
	["Land_Shed_wooden",[10,-24,-0.02]],
	["fiberplant",[12,-23,-0.02]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 1, (_position select 1) - 10, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 2, (_position select 1) - 50, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 1, (_position select 1) + 11, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 1, (_position select 1) + 11, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 1, (_position select 1) + 11, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) - 27, (_position select 1) - 18, 0],[(_position select 0) + 32, (_position select 1) + 1, 0],50,2,"Offroad_DSHKM_Gue_DZ","Hard",_aiType,_aiType,_mission] call vehicle_patrol;
 
//Static Guns
[[[(_position select 0) - 12, (_position select 1) - 18, 0]],"M2StaticMG","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"The Farm", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_FARM_ANNOUNCE","STR_CL_GENERAL_FARM_WIN","STR_CL_GENERAL_FARM_FAIL"]
] call mission_winorfail;