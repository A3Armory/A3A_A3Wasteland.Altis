// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_lastResort.sqf
//	@file Author: AgentRev

private ["_hasCharge", "_hasSatchel", "_mineType", "_mine", "_randomSound"];

_hasCharge = "DemoCharge_Remote_Mag" in magazines player;
_hasSatchel = "SatchelCharge_Remote_Mag" in magazines player;
_randomSound = ["johncena.ogg", "john-stamos.ogg", "price-is-right.ogg", "R2D2.ogg", "scarface.ogg", "sloth.ogg", "trombone.ogg", "predator.ogg"] call BIS_fnc_selectRandom;

if !(player getVariable ["performingDuty", false]) then
{
	if (_hasCharge || _hasSatchel) then
	{
		if (["Perform your duty?", "", "Yes", "No"] call BIS_fnc_guiMessage) then
		{
			player setVariable ["performingDuty", true];
			playSound3D [call currMissionDir + "client\sounds\" + _randomSound, vehicle player, false, getPosASL player, 0.7, 1, 1000];

			if (_hasSatchel) then
			{
				_mineType = "SatchelCharge_F";
				player removeMagazine "SatchelCharge_Remote_Mag";
			}
			else
			{
				_mineType = "DemoCharge_F";
				player removeMagazine "DemoCharge_Remote_Mag";
			};

			sleep 1.75;

			_mine = createMine [_mineType, ASLtoAGL ((getPosASL player) vectorAdd [0, 0, 0.5]), [], 0];
			_mine setDamage 1;

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
		titleText ["Get an explosive charge next time, my child.", "PLAIN", 0.5];
	};
};
