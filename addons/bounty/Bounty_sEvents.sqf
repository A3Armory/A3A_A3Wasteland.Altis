//Bounty Server Events
//Author: Tyler
//@file Name: Bounty_sEvents.sqf

"pvar_bountyProcessing" addPublicVariableEventHandler {
  _list = _this select 1;
  _type = _list param [0, "", [""]];

  switch (toLower _type) do
  {
    case "addbounty":
    {
      _sender = _list param [1, objNull, [objNull]];
      _recipient = _list param [2, objNull, [objNull]];
      _amount = _list param [3, 0, [0]];
      _rewardAmount = _list param [4, 0, [0]];
      _bountyKey = _list param [5, "", [""]];

      _result = 0;
      _cost = _amount;
      _sBalance = _sender getVariable ["bmoney", 0];

      if (_cost > 0) then
      {
        if (!isPlayer _sender || !isPlayer _recipient || _sender == _recipient) exitWith {}; // invalid sender or recipient
        if (_sBalance < _cost) exitWith {}; // sender has not enough funds for transfer

        _bounty = _recipient getVariable ["bounty", 0];

        if (_bounty + _rewardAmount > ["A3W_bountyMax", 50000] call getPublicVar) exitWith {}; // recipient would exceed or has reached max balance

        _sBalance = _sBalance - (if (!local _sender) then { _cost } else { 0 });
        _bounty = _bounty + _rewardAmount;

        _sender setVariable ["bmoney", _sBalance, true];
        _recipient setVariable ["bounty", _bounty, true];

        _senderUID = getPlayerUID _sender;
        _recipientUID = getPlayerUID _recipient;

        if (["A3W_playerSaving"] call isConfigOn) then
        {
          [_senderUID, [["BankMoney", _sBalance]], []] call fn_saveAccount;
          [_recipientUID, [["Bounty", _bounty]], []] call fn_saveAccount;
        };

        _result = _rewardAmount;

        pvar_bountyNotify = ["bountyAdded", _result, name _sender];
        (owner _recipient) publicVariableClient "pvar_bountyNotify";
      };

      pvar_bountyNotify = ["bountySent", _result, name _recipient];
      (owner _sender) publicVariableClient "pvar_bountyNotify";

      // Reset client-side player balance to previous value if transfer failed
      if (_result == 0) then
      {
        _sender setVariable ["bmoney", _sBalance + (if (local _sender) then { _cost } else { 0 }), true];
      };

      _sender setVariable [_bountyKey, nil, true];
    };

    case "rewardbounty":
    {
      _outlaw = _list param [1, objNull, [objNull]];
      _bountyHunter = _list param [2, objNull, [objNull]];
      _bountyKey = _list param [3, "", [""]];

      _result = 0;
      _reward = _outlaw getVariable ["bounty", 0];

      if (_reward > 0) then
      {
        if (!isPlayer _outlaw || !isPlayer _bountyHunter || _outlaw == _bountyHunter) exitWith {}; // invalid sender or recipient

        _hunterBalance = _bountyHunter getVariable ["bmoney", 0];
        _hunterBalance = (_hunterBalance + _reward) min (["A3W_atmMaxBalance", 300000] call getPublicVar); // hunter exceeds max atm

        _outlaw setVariable ["bounty", 0, true];
        _bountyHunter setVariable ["bmoney", _hunterBalance, true];

        _outlawUID = getPlayerUID _outlaw;
        _bountyHunterUID = getPlayerUID _bountyHunter;

        [_outlawUID, [["Bounty", 0]], []] call fn_saveAccount;
        [_bountyHunterUID, [["BankMoney", _hunterBalance]], []] call fn_saveAccount;

        _result = _reward;

        pvar_bountyNotify = ["bountyCollected", _result, name _outlaw];
        (owner _bountyHunter) publicVariableClient "pvar_bountyNotify";
      };

      // Reset client-side player bounty to previous value if bounty collect failed
      if (_result == 0) then
      {
        _outlaw setVariable ["bounty", (if (local _outlaw) then { _reward } else { 0 }), true];
      };

      _outlaw setVariable [_bountyKey, nil, true];
    };
  };
};
