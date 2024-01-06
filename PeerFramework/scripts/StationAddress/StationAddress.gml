function StationAddress(StationIP,StationPort,UDPLocal = -1,UDPReported = -1,NAT = StationNAT.Unknown) constructor{
	_StationIPAddress = StationIP;
	_StationPortTCP = StationPort;
	_StationPortUDPLocal = UDPLocal;
	_StationPortUDPReported = UDPReported;
	_StationNAT = NAT;
}