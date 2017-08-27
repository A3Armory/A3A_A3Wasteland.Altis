// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#include "player_sys.sqf"

class playerSettings {

	idd = playersys_DIALOG;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[] execVM 'client\systems\playerMenu\item_list.sqf'";

	class controlsBackground {

		class MainBG : IGUIBack {
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0.6};

			moving = true;
			x = 0.0125;
			y = 0.04;
			w = 0.9625;
			h = 0.92;
		};

		class TopBar: IGUIBack {
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {A3W_UICOLOR_R, A3W_UICOLOR_G, A3W_UICOLOR_B, 0.8};

			x = 0.0125;
			y = 0.04;
			w = 0.9625;
			h = 0.08;
		};

		class MainTitle : w_RscText {
			idc = -1;
			text = "Player Menu";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.4125;
			y = 0.04;
			w = 0.25;
			h = 0.06;
		};

		class moneyIcon : w_RscText {
			idc = -1;
			text = "Cash:";
			sizeEx = 0.04;
			x = 0.025;
			y = 0.14;
			w = 0.1;
			h = 0.06;
		};

		class serverLogo : w_RscPicture {
			idc = -1;
			text = "modConfig\A3A.paa";
			x = 0.35;
			y = 0.16;
			w = 0.2625;
			h = 0.36;
		};

		class moneyText : w_RscText {
			idc = money_text;
			text = "";
			sizeEx = 0.03;
			x = 0.1375;
			y = 0.14;
			w = 0.1625;
			h = 0.06;
		};

		class bmoney: w_RscText {
			idc = -1;
			text = "Bank:";
			sizeEx = 0.04;
			x = 0.025;
			y = 0.22;
			w = 0.1;
			h = 0.06;
		};

		class bmoneyText: RscText {
			idc = bmoney_text;
			text = "";
			sizeEx = 0.03;
			x = 0.1375;
			y = 0.22;
			w = 0.1625;
			h = 0.06;
		};

		class cspText: w_RscText {
			idc = -1;
			text = "Community Support Perks";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.6375;
			y = 0.14;
			w = 0.2875;
			h = 0.06;
		};
	};

	class controls {

		class itemList : w_Rsclist {
			idc = item_list;
			x = 0.025;
			y = 0.32;
			w = 0.275;
			h = 0.42;
		};

		class DropButton : w_RscButton {
			idc = -1;
			text = "Drop";
			onButtonClick = "[1] execVM 'client\systems\playerMenu\itemfnc.sqf'";
			x = 0.175;
			y = 0.76;
			w = 0.125;
			h = 0.06;
		};

		class UseButton : w_RscButton {
			idc = -1;
			text = "Use";
			onButtonClick = "[0] execVM 'client\systems\playerMenu\itemfnc.sqf'";
			x = 0.025;
			y = 0.76;
			w = 0.125;
			h = 0.06;
		};

		class moneyInput: w_RscCombo {
			idc = money_value;
			x = 0.2;
			y = 0.86;
			w = 0.1375;
			h = 0.06;
		};

		class DropcButton : w_RscButton {
			idc = -1;
			text = "Drop";
			onButtonClick = "[] execVM 'client\systems\playerMenu\dropMoney.sqf'";
			x = 0.025;
			y = 0.86;
			w = 0.1625;
			h = 0.06;
		};

		class CloseButton : w_RscButton {
			idc = close_button;
			text = "Close";
			onButtonClick = "[] execVM 'client\systems\playerMenu\closePlayerMenu.sqf'";
			x = 0.35;
			y = 0.74;
			w = 0.2625;
			h = 0.08;
		};

		class GroupsButton : w_RscButton {
			idc = groupButton;
			text = "Group Management";
			onButtonClick = "[] execVM 'client\systems\groups\loadGroupManagement.sqf'";
			x = 0.65;
			y = 0.74;
			w = 0.2625;
			h = 0.08;
		};

		class btnDistanceFar : w_RscButton {
			idc = -1;
			text = "View Distance";
			onButtonClick = "call CHVD_fnc_openDialog";
			x = 0.65;
			y = 0.64;
			w = 0.2625;
			h = 0.08;
		};

		class btnDistanceCustom : w_RscButton {
			idc = -1;
			text = "Messages";
			onButtonClick = "[] execVM 'addons\JTS_PM\JTS_PM.sqf'";
			x = 0.35;
			y = 0.64;
			w = 0.2625;
			h = 0.08;
		};

		class TOParmaInfoButton : w_RscButton {
			idc = -1;
			text = "A3Armory Info";
			onButtonClick = "[] execVM 'addons\TOParmaInfo\loadTOParmaInfo.sqf'";
			x = 0.65;
			y = 0.54;
			w = 0.2625;
			h = 0.08;
		};

		class uniformpaint: w_RscButton {
			idc = -1;
			text = "Paint Uniform";
			action = "closeDialog 0;[] execVM 'addons\UniformPainter\UniformPainter_Menu.sqf'";
			x = 0.65;
			y = 0.22;
			w = 0.2625;
			h = 0.08;
		};

		class vehrepaint: w_RscButton {
			idc = -1;
			text = "Paint Vehicle";
			action = "closeDialog 0;[] execVM 'addons\VehiclePainter\VehiclePainter_Check.sqf'";
			x = 0.65;
			y = 0.34;
			w = 0.2625;
			h = 0.08;
		};

		class airdrop: w_RscButton {
			idc = -1;
			text = "Airdrop Menu";
			action = "closeDialog 0;[] execVM 'addons\APOC_Airdrop_Assistance\APOC_cli_menu.sqf'";
			x = 0.35;
			y = 0.54;
			w = 0.2625;
			h = 0.08;
		};
	};
};
