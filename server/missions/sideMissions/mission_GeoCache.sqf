// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_geoCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_geoPos", "_geoCache", "_randomBox", "_box", "_para"];

_setupVars =
{
	_missionType = "GeoCache";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);	
	_geoCache = createVehicle ["Land_SurvivalRadio_F",[(_geoPos select 0), (_geoPos select 1),0],[], 0, "NONE"];

	_missionHintText = "A GeoCache has been marked on the map. There is a small object hidden near the marker. Find it and a reward will be delivered by air!";
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {{isPlayer _x && _x distance _geoPos < 5} count playableUnits > 0};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_GeoCache];
};

_successExec =
{
	// Mission completed
	{ deleteVehicle _x } forEach [_GeoCache];
	
	_randomBox = selectRandom ["mission_USLaunchers","mission_Main_A3snipers","mission_Uniform","mission_DLCLMGs","mission_ApexRifles","mission_USSpecial","mission_HVSniper","mission_DLCRifles","mission_HVLaunchers"];
	
	_box = createVehicle ["B_supplyCrate_F",[(_geoPos select 0), (_geoPos select 1),200],[], 0, "NONE"];
	_box setDir random 360;
	[_box, _randomBox] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box];

	playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", _box, false, _box, 15, 1, 1500];
	
	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, ""];

	_para setDir getDir _box;
	_para setPosATL getPosATL _box;

	_para attachTo [_box, [0, 0, 0]];
	uiSleep 2;

	detach _para;
	_box attachTo [_para, [0, 0, 0]];

	while {(getPos _box) select 2 > 3 && attachedTo _box == _para} do
	{
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];
		uiSleep 0.1;
	};
	
	_successHintMessage = "The GeoCache supplies have been delivered by parachute!";
};

_this call sideMissionProcessor;