function InternetMediator(): Mediator() constructor{
	_CurrentConfiguration = new PeerConfiguration(PeerConfigurationNetworkType.Internet,PeerConfigurationTickRate.DesktopTick,
		PeerConfigurationNetDev.Development, PeerConfigurationIpVersion.IPv4);
	
	self._notify = function(){
		
	}
}