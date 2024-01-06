function StationInformation(ConstantId,Address,Port,UDPLocal = -1,UDPReported = -1,NAT = StationNAT.Unknown) constructor{
	_ConstantId = ConstantId;
	_Address = new StationAddress(Address,Port,UDPLocal,UDPReported,NAT);
	_PlayerAppData = new PlayerInformation("Player");
	
	Destroy = function(){
		delete self._Address;
		delete self._PlayerAppData;
	}
	
	SetNewLocalPortUDP = function(NewPort){
		self._Address._StationPortUDPLocal = NewPort;
	}
	
	SetNewReportedPortUDP = function(NewPort){
		self._Address._StationPortUDPReported = NewPort;
		self._Address._StationNAT = self._Address._StationPortUDPLocal == self._Address._StationPortUDPReported ? StationNAT.Open : StationNAT.Dependent;
	}
	
	SetNewUsername = function(NewUsername){
		self._PlayerAppData.SetUsername(NewUsername);
	}
}