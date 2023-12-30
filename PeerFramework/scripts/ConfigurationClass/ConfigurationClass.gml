function PeerConfiguration(NetType,TickRate,NetDev,IpVersion,ConnectionTimeout = 4000, NonBlockingSocket = 1) constructor{
	_ConfNetworkType = NetType;
	_ConfTickRate = TickRate;
	_ConfNetDev = NetDev;
	_ConfIpVersion = IpVersion;
	_ConfFrameworkVersion = 1;
	_ConfGMLNativeConnectionTimeout = ConnectionTimeout;
	_ConfGMLNativeUseNonBlockingSocket = NonBlockingSocket;
	
	GetConfNetworkType = function(){
		return self._ConfNetworkType;
	}
	
	GetConfTickRate = function(){
		return self._ConfTickRate;
	}
	
	GetConfNetDev =  function(){
		return self._ConfNetDev;
	}
	
	GetConfIpVersion = function(){
		return self._ConfIpVersion;
	}
	
	GetConfFrameworkVersion =  function(){
		return self._ConfFrameworkVersion;
	}
	
	GetConfGMLNativeConnectionTimeout =  function(){
		return self._ConfGMLNativeConnectionTimeout;
	}
	
	GetConfGMLNativeUseNonBlockingSocket =  function(){
		return self._ConfGMLNativeUseNonBlockingSocket;
	}
}

enum PeerConfigurationNetworkType{
	Lan,
	Internet
}

enum PeerConfigurationTickRate{
	DesktopTick = 2,
	MobileTick = 4
}

enum PeerConfigurationNetDev{
	Retail,
	Development
}

enum PeerConfigurationIpVersion{
	IPv4,
	IPv6
}