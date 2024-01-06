function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = -1; //Cleaned
	_CurrentProtocolManager = -1; //Cleaned
	_CommunicationTCP = -1; //Cleane
	_DebugUI = -1;
	
	Create = function(){
		self._CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
		
		self._CurrentProtocolManager = new ProtocolManager(self._CurrentConfiguration.GetConfTickRate,self);
		self._CurrentProtocolManager.Create();
		
		self.CreateTCPInterface();
		self.CreateUDPInterface();
		
		self._ServiceStation = new ServiceStation();
		self._ServiceStation.Create();
		
		self._DebugUI = new DebugUIMachine(self);
		self._DebugUI.Create();
		
		logger(LOGLEVEL.DEBUG,"Internet Mediator Initialized!", "PeerFrameworkInternetMediator");
	}
	
	Destroy = function(){
		delete self._CurrentConfiguration;
		self._CurrentConfiguration = -1;
		
		self._CurrentProtocolManager.Destroy();
		delete self._CurrentProtocolManager;
		self._CurrentProtocolManager = -1;
		
		self._CommunicationTCP.Destroy();
		delete self._CommunicationTCP;
		self._CommunicationTCP = -1;
		
		self._ServiceStation.Destroy();
		delete self._ServiceStation;
		self._ServiceStation = -1;
	}
	
	CreateTCPInterface = function(){
		self._CommunicationTCP =  new InterfaceTCP(8056,"127.0.0.1",self._CurrentConfiguration.GetConfGMLNativeUseNonBlockingSocket,self._CurrentConfiguration.GetConfGMLNativeConnectionTimeout(),self);
		self._CommunicationTCP.Create();
	}
	
	DestroyTCPInterface = function(){
		self._CommunicationTCP.Destroy();
		delete self._CommunicationTCP;
		self.CreateTCPInterface();	
		
		self.DestroyUDPInterface();
		self._ServiceStation.UnregisterAll();
		if(self._DebugUI._CurrentPage == 1 || self._DebugUI._CurrentPage == 3) self._DebugUI._CurrentStatus.ChangeStatus();
	}
	
	CreateUDPInterface = function(){
		self._CommunicationUDP = new InterfaceUDP(14,self);
		
		var CurrentTCPAppAuth = self._CommunicationTCP._ApplicationAuthorizationStatus; 		
		self._CommunicationUDP.ChangeUDPStatus(
			 CurrentTCPAppAuth == InterfaceTCPApplicationStatus.ConnectionUnknown ? UDPLocalStatus.NotAvailable :
			(CurrentTCPAppAuth == InterfaceTCPApplicationStatus.ConnectionAccepted ? UDPLocalStatus.NotStarted : UDPLocalStatus.NotAvailable));
	}
	
	InitializeUDPInterface = function(){
		if(self._CommunicationTCP._ApplicationAuthorizationStatus == InterfaceTCPApplicationStatus.ConnectionAccepted){
			self._CommunicationUDP.Create();
		}else logger(LOGLEVEL.ERROR,"Attempting to create a UDP server when TCP connection isn't available.","PeerFrameworkInternetMediator");
	}
		
	Notify = function(_sender,_data = noone){
		switch(_sender){
			case MediatorNotificationKey.DebugUI:
				self.HandleUINotification(_data);
			break;
			
			case MediatorNotificationKey.TCP:
				self.HandleTCPNotification(_data);
			break;
			
			case MediatorNotificationKey.IncomingNetworkData:
				self.HandleIncomingNetworkData(_data);
			break;
			
			case MediatorNotificationKey.UDP:
				self.HandleUDPNotification(_data);
			break;
		}
	}
	
	HandleUINotification = function(_data){
		switch(_data._Identification){
			case DebugUINotificationKey.TCPStart:
				self._CommunicationTCP.InitializeTCPCommunication();
			break;
			
			case DebugUINotificationKey.TCPDestroy:
				self.DestroyTCPInterface();
			break;
			
			case DebugUINotificationKey.UDPStart:
				self.InitializeUDPInterface();
			break;
			
			case DebugUINotificationKey.UDPDestroy:
				self.DestroyUDPInterface();
			break;
		}
	}
	
	HandleTCPNotification = function(_data){
		switch(_data._Identification){
			case TCPNotificationKey.Attempt:
				//Actions To Perform when TCP Attemps
			break;
			
			case TCPNotificationKey.Connected:
				logger(LOGLEVEL.DEBUG,"Connection Stablished with TCP server!","PeerFrameworkTCPCommunicationInterface");
				self._CommunicationTCP._InternalDebugStatusKey = InterfaceTCPProtocolStatus.Connected;
			break;
			
			case TCPNotificationKey.Failed:
				logger(LOGLEVEL.ERROR,"Unable to connect to TCP server!","PeerFrameworkTCPCommunicationInterface");
				self._CommunicationTCP._InternalDebugStatusKey = InterfaceTCPProtocolStatus.Failed;
			break;
			
			case TCPNotificationKey.ApplicationAccepted:
				logger(LOGLEVEL.INFO,"The main server authorized the connection!","PeerFrameworkTCPCommunicationInterface");
				self._ServiceStation.RegisterLocalStation(_data._Data[2],_data._Data[1],_data._Data[0]);
				self._CommunicationUDP.ChangeUDPStatus(UDPLocalStatus.NotStarted);	
			break;
			
			case TCPNotificationKey.ApplicationRejected:
				logger(LOGLEVEL.ERROR,"The main server rejected the connection!","PeerFrameworkTCPCommunicationInterface");
				self._CommunicationUDP.ChangeConnectionStatusToServer(InterfaceTCPApplicationStatus.ConnectionRejected);	
			break;
			
			case TCPNotificationKey.DataPortUDPReport:
				logger(LOGLEVEL.INFO,"The main server authorized the UDP connection!","PeerFrameworkTCPCommunicationInterface");
				self._ServiceStation.RegisterLocalStationReportedPortUDP(_data._Data);
				self._CommunicationUDP._InternalAuthenticationStatus = UDPAuthenticationStatus.Authenticated;
			break;
		}
		if(self._DebugUI._CurrentPage == 1 || self._DebugUI._CurrentPage == 3) self._DebugUI._CurrentStatus.ChangeStatus();
	}
	
	HandleUDPNotification = function(_data){
		switch(_data._Identification){
			case UDPNotificationKey.SocketCreationOk:
				self._ServiceStation.RegisterLocalStationLocalPortUDP(_data._Data);
				self._CommunicationUDP.StartAuthenticationTimer();
			break;
			
			case UDPNotificationKey.SocketCreationFailed:
			
			break;
		}
		
		if(self._DebugUI._CurrentPage == 3) self._DebugUI._CurrentStatus.ChangeStatus();
	}
	
	HandleIncomingNetworkData = function(_data){
		switch(_data._Identification){
			case IncomingNetworkType.TCP:
				var _IncomingIP = _data._Data[0],
					_IncomingPort = _data._Data[1],
					_IncomingBuffer = _data._Data[2];
				self._CommunicationTCP.HandleIncomingNetworkData(_IncomingIP,_IncomingPort,_IncomingBuffer);
			break;
			
			case IncomingNetworkType.UDP:
			
			break;
		}
	}
}