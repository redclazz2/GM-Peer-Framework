function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = -1;
	_CurrentProtocolManager = new ProtocolManager(self._CurrentConfiguration.GetConfTickRate,self);
	
	Initialize = function(){
		self._CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,
			PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
		self._CurrentProtocolManager.InitializeProtocolManager();
		
		
		logger(LOGLEVEL.DEBUG,"Internet Mediator Initialized!", "PeerFrameworkInternetMediator");
	}
	
	Destroy = function(){
		
		delete _CurrentConfiguration;
		_CurrentConfiguration = -1;
	}
	
	
	Notify = function(){
		
	}
}