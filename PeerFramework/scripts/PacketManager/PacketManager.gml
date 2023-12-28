function PacketManager() constructor{
	_SentPacketRegistryData = -1;
	_SentPacketRegistryId = -1;
	_RecievedPacketRegistry = -1;
	
	InitializePacketManager = function(){
		self._SentPacketRegistryData = ds_map_create();
		self._SentPacketRegistryId = ds_map_create();
		self._RecievedPacketRegistry = ds_map_create();
	}
	
	Destroy = function(){
		self.ClearRegistry();
		ds_map_destroy(self._SentPacketRegistryData);
		ds_map_destroy(self._SentPacketRegistryId);
		ds_map_destroy(self._RecievedPacketRegistry);
		self._SentPacketRegistryData = -1;
		self._SentPacketRegistryId = -1;
		self._RecievedPacketRegistry = -1;
	}
	
	//TODO Return Number
	CreateLocalPacket = function(){
	
	}
	
	//TODO Return Number
	GeneratePacketID = function(){
	}
	
	//TODO
	RegisterRecievedPacket = function(){
	}
	
	//TODO Returns Packet
	GetPacketFromRegistry = function(){}
	
	//TODO
	RemovePacketFromSentRegistryData = function(){}
	
	ClearRegistry = function(){
	
	}
}