function InterpreterTCPInitialStationDataReport(Interface):NetworkDataInterpreter(Interface) constructor{
	HandleIncomingNetworkData = function(_Ip,_Port,_Buffer){
		
		var ReceivedApplicationStatus = buffer_read(_Buffer,buffer_u16),
			ReceivedStationIPAddress = buffer_read(_Buffer,buffer_string),
			ReceivedStationTCPPort = buffer_read(_Buffer,buffer_string),
			ReceivedStationConstantId = buffer_read(_Buffer,buffer_u16);
			
		self._CommunicationInterface._ApplicationAuthorizationStatus = ReceivedApplicationStatus;
		
		logger(LOGLEVEL.INFO,$"Ip received from server: {ReceivedStationIPAddress}","TCP Interpreter");
		logger(LOGLEVEL.INFO,$"Port received from server: {ReceivedStationTCPPort}","TCP Interpreter");
		logger(LOGLEVEL.INFO,$"ConstantId received from server: {ReceivedStationConstantId}","TCP Interpreter");
	}
}