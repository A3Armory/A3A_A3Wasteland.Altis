// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostageRescue.sqf
//	@file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_camonet", "_hostage", "_obj1", "_obj2", "_obj3", "_drop_item"];

_setupVars =
{
	_missionType = "Rescue Drug Dealer";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_camonet = createVehicle ["Land_Shed_06_F", _missionPos, [], 0, "NONE"];
	_camonet allowdamage false;
	_camonet setDir random 360;

	_missionPos = getPosATL _camonet;

	_hostage = createVehicle ["C_Orestes", _missionPos, [], 0, "NONE"];
	_hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	waitUntil {alive _hostage};
	[_hostage, "Acts_AidlPsitMstpSsurWnonDnon_loop"] call switchMoveGlobal;
	_hostage disableAI "anim";

	_obj1 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10, "NONE"]; 
	_obj1 setPosATL [(_missionPos select 0) - 6, (_missionPos select 1) + 6, _missionPos select 2];

	_obj2 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10, "NONE"]; 
	_obj2 setPosATL [(_missionPos select 0) - 6, (_missionPos select 1) - 6, _missionPos select 2];

	_obj3 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10, "NONE"]; 
	_obj3 setPosATL [(_missionPos select 0) + 6, (_missionPos select 1) - 6, _missionPos select 2];

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_camonet, _obj1, _obj2, _obj3];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	_missionHintText = format ["<br/>A drug dealer has been kidnapped by bandits. Free him and get some of his high valued product.", sideMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage};

_drop_item = {
  private["_item", "_pos"];
  _item = _this select 0;
  _pos = _this select 1;

  if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
  if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

  private["_id", "_class"];
  _id = _item select 0;
  _class = _item select 1;

  private["_obj"];
  _obj = createVehicle [_class, _pos, [], 5, "None"];
  _obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
  _obj setVariable ["mf_item_id", _id, true];
};

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_camonet, _hostage, _obj1, _obj2, _obj3];
	_failedHintMessage = format ["<br/>The drug dealer is dead. You failed to save him."];
};

_successExec =
{
	// Mission completed
	{ deleteVehicle _x } forEach [_camonet, _hostage, _obj1, _obj2, _obj3];

	for "_i" from 4 to 8 do 
	{
		private["_item"];
		_item = selectRandom [["lsd", "Land_WaterPurificationTablets_F"],["marijuana", "Land_VitaminBottle_F"],["cocaine","Land_PowderedMilk_F"],["heroin", "Land_PainKillers_F"]];
		[_item, _lastPos] call _drop_item;
	};

	_successHintMessage = format ["<br/>Well done! You saved the life of the drug dealer. Grab the drugs."];
};

_this call sideMissionProcessor;
