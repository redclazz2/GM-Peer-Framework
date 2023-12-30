function PacketManager() constructor{
	_SentPacketRegistryData = -1;
	_SentPacketRegistryId = -1;
	_RecievedPacketRegistry = -1;
	
	InitializePacketManager = function(){
		self._SentPacketRegistryData = ds_map_create();
		self._SentPacketRegistryId = ds_map_create();
		self._RecievedPacketRegistry = ds_map_create();
	}
	
	//TODO Properly destroy all the packets from each map.
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
	CreateLocalPacket = function(_PacketType){
		switch(_PacketType){
			case PeerFrameworkPacketTypes.SimplePacket:
			break;
			
			case PeerFrameworkPacketTypes.ComplexPacket:
			break;
			
			case PeerFrameworkPacketTypes.TCP:
			break;
		}
	}
	
	GeneratePacketID = function(){
		/*
			This will return random integers from 0 to 4,294,967,294. 
			The value is in range for transportation in the buffer type buffer_u32
			and it is in range for the irandom function that has an upper limit of 9,223,372,036,854,775,807.
			
			If needed the value can be xpanded from FFFFFFFE to 7FFFFFFFFFFFFFFE.
			Making the max id possible: 9223372036854775806 one digit below the function's limits
			and ready for transport in buffer type buffer_u64.
		*/
		var _intended = irandom($FFFFFFFE);
		
		while(ds_map_exists(self._SentPacketRegistryId,_intended) || ds_map_exists(self._RecievedPacketRegistry,_intended)){
			_intended = irandom($FFFFFFFE);
		}
		
		return _intended;
	}
	
	//TODO
	RegisterRecievedPacket = function(){
	}
	
	//TODO Returns Packet
	GetPacketFromRegistry = function(){
	
	}
	
	//TODO
	RemovePacketFromSentRegistryData = function(){}
	
	ClearRegistry = function(){
	
	}
}