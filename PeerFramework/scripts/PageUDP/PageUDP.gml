function MachineStateUDPInterface(MyMachine):MachineDebugUIState(MyMachine) constructor{
	_UDPData = self._Machine._PeerFrameworkData._CommunicationUDP;
	_CurrentWindow = "UDP Interface";
	_CurrentStatus = new SubPage(self); 
		
	ChangeStatus = function(){
		delete self._CurrentStatus;
		switch(self._UDPData._InternalDebugStatusKey){
			case UDPLocalStatus.NotAvailable:
				self._CurrentStatus = new SubPageUDPNotAvaliable(self);
			break;
			
			case UDPLocalStatus.NotStarted:
				self._CurrentStatus = new SubPageUDPNotStarted(self);
			break;
			
			case UDPLocalStatus.Started:
			
			break;
			
			case UDPLocalStatus.Failed:
			
			break;
		}	
	}
	
	Draw = function(){
		draw_text(10,90,$"Ammount of Allowed Connections: {self._UDPData._SocketGMLNativeAmmountOfPlayers}");
		draw_text(10,110,$"Min Port Value: {self._UDPData._InferiorPortRange}");
		draw_text(10,130,$"Max Port Value: {self._UDPData._UpperPortRange}");
		draw_text(10,150,$"Current Connection Status to Main Server: {self._UDPData._MainServerConnection}");
		draw_text(10,170,"-------------------------------------");
		draw_text(10,190,$"UDP State: {self._CurrentStatus._CurrentSubPageName}");
		
		self._CurrentStatus.Draw();
	}
	
	Step = function(){
		self._CurrentStatus.Step();
	}
	
	Notify = function(Identification,Data = noone){
		
	}
}