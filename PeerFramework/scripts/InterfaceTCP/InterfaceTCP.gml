function InterfaceTCP(MyPort,MyIp,BlockingSocket,Timeout,MyMediator):CommunicationInterface(MyPort,MyMediator) constructor{
	_SocketGMLNativeRemoteIp = MyIp;
	_UseNonBlockingSocket = BlockingSocket;
	_ConnectionTimeout = Timeout;
	_InterfaceTCPBuffer = -1;
	
	Create = function(){
		network_set_config(network_config_connect_timeout,self._ConnectionTimeout);
		network_set_config(network_connect_nonblocking,self._UseNonBlockingSocket);
		self._Socket = network_create_socket(network_socket_tcp);
		self._InterfaceTCPBuffer = buffer_create(256,buffer_grow,1);
		logger(LOGLEVEL.DEBUG,"TCP Communication Interface Created!","PeerFrameworkTCPCommunicationInterface");
	}
	
	Destroy = function(){
		network_destroy(self._Socket);
		self._Socket = -1;
		buffer_delete(self._InterfaceTCPBuffer);
	}
	
	InitializeTCPCommunication = function(){
		var connection = network_connect_raw(self._Socket,self._SocketGMLNativeRemoteIp,self._SocketGMLNativePort);
		
		if(connection < 0){
			logger(LOGLEVEL.ERROR,"Unable to connect to TCP server!","PeerFrameworkTCPCommunicationInterface");
		}else{
			logger(LOGLEVEL.ERROR,"Connection Stablished with TCP server!","PeerFrameworkTCPCommunicationInterface");
		}	
	}
}