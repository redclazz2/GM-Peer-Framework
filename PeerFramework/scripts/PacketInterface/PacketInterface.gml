function Packet(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType = buffer_grow, EncriptionEnabled = true) constructor{
	_PacketId = PacketId;
	_EncriptionEnabled = EncriptionEnabled;
	_NumberOfDestinations = NumberOfDestinations;
	_DestinationStations = [];
	_ProtocolType = ProtocolType;
	_ServiceType = ServiceType;
	_DataBuffer = -1;
	_DataBufferType = DataBufferType;
	
	InitializePacket = function(){
		self._DataBuffer = buffer_create(256,self._DataBufferType,1);
		logger(LOGLEVEL.DEBUG,"A packet has been initialized!",$"PeerFrameworkPacketInterface:{self._PacketId}");
	}
	
	Destroy = function(){
		buffer_delete(self._DataBuffer);
		self._DataBuffer = -1;
		self._DestinationStations = -1;
	}
}