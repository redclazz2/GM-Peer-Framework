function MachineStateTCPInterface(MyMachine):MachineDebugUIState(MyMachine) constructor{
	_TCPData = self._Machine._PeerFrameworkData._CommunicationTCP;
	_CurrentWindow = "TCP Interface";
	_CurrentStatus = new SubPage(self); 
		
	ChangeTCPStatus = function(){
		switch(self._TCPData._InternalDebugStatusKey){
			case InterfaceTCPProtocolStatus.Attempt:
				self._CurrentStatus = new SubPageTCPAttempt(self);
			break;
			
			case InterfaceTCPProtocolStatus.NotStarted:
				self._CurrentStatus = new SubPageTCPNotStarted(self);
			break;
			
			case InterfaceTCPProtocolStatus.Connected:
				self._CurrentStatus = new SubPageTCPConnected(self);
			break;
			
			case InterfaceTCPProtocolStatus.Failed:
				self._CurrentStatus = new SubPageTCPFailed(self);
			break;
		}	
	}
	
	ChangeTCPData = function(){
		self._TCPData = self._Machine._PeerFrameworkData._CommunicationTCP;
		self.ChangeTCPStatus();
	}
	
	Draw = function(){
		draw_text(10,90,$"Target IP: {self._TCPData._SocketGMLNativeRemoteIp}");
		draw_text(10,110,$"Target Port: {self._TCPData._SocketGMLNativePort}");
		draw_text(10,130,"-------------------------------------");
		draw_text(10,150,$"TCP Connection State: {self._CurrentStatus._CurrentSubPageName}");
		self._CurrentStatus.Draw();
	}
	
	Step = function(){
		self._CurrentStatus.Step();
	}
	
	Notify = function(Identification,Data = noone){
		self._Machine.Notify(Identification,Data);
	}
}