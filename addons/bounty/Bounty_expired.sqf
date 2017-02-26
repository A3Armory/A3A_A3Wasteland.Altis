//Bounty - Remove the Bounty kills that have exceeded their lifetime
//Author: Tyler
//@file Name: Bounty_expired.sqf

params ["_player"];
_bountyKills = _player getVariable ["bountyKills", []];
_newBounty = [];
_floatDateStamp = missionStart;
_floatDateStamp resize 5;
_floatDateStamp = dateToNumber _floatDateStamp;
if(_floatDateStamp > 0) then{
  _floatDateStamp = _floatDateStamp + (diag_tickTime / 31536000);
  {
    //0.00273973 = 1 day
    if(_floatDateStamp > (_x select 1) && _floatDateStamp < (_x select 1) + (((["A3W_bountyLifetime", 0] call getPublicVar) / 24) * 0.00273973))then{
      //If current timestamp falls between bounty kill timestamp and the lifetime, then keep the bounty stored
      _newBounty pushBack _x;
    };
  } forEach _bountyKills;
}else{_newBounty = _bountyKills};
_player setVariable ["bountyKills", _newBounty, true];
