// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_lastResort.sqf
//	@file Author: AgentRev

if !(player getVariable ["performingDuty", false]) then
{
	_availableBombs = (magazines player) arrayIntersect ["SatchelCharge_Remote_Mag", "IEDUrbanBig_Remote_Mag", "IEDLandBig_Remote_Mag", "DemoCharge_Remote_Mag", "IEDUrbanSmall_Remote_Mag", "IEDLandSmall_Remote_Mag"]; // biggest to smallest
	_randomSound = selectRandom ["lastresort.ogg", "johncena.ogg", "john-stamos.ogg", "price-is-right.ogg", "scarface.ogg", "sloth.ogg", "predator.ogg", "akbar.ogg", "bomb.ogg", "fired.ogg", "ilovechina.ogg", "mexicanpeople.ogg", "pussy.ogg"];
	_nonSupSound = selectRandom ["johncena.ogg"];
	
	if !(_availableBombs isEqualTo []) then
	{
		_magType = _availableBombs select 0;
		_mineType = ((_magType splitString "_") select 0) + "_F";

		if (!isClass (configFile >> "CfgVehicles" >> _mineType)) exitWith
		{
			titleText [format ["ERROR: invalid class '%1'", _mineType], "PLAIN", 0.5];
		};

		if (["Detonate explosive charge?", "", "Yes", "No"] call BIS_fnc_guiMessage) then
		{
			player setVariable ["performingDuty", true];

			player removeMagazine _magType;

			if ((getPlayerUID player) call isdonor) then
			{
				playSound3D [call currMissionDir + "client\sounds\" + _randomSound, player, false, getPosASL player, 1, 1, 500];
			}
			else
			{
				playSound3D [call currMissionDir + "client\sounds\" + _nonSupSound, player, false, getPosASL player, 1, 1, 500];
			};

			sleep 1.5;

			_oldMines = getAllOwnedMines player;
			removeAllOwnedMines player;

			_mine = createMine [_mineType, ASLtoAGL ((getPosASL player) vectorAdd [0, 0, 0.5]), [], 0];
			player addOwnedMine _mine;

			if (alive player) then
			{
				player action ["TouchOff", player];
			}
			else
			{
				_mine setDamage 1;
			};

			{ player addOwnedMine _x } forEach _oldMines;

			if (damage player < 1) then // if check required to prevent "Killed" EH from getting triggered twice
			{
				player setVariable ["A3W_deathCause_local", ["suicide"]];
				player setDamage 1;
			};

			player setVariable ["performingDuty", nil];
		};
	}
	else
	{
		titleText ["You need an explosive charge next time.", "PLAIN", 0.5];
	};
};
