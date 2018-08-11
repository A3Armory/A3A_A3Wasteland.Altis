//Bounty Client Events
//Author: Tyler
//@file Name: Bounty_cEvents.sqf

"pvar_bountyNotify" addPublicVariableEventHandler {
  _list = _this select 1;
  _type = _list param [0, "", [""]];

  switch (toLower _type) do
  {
    case "bountysent":
    {
      _rewardAmount = _list param [1, 0, [0]];
      _name = _list param [2, "", [""]];

      if (_rewardAmount != 0) then
      {
        _message = if (isStreamFriendlyUIEnabled) then {
          "You have successfully added a bounty reward of $%1"
        } else {
          "You have successfully added a bounty reward of $%1 to %2"
        };

        playSound "defaultNotification";
        [format [_message, [_rewardAmount] call fn_numbersText, _name], 5] call mf_notify_client;
        true call mf_items_atm_refresh;
      }
      else
      {
        playSound "FD_CP_Not_Clear_F";
        ["Invalid2 transaction, please try again.", 5] call mf_notify_client;
        true call mf_items_atm_refresh;
      };
    };

    case "bountyadded":
    {
      _rewardAmount = _list param [1, 0, [0]];
      _name = _list param [2, "", [""]];

      _message = if (isStreamFriendlyUIEnabled) then {
        "A bounty of $%1 has been added to your head"
      } else {
        "%2 has added a bounty of $%1 to your head"
      };

      playSound "FD_Finish_F";
      [format [_message, [_rewardAmount] call fn_numbersText, _name], 5] call mf_notify_client;
      true call mf_items_atm_refresh;
    };

    case "bountycollected":
    {
      _rewardAmount = _list param [1, 0, [0]];
      _name = _list param [2, "", [""]];

      _message = if (isStreamFriendlyUIEnabled) then {
        "You have collected a bounty of $%1"
      } else {
        "You have killed %2. You collect their bounty of $%1"
      };

      playSound "FD_Finish_F";
      [format [_message, [_rewardAmount] call fn_numbersText, _name], 5] call mf_notify_client;
    };
  };
};
