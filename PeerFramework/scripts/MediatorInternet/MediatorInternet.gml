function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = -1;
	_CurrentProtocolManager = -1;
	_CommunicationTCP = -1;
	
	Create = function(){
		self._CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,
			PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
		
		self._CurrentProtocolManager = new ProtocolManager(self._CurrentConfiguration.GetConfTickRate,self);
		self._CurrentProtocolManager.Create();
		
		self._CommunicationTCP =  new InterfaceTCP(8056,"127.0.0.1",1,4000,self);
		self._CommunicationTCP.Create();
		
		logger(LOGLEVEL.DEBUG,"Internet Mediator Initialized!", "PeerFrameworkInternetMediator");
	}
	
	Destroy = function(){
		delete self._CurrentConfiguration;
		self._CurrentConfiguration = -1;
		
		self._CurrentProtocolManager.Destroy();
		delete self._CurrentProtocolManager;
		self._CurrentProtocolManager = -1;
	}
	
	
	Notify = function(){
		
	}
}