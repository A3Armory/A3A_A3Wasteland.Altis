//	@file Name: teamBalance.sqf

// Teambalancer
_uid = getPlayerUID player;
_teamBal = ["A3W_teamBalance", 0] call getPublicVar;
if (playerSide in [BLUFOR,OPFOR] && _teamBal > 0) then{
	private ["_justPlayers", "_serverCount", "_sideCount"];
	_justPlayers = allPlayers - entities "HeadlessClient_F";
	_serverCount = count _justPlayers;
	_sideCount = playerSide countSide _justPlayers;
	_opposingSide = [BLUFOR, OPFOR] select (playerSide==BLUFOR);
	_opposingCount = _opposingSide countSide _justPlayers;
	if (_serverCount >= 15 && (_sideCount > (_teamBal/100) * _serverCount) && (abs (_sideCount-_opposingCount)) > 3 ) then{
		if !(_uid call isAdmin) then {
			_prevSide = [pvar_teamSwitchList, _uid] call fn_getFromPairs;
			if(!isNil "_prevSide")then{
				if(_prevSide == playerSide)then{
					//If player is locked to the side that is unbalanced, move their lock to indie
					pvar_teamSwitchUnlock = _uid;
					publicVariableServer "pvar_teamSwitchUnlock";
					pvar_teamSwitchLock = [_uid, INDEPENDENT];
					publicVariableServer "pvar_teamSwitchLock";
				};
			};
			["TeamBalance",false,1] call BIS_fnc_endMission;
		} else {
			cutText ["You have used your admin to join a stacked team. Only do this for admin duties.", "PLAIN DOWN", 1];
		};
	};
};
