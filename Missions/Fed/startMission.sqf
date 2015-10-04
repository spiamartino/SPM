if(!isDedicated) exitWith {};

//Waiting for squads
while{fedSquadCount < 2} do {
	if(!isNull fedEast) then {
		["Waiting for a second squad to start the match","hint",fedEast,false] call BIS_fnc_MP;
	};
	if(!isNull fedWest) then {
		["Waiting for a second squad to start the match","hint",fedWest,false] call BIS_fnc_MP;
	};
	sleep 5;
};
["Second squad found. You may now deploy to the battlefield.","hint", fedEast] call BIS_fnc_MP;
["Second squad found. You may now deploy to the battlefield.","hint", fedWest] call BIS_fnc_MP;
["deploy","fnc_queryClient",fedEast,false] call BIS_fnc_MP;
["deploy","fnc_queryClient",fedWest,false] call BIS_fnc_MP;
fedMissionFilling = false;
publicVariable "fedMissionFilling";
//max squads, start the mission

fedMissionInProgress = true;
publicVariable "fedMissionInProgress";

//waiting for squads to be ready
playersReady = [];
_squad1Ready = false;
_squad2Ready = false;
while{!_squad1Ready || !_squad2Ready} do {
	[["ready"],"fnc_queryClient",fedEast, false] call bis_fnc_MP;
	[["ready"],"fnc_queryClient",fedWest, false] call bis_fnc_MP;	
	if(fedEast in playersReady) then {
		_squad1Ready = true;
		["Your team is ready","hint",fedEast, false] call BIS_fnc_MP;
	};
	if(fedWest in playersReady) then {
		_squad2Ready = true;
		["Your team is ready","hint",fedWest, false] call BIS_fnc_MP;
	};
	sleep 1;
};
playersReady = [];
[["reset"],"fnc_queryClient",fedEast,false] call bis_fnc_MP;
[["reset"],"fnc_queryClient",fedWest,false] call bis_fnc_MP;

[[false], "fnc_freezePlayer", fedWest, false] call BIS_fnc_MP;
[[false], "fnc_freezePlayer", fedEast, false] call BIS_fnc_MP;

[["Standard",["Mission Started!","All players ready. GO! GO! GO!"]],"BIS_fnc_showNotification",fedEast,false] call BIS_fnc_MP;
[["Standard",["Mission Started!","All players ready. GO! GO! GO!"]],"BIS_fnc_showNotification",fedWest,false] call BIS_fnc_MP;

[[],"fnc_fedFlag",fedEast, false] call bis_fnc_MP;
[[],"fnc_fedFlag",fedWest, false] call bis_fnc_MP;
//mission run
while{fedMissionInProgress} do {
	sleep 2;
	if(isNull fedEast || isNull fedWest) then {
		fedMissionInProgress = false;
	};
};

[[fedEast, fedWest],"fnc_returnToBase"] call BIS_fnc_MP;
opforMission = "";
blueforMission = "";
fedEast = grpNull;
fedWest = grpNull;
fedSquadCount = 0;
publicVariable "opforMission";
publicVariable "blueforMission";


