//Bounty - Pay bounty killer, track bounty kills, broadcast bounty kill
//Author: Tyler
//@file Name: Bounty_redeem.sqf

private["_unit", "_killer", "_rewardKey", "_bountyAmount", "_bountyKills"];

_unit = param [0, objNull, [objNull]];
_killer = param [1, objNull, [objNull]];
_bountyAmount = param [2, 0, [0]];

//Process transfer of bounty to killer
_rewardKey = call A3W_fnc_generateKey + "_rewardBounty";
_unit setVariable [_rewardKey, true, false];
pvar_bountyProcessing = ["rewardbounty", _unit, _killer, _rewardKey];
publicVariableServer "pvar_bountyProcessing";

//Add to killer's bounty kills
_bountyKills = _killer getVariable ["bountyKills", []];
_floatDateStamp = missionStart;
_floatDateStamp resize 5;
_floatDateStamp = (dateToNumber _floatDateStamp) + (diag_tickTime / 31536000);
_noMatch = true;
{ if(_x select 0 == getPlayerUID _unit) exitWith{
  _x set [1, _floatDateStamp];
  _noMatch = false;
} } forEach _bountyKills;
if(_noMatch)then{
  _bountyKills pushBack [getPlayerUID _unit, _floatDateStamp];
  _killer setVariable ["bountyKills", _bountyKills, true];
};

//Broadcast bounty kill to everyone
[ parseText format
  [ "<t shadow='2' size='1.75' color='#ff5f4a'>Killed!</t><br/>" +
    "<t color='#ff5f4a'>--------------------------------</t><br/>" +
    "<t size='1.25' color='#ff5f4a'>%1</t><t size='1.25'> %4</t><br/>" +
    "<img size='5' image='addons\bounty\icons\kill.paa'/><br/>" +
    "<t color='#ff5f4a'>%2</t> <t>has been rewarded the bounty of $%3</t>",
    name _unit,
    name _killer,
    _bountyAmount,
    [
	"has kicked the bucket!",
	"got fucked up!",
	"is taking a swim with cement boots",
	"is now a worm buffet",
	"is taking a dirt nap",
	"became a root inspector",
	"is checking out the grass from underneath",
	"is deader than a doornail",
	"is headed home in a pine box",
	"is out of their misery",
	"is sleeping with the fishes",
	"was WASTED",
	"is pushing daisies",
	"got whacked",
	"is deader than Prince"
    ] call BIS_fnc_selectRandom
   ]
  ] call hintBroadcast;
