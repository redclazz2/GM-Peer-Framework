function MachineStateStationService(MyMachine):MachineDebugUIState(MyMachine) constructor{
	_StationServiceData = self._Machine._PeerFrameworkData._ServiceStation;
	_CurrentWindow = "Station Service";
	_CurrentLocalDraw = -1;
	
	ChangeStatus = function(){
		delete self._CurrentLocalDraw;
		self._CurrentLocalDraw = self._StationServiceData.GetStationInformation(self._StationServiceData._LocalStationConstantId) == undefined 
			? new SubPageStationServiceLocalNoData(self) : new SubPageStationServiceLocalData(self);
	}
	
	Draw =  function(){
		draw_text(10,90,"-------------------------------------");
		draw_text(10,110, $"{self._CurrentLocalDraw._CurrentSubPageName}");
		draw_text(10,230,"-------------------------------------");
		
		self._CurrentLocalDraw.Draw();
	}
}