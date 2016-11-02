// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sideMissionProcessor.sqf
//	@file Author: AgentRev

#define MISSION_PROC_TYPE_NAME "Occupation"
#define MISSION_PROC_TIMEOUT (["A3W_occupationMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE occupationMissionColor

#include "occupationMissions\occupationMissionDefines.sqf"
#include "missionProcessor.sqf";
