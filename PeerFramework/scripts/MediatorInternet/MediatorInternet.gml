function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = -1;
	_CurrentProtocolManager = -1;
	
	Initialize = function(){
		self._CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,
			PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
		
		self._CurrentProtocolManager = new ProtocolManager(self._CurrentConfiguration.GetConfTickRate,self);
		self._CurrentProtocolManager.InitializeProtocolManager();
		
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