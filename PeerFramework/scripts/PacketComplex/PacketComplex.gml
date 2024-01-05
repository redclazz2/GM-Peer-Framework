function PacketComplex(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType = buffer_grow, EncriptionEnabled = true)
	:Packet(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType, EncriptionEnabled) constructor{
	
	_ReceivedNoticeMap = -1;
	
	InitializePacket = function(){
		self._DataBuffer = buffer_create(256,self._DataBufferType,1);
		self._ReceivedNoticeMap = ds_map_create();
		
		for(var i = self._NumberOfDestinations; i < self._NumberOfDestinations; i++){
			ds_map_add(self._ReceivedNoticeMap,DestinationStations[i],0);
		}
		
		logger(LOGLEVEL.DEBUG,"A complex packet has been initialized!",$"PeerFrameworkPacketComplex:{self._PacketId}");
	}
	
	UpdateReceivedNotice =  function(VariableId){
		if(ds_exists(self._ReceivedNoticeMap,ds_type_map) && ds_map_exists(self._ReceivedNoticeMap,VariableId)) ds_map_replace(self._ReceivedNoticeMap,VariableId,1);
		else logger(LOGLEVEL.WARN,$"Unable to update received notice for {VariableId}. Given Id does not exists!", $"PeerFrameworkPacketComplex:{self._PacketId}");
	}
	
	HasPacketBeenReceivedByAll = function(){
		var _validMap = ds_exists(self._ReceivedNoticeMap,ds_type_map),
			_receivedNoticeMapArray = _validMap ? ds_map_values_to_array(self._ReceivedNoticeMap) : [],
			_receivedArrayLenght = _validMap ? array_length(_receivedNoticeMapArray) : -1,
		    _myCheck = true, 
			_i = 0;
	
		while ( _i < _receivedArrayLenght){
			if(_receivedNoticeMapArray[_i] == 0){
				_myCheck = false;
				_i = _receivedArrayLenght + 1;
			}else{
				_i ++;
			}
		}
		
		//Even if a packet's received map does not exists, the desire reaction is to dispose the packet.
		return _myCheck;
	}
	
	Destroy = function(){
		buffer_delete(self._DataBuffer);
		ds_map_destroy(self._ReceivedNoticeMap);
		self._DataBuffer = -1;
		self._ReceivedNoticeMap = -1;
		self._DestinationStations = -1;
	}
}