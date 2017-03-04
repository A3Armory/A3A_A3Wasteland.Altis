// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_nbUnits", "_positions", "_box", "_missionPos", "_randomBox", "_randomCase"];

_setupVars =
{
	_missionType = "Occupation";
	_locationsArray = OccupationMissionMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_randomBox = selectRandom ["mission_USLaunchers","mission_Main_A3snipers","mission_Uniform","mission_DLCLMGs","mission_ApexRifles","mission_USSpecial","mission_HVSniper","mission_DLCRifles","mission_HVLaunchers"];
	_randomCase = selectRandom ["Box_NATO_WpsSpecial_F","Box_East_WpsSpecial_F","Box_NATO_Wps_F","Box_East_Wps_F"];
	_box = createVehicle [_randomCase, _missionPos, [], 5, "None"];
	_box setDir random 360;
	[_box, _randomBox] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createOccupationGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	_missionHintText = format ["A group of soldiers has been spotted. Head to the marked area and take them out. Be careful they are armed and dangerous!", sideMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box];

	_successHintMessage = format ["The soldiers are dead. Well done!"];
};

_this call sideMissionProcessor;