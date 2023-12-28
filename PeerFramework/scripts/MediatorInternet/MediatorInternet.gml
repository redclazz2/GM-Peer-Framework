function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,
		PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
	_CurrentProtocolManager = new ProtocolManager(self._CurrentConfiguration.GetConfTickRate,self);
	
	self._init = function(){
		self._CurrentProtocolManager.InitializeProtocolManager();
		logger(LOGLEVEL.DEBUG,"Internet Mediator Initialized!", "PeerFrameworkInternetMediator");
	}
	
	self._notify = function(){
		
	}
}