function StationInformation(ConstantId,Address,Port) constructor{
	_ConstantId = ConstantId;
	_Address = new StationAddress(Address,Port);
	_PlayerAppData = new PlayerInformation("Player");
	
	Destroy = function(){
		delete self._Address;
		delete self._PlayerAppData;
	}
	
	SetNewPortUDP = function(NewPort){
		self._Address.SetPortUDP(NewPort);
	}
	
	SetNewUsername = function(NewUsername){
		self._PlayerAppData.SetUsername(NewUsername);
	}
}