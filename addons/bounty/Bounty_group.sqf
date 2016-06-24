//Bounty - Returns bool for whether the new group member and/or existing group members have collected bounty on each other
//Author: Tyler
//@file Name: Bounty_group.sqf

private["_player", "_target", "_targetsBounties", "_groupBounties", "_bountyHunter", "_bountyVictim"];

_player = param [0, objNull, [objNull]];
_target = param [1, objNull, [objNull]];
_targetsBounties = _target getVariable ["bountyKills", []];

{
	scopeName "bountyCheck";
	//Group member
	_gM = _x;

	//Check new member hasn't collected bounty on group member
	{ if (_x select 0 == getPlayerUID _gM) exitWith {
		_bountyHunter = _target;
		_bountyVictim = _gM;
		breakOut "bountyCheck";
	} } forEach _targetsBounties;

  //Check group member hasn't collected bounty on new member
	_groupBounties = _gM getVariable ["bountyKills", []];
	{ if (_x select 0 == getPlayerUID _target) exitWith {
		_bountyHunter = _gM;
		_bountyVictim = _target;
		breakOut "bountyCheck";
	} } forEach _groupBounties;

} forEach units _player;

if(!isNil "_bountyHunter" && !isNil "_bountyVictim")then{
	[_bountyHunter, _bountyVictim]
};
