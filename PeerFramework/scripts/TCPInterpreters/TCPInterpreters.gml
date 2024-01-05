function InterpreterTCPInitialStationDataReport(Interface):NetworkDataInterpreter(Interface) constructor{
	HandleIncomingNetworkData = function(_Ip,_Port,_Buffer){
		
		var ReceivedApplicationStatus = buffer_read(_Buffer,buffer_u16),
			ReceivedStationIPAddress = buffer_read(_Buffer,buffer_string),
			ReceivedStationTCPPort = buffer_read(_Buffer,buffer_string),
			ReceivedStationConstantId = buffer_read(_Buffer,buffer_u16);
			
		self._CommunicationInterface._ApplicationAuthorizationStatus = ReceivedApplicationStatus;
		self._CommunicationInterface._Mediator.Notify(MediatorNotificationKey.TCP,
			new NotificationData(ReceivedApplicationStatus == InterfaceTCPApplicationStatus.ConnectionAccepted ? TCPNotificationKey.ApplicationAccepted : TCPNotificationKey.ApplicationRejected,
				[ReceivedStationIPAddress,ReceivedStationTCPPort,ReceivedStationConstantId]));
	}
}