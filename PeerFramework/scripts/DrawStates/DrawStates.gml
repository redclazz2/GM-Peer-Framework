function MachineState(MyMachine) constructor{
	_Machine = MyMachine;
	_CurrentWindow = "N/A";
	Draw =  function(){}
}

function MachineStateConfiguration(MyMachine):MachineState(MyMachine) constructor{
	_ConfigurationData =  self._Machine._PeerFrameworkData._CurrentConfiguration;
	_CurrentWindow = "Configuration";
	
	Draw = function(){
		draw_text(10,90,$"Debug: {self._ConfigurationData._ConfNetDev}");
		draw_text(10,110,$"Framework Version: {self._ConfigurationData._ConfFrameworkVersion}");
		draw_text(10,130,$"Network Type: {self._ConfigurationData._ConfNetworkType}");
		draw_text(10,150,$"Ip Version: {self._ConfigurationData._ConfIpVersion}");
		draw_text(10,170,$"Tick Rate: {self._ConfigurationData._ConfTickRate}. (2 -> 30Hz, 4 -> 15Hz)");
		draw_text(10,190,$"Connection Timeout: {self._ConfigurationData._ConfGMLNativeConnectionTimeout}");
		draw_text(10,210,$"Use Non Blocking Socket : {self._ConfigurationData._ConfGMLNativeUseNonBlockingSocket}");
	}
}