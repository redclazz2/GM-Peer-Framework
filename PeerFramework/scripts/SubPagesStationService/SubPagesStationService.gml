function SubPageStationServiceLocalNoData(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "No Local Station Data!";
}

function SubPageStationServiceLocalData(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Local Station Data: ";
	_LocalStationData = MyMainPage._StationServiceData.GetStationInformation(MyMainPage._StationServiceData._LocalStationConstantId);
	
	Draw = function(){
		draw_text(10,130,$"Constant ID: {_LocalStationData._ConstantId}");
		draw_text(10,150,$"IP Address: {_LocalStationData._Address._StationIPAddress}");
		draw_text(10,170,$"TCP Port: {_LocalStationData._Address._StationPortTCP}");
		draw_text(10,190,$"UDP Port: {_LocalStationData._Address._StationPortUDP}");
	}
}