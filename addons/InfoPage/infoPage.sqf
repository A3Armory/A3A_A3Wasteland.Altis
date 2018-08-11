// infoPage.sqf
// by CRE4MPIE
// ver 0.1
// 2015-02-01 01:20pm
// contributions from BIStudio Forums, by CRE4MPIE


sleep 20;   //delay before message is displayed after logging in
	
_text = "
<t align='center'><t shadow= 1 shadowColor='#000000'><t size='1.2'><t color='#ff0000'>A3Armory A3Wasteland</t>
<br />
<br />
<t align='center'><t size='1.2'><t shadow= 1 shadowColor='#000000'>Keyboard Shortcuts</t><br />
<br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\windows.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Player Names</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\end.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Insert/Remove Earplugs</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\v.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Open/Cut Parachute</t><br />
<t align='left'><img size='2' shadow = 0 image='addons\InfoPage\img\h.paa'/></t><t align='left'><t size='1'><t shadow= 1 shadowColor='#000000'> Holster Weapon</t><br />
<br />
<t align='center'><t size='1.2'><t shadow= 1 shadowColor='#0000ff'>Have fun and respect other players. Team killing or exploiting glitches will get you banned</t><br />
<t align='center'><img size='8' shadow = 0 image='addons\InfoPage\img\A3A.paa'/></t>
<br />";

hint parseText format ["<t align='center'>Welcome %2 to</t><br />%1",_text, name player];
 
 
