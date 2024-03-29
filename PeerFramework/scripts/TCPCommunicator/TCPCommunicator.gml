function InterfaceTCP(MyPort,MyIp,BlockingSocket,Timeout,MyMediator):CommunicationInterface(MyPort,MyMediator) constructor{
	_SocketGMLNativeRemoteIp = MyIp;
	_UseNonBlockingSocket = BlockingSocket;
	_ConnectionTimeout = Timeout;
	_InterfaceTCPBuffer = -1;
	_InternalDebugStatusKey = InterfaceTCPProtocolStatus.NotStarted;
	_ApplicationAuthorizationStatus = InterfaceTCPApplicationStatus.ConnectionUnknown;
		
	#region Create Destroy & Initializer
	
	Create = function(){
		network_set_config(network_config_connect_timeout,self._ConnectionTimeout);
		network_set_config(network_connect_nonblocking,self._UseNonBlockingSocket);
		self._Socket = network_create_socket(network_socket_tcp);
		self._InterfaceTCPBuffer = buffer_create(256,buffer_grow,1);
		logger(LOGLEVEL.DEBUG,"TCP Communication Interface Initialized!","PeerFrameworkTCPCommunicationInterface");
	}
	
	Destroy = function(){		
		network_destroy(self._Socket);
		self._Socket = -1;
		buffer_delete(self._InterfaceTCPBuffer);
		self._InterfaceTCPBuffer = -1;
		logger(LOGLEVEL.DEBUG,"Destroy Function!","PeerFrameworkTCPCommunicationInterface");
	}
	
	InitializeTCPCommunication = function(){
		logger(LOGLEVEL.INFO,"Attempting TCP Communication to Server ...","PeerFrameworkTCPCommunicationInterface");
		self._InternalDebugStatusKey = InterfaceTCPProtocolStatus.Attempt;
		self._Mediator.Notify(MediatorNotificationKey.TCP,new NotificationData(TCPNotificationKey.Attempt));
		network_connect_raw_async(self._Socket,self._SocketGMLNativeRemoteIp,self._SocketGMLNativePort);	
	}
	
	#endregion
	
	#region Writer
	
	ChangeTCPWriter = function(_Writer){
		if(!is_undefined(_Writer)) self._CurrentWriteAction = _Writer;
	}
	
	HandleWriteData = function(_data = undefined){
		if(self._ApplicationAuthorizationStatus == InterfaceTCPApplicationStatus.ConnectionAccepted)
			self._CurrentWriteAction.Write(_data);
	}
	
	#endregion
	
	
	#region Interpreter
	HandleIncomingNetworkData = function(_Ip,_Port,_Buffer){
		var _IncomingTCPMessageType = buffer_read(_Buffer,buffer_u16);
		delete self._CurrentIncomeNetworkDataInterpreter;
		
		switch(_IncomingTCPMessageType){
			case TCPMessageTypes.InitialStationDataReport:
				logger(LOGLEVEL.INFO,"Received initial station data report from server!","PeerFrameworkTCPCommunicationInterface");
				self._CurrentIncomeNetworkDataInterpreter = new InterpreterTCPInitialStationDataReport(self);
			break;
			
			case TCPMessageTypes.StationUDPDataReport:
				logger(LOGLEVEL.INFO,"Received UDP station data report from server!","PeerFrameworkTCPCommunicationInterface");
				self._CurrentIncomeNetworkDataInterpreter = new InterpreterTCPIncomingUDPReport(self);
			break;
		}
		
		self._CurrentIncomeNetworkDataInterpreter.HandleIncomingNetworkData(_Ip,_Port,_Buffer);
	}
	#endregion
}