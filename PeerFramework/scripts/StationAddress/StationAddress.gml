function StationAddress(StationIP,StationPort) constructor{
	_StationIPAddress = StationIP;
	_StationPortTCP = StationPort;
	_StationPortUDP = -1;
	
	SetPortUDP = function(Port){
		self._StationPortUDP = Port;
	}
}