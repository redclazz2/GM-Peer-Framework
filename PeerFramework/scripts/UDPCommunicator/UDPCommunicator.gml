function InterfaceUDP(PlayerCount,MyMediator):CommunicationInterface(-1,MyMediator) constructor{
	_SocketGMLNativeAmmountOfPlayers = PlayerCount;
	_InferiorPortRange = 1024;
	_UpperPortRange = 65535;
	_CurrentWhiteList = -1; //TODO
	_InternalDebugStatusKey = UDPLocalStatus.NotAvailable;
	_InternalAuthenticationStatus = UDPAuthenticationStatus.NotAuthenticated;
	_InterfaceUDPBuffer = -1;
	_AuthenticationClock = -1;
	
	Create = function(){	
		var port = self._InferiorPortRange;
		do{
			self._Socket = network_create_server(network_socket_udp,port,self._SocketGMLNativeAmmountOfPlayers);
			port++;
		}until(self._Socket >= 0 || port > self._UpperPortRange);
			
		if(self._Socket < 0){
			logger(LOGLEVEL.ERROR,"Unable to bind port to UDP socket.","PeerFrameworkUDPCommunicationInterface");
			self._InternalDebugStatusKey = UDPLocalStatus.Failed;
			self._Mediator.Notify(MediatorNotificationKey.UDP,new NotificationData(UDPNotificationKey.SocketCreationFailed));
		}else{
			self._SocketGMLNativePort = port - 1;
			logger(LOGLEVEL.INFO,$"Created UDP Socket on port: {self._SocketGMLNativePort}","PeerFrameworkUDPCommunicationInterface");	
			self._InternalDebugStatusKey = UDPLocalStatus.Started;
			self._InterfaceUDPBuffer = buffer_create(256,buffer_grow,1);
			self._AuthenticationClock = time_source_create(time_source_global,2,time_source_units_seconds,self.AuthenticationProcedure,[],-1);
			self._Mediator.Notify(MediatorNotificationKey.UDP,new NotificationData(UDPNotificationKey.SocketCreationOk,self._SocketGMLNativePort));
		}
	}
	
	Destroy = function(){
		network_destroy(self._Socket);
		if buffer_exists(self._InterfaceUDPBuffer) buffer_delete(self._InterfaceUDPBuffer);
		self.DestroyAuthenticationTimer();
		self._Socket = -1;
		self._InterfaceUDPBuffer = -1;
		self._SocketGMLNativePort = -1;
		logger(LOGLEVEL.DEBUG,"Destroy Function!","PeerFrameworkUDPCommunicationInterface");
	}
	
	StartAuthenticationTimer = function(){
		time_source_start(self._AuthenticationClock);
	}
	
	DestroyAuthenticationTimer = function(){
		if(time_source_exists(self._AuthenticationClock)){
			time_source_stop(self._AuthenticationClock);
			time_source_destroy(self._AuthenticationClock);
			self._AuthenticationClock = -1;
		}
	}
	
	ChangeUDPStatus = function(NewStatus){
		_InternalDebugStatusKey = NewStatus;
	}
	
	AuthenticationProcedure = function(){
		if(self._InternalAuthenticationStatus == UDPAuthenticationStatus.NotAuthenticated){
			logger(LOGLEVEL.DEBUG,"Attempting UDP Authentication!","PeerFrameworkUDPCommunicationInterface");
			self._CurrentWriteAction = new UDPWriterSendAuthenticationRequest(self);
			self.HandleWriteData();
		}else{
			self.DestroyAuthenticationTimer();
		}
	}
	
	ChangeUDPInterpreter = function(){
	
	}
	
	HandleIncomingNetworkData = function(){
	
	}
	
	HandleWriteData = function(_data = undefined){
		if(self._InternalDebugStatusKey == UDPLocalStatus.Started)
			self._CurrentWriteAction.Write(_data);
	}
}