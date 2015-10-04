removeAllActions swampFlag2;
swampFlag2Action = swampFlag2 addAction ["Claim Victory",
	{
		swampFlag2 setFlagOwner player;
		_target = cursorTarget;
		_count = 0;
		_success = false;
		while {!_success} do
			{	
				[[player, "AwopPknlMstpSoptWbinDnon_AmovPknlMstpSrasWlnrDnon_end"], "playMove", true, false, false] spawn BIS_fnc_MP;
				sleep 2.5;
				_count = _count + .1;
				if (!alive player) exitWith {};
				if(player distance _target > 7) exitWith {};
				if(_count >= 1) exitWith{ _success = true; };
				
		};
	swampFlag2 setFlagTexture "Resources\TempestFlag.jpg";
	swampFlag2 setFlagOwner objNull;
	fediMissionInProgress = false;
	publicVariable "fediMissionInProgress";
	[["MissionCompleted",format["%1 has claimed victory for %2 at the fed!",name player,squad]],"fnc_notify", true, false] call BIS_fnc_MP;
	swampFlag2 removeAction swampFlag2Action;
	},nil,-1,false,false,"","_this distance _target <= 5"
];