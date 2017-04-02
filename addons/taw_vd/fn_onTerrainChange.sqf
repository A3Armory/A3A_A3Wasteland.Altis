/*
	File: fn_onTerrainChange.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Updates the players terraingrid when called.
*/
private["_type"];
_type = param [0,"",[""]];
if(_type == "") exitWith {};
	
switch (_type) do
{
	case "low": {setTerrainGrid 12.5;};
	case "norm": {setTerrainGrid 6.25;};
	case "high": {setTerrainGrid 3.125;};
};