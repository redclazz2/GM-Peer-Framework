function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = -1;
	_CurrentProtocolManager = -1;
	_CommunicationTCP = -1;
	_DebugUI = -1;
	
	Create = function(){
		self._CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,
			PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
		
		self._CurrentProtocolManager = new ProtocolManager(self._CurrentConfiguration.GetConfTickRate,self);
		self._CurrentProtocolManager.Create();
		
		self.CreateTCPInterface();
		
		self._DebugUI = new DebugUIMachine(self);
		self._DebugUI.Create();
		
		logger(LOGLEVEL.DEBUG,"Internet Mediator Initialized!", "PeerFrameworkInternetMediator");
	}
	
	CreateTCPInterface = function(){
		self._CommunicationTCP =  new InterfaceTCP(8056,"127.0.0.1",self._CurrentConfiguration.GetConfGMLNativeUseNonBlockingSocket,self._CurrentConfiguration.GetConfGMLNativeConnectionTimeout(),self);
		self._CommunicationTCP.Create();
	}
	
	Destroy = function(){
		delete self._CurrentConfiguration;
		self._CurrentConfiguration = -1;
		
		self._CurrentProtocolManager.Destroy();
		delete self._CurrentProtocolManager;
		self._CurrentProtocolManager = -1;
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
		}
	}
	
	HandleUINotification = function(_data){
		switch(_data._Identification){
			case DebugUINotificationKey.TCPStart:
				self._CommunicationTCP.InitializeTCPCommunication();
			break;
			
			case DebugUINotificationKey.TCPDestroy:
				self._CommunicationTCP.Destroy();
				delete self._CommunicationTCP;
				self.CreateTCPInterface();
				if(self._DebugUI._CurrentPage == 1) self._DebugUI._CurrentStatus.ChangeTCPData();
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
		}
		
		if(self._DebugUI._CurrentPage == 1) self._DebugUI._CurrentStatus.ChangeTCPStatus();
	}
	
	HandleIncomingNetworkData = function(_data){
		switch(_data._Identification){
			case IncomingNetworkType.TCP:
			
			break;
			
			case IncomingNetworkType.UDP:
			
			break;
		}
	}
}