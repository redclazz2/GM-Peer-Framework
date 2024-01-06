function Mediator() constructor{
	_CommunicationUDP = -1;
	_ServiceStation = -1; //Cleaned
	
	Create =  function(){};
	Destroy = function(){};
	Notify =  function(){};
	
	CreateUDPInterface = function(){
		self._CommunicationUDP = new InterfaceUDP(14,self);	
		self._CommunicationUDP.ChangeUDPStatus(UDPLocalStatus.NotStarted);
	}

	DestroyUDPInterface = function(){
		self._CommunicationUDP.Destroy();
		delete self._CommunicationUDP;
		self.CreateUDPInterface();
		
		self._ServiceStation.RegisterLocalStationLocalPortUDP(-1);
		self._ServiceStation.RegisterLocalStationReportedPortUDP(-1);
				
		if(self._DebugUI._CurrentPage == 3) self._DebugUI._CurrentStatus.ChangeStatus();
	}
}