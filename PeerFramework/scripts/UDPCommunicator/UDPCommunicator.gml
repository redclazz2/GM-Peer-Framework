function InterfaceUDP(PlayerCount,MyMediator):CommunicationInterface(-1,MyMediator) constructor{
	_SocketGMLNativeAmmountOfPlayers = PlayerCount;
	_InferiorPortRange = 1024;
	_UpperPortRange = 65535;
	_CurrentWhiteList = -1; //TODO
	_MainServerConnection = -1;
	_InternalDebugStatusKey = UDPLocalStatus.NotAvailable;
	
	Create = function(){
		if(self._MainServerConnection == InterfaceTCPApplicationStatus.ConnectionAccepted){
			//From: https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Reference%2FNetworking%2Fnetwork_create_server.htm
			var port = self._InferiorPortRange;
			self._Socket = network_create_server(network_socket_udp,port,self._SocketGMLNativeAmmountOfPlayers);
			while (self._Socket < 0 && port < self._UpperPortRange){
			    port ++;
			    self._Socket = network_create_server(network_socket_udp,port,self._SocketGMLNativeAmmountOfPlayers);
			}
			self._SocketGMLNativePort = port;
			
			if(self._Socket < 0){
				logger(LOGLEVEL.ERROR,"Unable to bind port to UDP socket.","PeerFrameworkUDPCommunicationInterface");
				self._InternalDebugStatusKey = UDPLocalStatus.Failed;
				self._Mediator.Notify(MediatorNotificationKey.UDP);
			}else{
				logger(LOGLEVEL.INFO,$"Created UDP Socket on port: {self._SocketGMLNativePort}","PeerFrameworkUDPCommunicationInterface");
				self._InternalDebugStatusKey = UDPLocalStatus.Started;
				self._Mediator.Notify(MediatorNotificationKey.UDP,new NotificationData(UDPNotificationKey.SocketCreationOk,self._SocketGMLNativePort));
			}
		}else logger(LOGLEVEL.ERROR,$"Attempted to create a UDP server while having no authorization from main server","PeerFrameworkUDPCommunicationInterface");
	}
	
	Destroy = function(){
		network_destroy(self._Socket);
		self._Socket = -1;
		self._MainServerConnection = -1;
		self._SocketGMLNativePort = -1;
		self._InternalDebugStatusKey = UDPLocalStatus.NotAvailable;
		logger(LOGLEVEL.DEBUG,"Destroy Function!","PeerFrameworkUDPCommunicationInterface");
	}
	
	ChangeConnectionStatusToServer = function(MainServerConnection){
		_MainServerConnection = MainServerConnection;
		_InternalDebugStatusKey = self._MainServerConnection == InterfaceTCPApplicationStatus.ConnectionAccepted ? UDPLocalStatus.NotStarted : UDPLocalStatus.NotAvailable;
	}
	
	HandleIncomingNetworkData = function(){
	
	}
}