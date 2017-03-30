//Client Function for Airdrop Assistance (not really a function, as it is called via ExecVM from command menu)
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: Apoc
//Credits: Some methods taken from Cre4mpie's airdrop scripts, props for the idea!
scriptName "APOC_cli_startAirdrop";
private ["_type","_selection","_player","_lastUsedTime","_timeLeft"]; //Variables coming from command menu
_type = _this select 0;
_selectionNumber = _this select 1;
_player = _this select 2;
_lastUsedTime = (["APOC_AA_lastUsedTime", 0] call getPublicVar);

//diag_log format ["Player %1, Drop Type %2, Selection # %3",_player,_type,_selectionNumber];
//hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
_selectionArray = [];
switch (_type) do {
	case "vehicle": {_selectionArray = APOC_AA_VehOptions};
	case "supply": {_selectionArray = APOC_AA_SupOptions};
	case "picnic": {_selectionArray = APOC_AA_SupOptions};
	default {_selectionArray = APOC_AA_VehOptions; diag_log "Apoc's Airdrop Assistance - Default Array Selected - Something broke";};
};
_selectionName = (_selectionArray select _selectionNumber) select 0;
_price = (_selectionArray select _selectionNumber) select 2;

/////////////  Cooldown Timer ///////////////////////////
if (!isNil "_lastUsedTime") then
{
	_timeLeft = APOC_AA_coolDownTime - (serverUpTime - _lastUsedTime);
	if (_timeLeft > 0) then
	{
		hint format["Negative, Airdrop Offline. Online ETA: %1", _timeLeft call fn_formatTimer];
		playSound "FD_CP_Not_Clear_F";
		player groupChat format ["Negative, Airdrop Offline. Online ETA: %1", _timeLeft call fn_formatTimer];
		breakOut "APOC_cli_startAirdrop";
	};
};
////////////////////////////////////////////////////////

_playerMoney = _player getVariable ["bmoney", 0];
if (_price > _playerMoney) exitWith
{
	hint format["You don't have enough money in the bank to request this airdrop!"];
	playSound "FD_CP_Not_Clear_F";
};

_confirmMsg = format ["This airdrop will deduct $%1 from your bank account upon delivery<br/>",_price call fn_numbersText];
_confirmMsg = _confirmMsg + format ["<br/><t font='EtelkaMonospaceProBold'>1</t> x %1",_selectionName];

// Display confirm message
if ([parseText _confirmMsg, "Confirm", "DROP!", true] call BIS_fnc_guiMessage) then
{
	_heliDirection = random 360;
	[[_type,_selectionNumber,_player,_heliDirection],"APOC_srv_startAirdrop",false,false,false] call BIS_fnc_MP;

	diag_log format ["Apoc's Airdrop Assistance - Last Used Time: %1; CoolDown Set At: %2; Current Time: %3", _lastUsedTime, APOC_AA_coolDownTime, serverUpTime];
	playSound3D ["a3\sounds_f\sfx\radio\ambient_radio17.wss",player,false,getPosASL player,1,1,25];
	sleep 1;
	hint format ["Inbound Airdrop %2 Heading: %1 ETA: 40s",ceil _heliDirection,_selectionName];
	player groupChat format ["Inbound Airdrop %2 Heading: %1 ETA: 40s",ceil _heliDirection,_selectionName];
	sleep 20;
	hint format ["Inbound Airdrop %2 Heading: %1 ETA: 20s",ceil _heliDirection,_selectionName];
	player groupChat format ["Inbound Airdrop %2 Heading: %1 ETA: 20s",ceil _heliDirection,_selectionName];
};