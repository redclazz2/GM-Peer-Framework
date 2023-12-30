function PacketComplex(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType = buffer_grow, EncriptionEnabled = true)
	:Packet(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType, EncriptionEnabled) constructor{
	
	_RecievedNoticeMap = -1;
	
	InitializePacket = function(){
		self._DataBuffer = buffer_create(256,self._DataBufferType,1);
		self._RecievedNoticeMap = ds_map_create();
		
		for(var i = self._NumberOfDestinations; i < self._NumberOfDestinations; i++){
			ds_map_add(self._RecievedNoticeMap,DestinationStations[i],0);
		}
		
		logger(LOGLEVEL.DEBUG,"A complex packet has been initialized!",$"PeerFrameworkPacketComplex:{self._PacketId}");
	}
	
	UpdateRecievedNotice =  function(VariableId){
		if(ds_exists(self._RecievedNoticeMap,ds_type_map) && ds_map_exists(self._RecievedNoticeMap,VariableId)) ds_map_replace(self._RecievedNoticeMap,VariableId,1);
		else logger(LOGLEVEL.WARN,$"Unable to update recieved notice for {VariableId}. Given Id does not exists!", $"PeerFrameworkPacketComplex:{self._PacketId}");
	}
	
	HasPacketBeenRecievedByAll = function(){
		var _validMap = ds_exists(self._RecievedNoticeMap,ds_type_map),
			_recievedNoticeMapArray = _validMap ? ds_map_values_to_array(self._RecievedNoticeMap) : [],
			_recievedArrayLenght = _validMap ? array_length(_recievedNoticeMapArray) : -1,
		    _myCheck = true, 
			_i = 0;
	
		while ( _i < _recievedArrayLenght){
			if(_recievedNoticeMapArray[_i] == 0){
				_myCheck = false;
				_i = _recievedArrayLenght + 1;
			}else{
				_i ++;
			}
		}
		
		//Even if a packet's recieved map does not exists, the desire reaction is to dispose the packet.
		return _myCheck;
	}
	
	Destroy = function(){
		buffer_delete(self._DataBuffer);
		ds_map_destroy(self._RecievedNoticeMap);
		self._DataBuffer = -1;
		self._RecievedNoticeMap = -1;
		self._DestinationStations = -1;
	}
}