//Init for Bounty System - allowing players to put bounty rewards on each other's heads, with reward going to the bounty killer
//Author: Tyler

//Public Event Handlers
if(hasInterface)then{
  call compile preprocessFileLineNumbers "addons\bounty\Bounty_cEvents.sqf";
};
if (isServer) then {
  call compile preprocessFileLineNumbers "addons\bounty\Bounty_sEvents.sqf";
};

//Function for checking group invites
bountyGroupCheck = "addons\bounty\Bounty_group.sqf" call mf_compile;

//Function for redeeming bounty when player dies
bountyRedeem = "addons\bounty\Bounty_redeem.sqf" call mf_compile;

//Function for cleaning up bounty kills with expired lifetime
bountyKillsExpired = "addons\bounty\Bounty_expired.sqf" call mf_compile;
