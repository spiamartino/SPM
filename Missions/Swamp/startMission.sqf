if(!isDedicated) exitWith {};

//Waiting for squads
while{swampSquadCount < 2} do {
	if(!isNull swampTeam1) then {
		["Waiting for a second squad to start the match","hint",swampTeam1,false] call BIS_fnc_MP;
	};
	if(!isNull swampTeam2) then {
		["Waiting for a second squad to start the match","hint",swampTeam2,false] call BIS_fnc_MP;
	};
	sleep 5;
};
["Second squad found. You may now deploy to the battlefield.","hint", swampTeam1] call BIS_fnc_MP;
["Second squad found. You may now deploy to the battlefield.","hint", swampTeam2] call BIS_fnc_MP;
["deploy","fnc_queryClient",swampTeam1,false] call BIS_fnc_MP;
["deploy","fnc_queryClient",swampTeam2,false] call BIS_fnc_MP;
swampMissionFilling = false;
publicVariable "swampMissionFilling";
//max squads, start the mission

swampMissionInProgress = true;
publicVariable "swampMissionInProgress";

//waiting for squads to be ready
playersReady = [];
_squad1Ready = false;
_squad2Ready = false;
while{!_squad1Ready || !_squad2Ready} do {
	[["ready"],"fnc_queryClient",swampTeam1, false] call bis_fnc_MP;
	[["ready"],"fnc_queryClient",swampTeam2, false] call bis_fnc_MP;	
	if(swampTeam1 in playersReady) then {
		_squad1Ready = true;
		["Your team is ready","hint",swampTeam1, false] call BIS_fnc_MP;
	};
	if(swampTeam2 in playersReady) then {
		_squad2Ready = true;
		["Your team is ready","hint",swampTeam2, false] call BIS_fnc_MP;
	};
	sleep 1;
};
playersReady = [];
[["reset"],"fnc_queryClient",swampTeam1,false] call bis_fnc_MP;
[["reset"],"fnc_queryClient",swampTeam2,false] call bis_fnc_MP;

[[false], "fnc_freezePlayer", swampTeam2, false] call BIS_fnc_MP;
[[false], "fnc_freezePlayer", swampTeam1, false] call BIS_fnc_MP;

[["Standard",["Mission Started!","All players ready. GO! GO! GO!"]],"BIS_fnc_showNotification",swampTeam1,false] call BIS_fnc_MP;
[["Standard",["Mission Started!","All players ready. GO! GO! GO!"]],"BIS_fnc_showNotification",swampTeam2,false] call BIS_fnc_MP;

[[],"fnc_swampFlag",swampTeam1, false] call bis_fnc_MP;
[[],"fnc_swampFlag",swampTeam2, false] call bis_fnc_MP;
//mission run
while{swampMissionInProgress} do {
	sleep 2;
	if(isNull swampTeam1 || isNull swampTeam2) then {
		swampMissionInProgress = false;
	};
};

[[swampTeam1, swampTeam2],"fnc_returnToBase"] call BIS_fnc_MP;
opforMission = "";
blueforMission = "";
swampTeam1 = grpNull;
swampTeam2 = grpNull;
swampSquadCount = 0;
publicVariable "opforMission";
publicVariable "blueforMission";


