function SubPageStationServiceLocalNoData(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "No Local Station Data!";
}

function SubPageStationServiceLocalData(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Local Station Data: ";
	_LocalStationData = MyMainPage._StationServiceData.GetStationInformation(MyMainPage._StationServiceData._LocalStationConstantId);
	_LocalNAT = self._LocalStationData._Address._StationNAT == StationNAT.Unknown ? "Unknown" : (self._LocalStationData._Address._StationNAT == StationNAT.Open ? "Open" : "Dependent");
	
	Draw = function(){
		draw_text(10,130,$"Constant ID: {self._LocalStationData._ConstantId}");
		draw_text(10,150,$"IP Address: {self._LocalStationData._Address._StationIPAddress}");
		draw_text(10,170,$"TCP Port: {self._LocalStationData._Address._StationPortTCP}");
		draw_text(10,190,$"UDP Local Port: {self._LocalStationData._Address._StationPortUDPLocal}");
		draw_text(10,210,$"UDP Reachable Port: {self._LocalStationData._Address._StationPortUDPReported}");
		draw_text(10,230,$"NAT Behavior: {self._LocalNAT}");
	}
}