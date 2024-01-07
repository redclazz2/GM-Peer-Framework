function Protocol(ProtocolId,MyProtocolManager) constructor{
	_ProtocolId = ProtocolId;
	_PacketQueue = -1;
	_Manager = MyProtocolManager;
	
	Create = function(){
		self._PacketQueue = ds_queue_create();
		logger(LOGLEVEL.DEBUG,"A protocol has been initialized!","PeerFrameworkProtocols");
	}
	
	AddPackageIdToQueue = function(PackageId){
		ds_queue_enqueue(self._PacketQueue,PackageId);
	}
	
	GetPacketQueueLength = function(){
		return ds_queue_size(self._PacketQueueet);
	}
	
	HandleEngineTick = function(){
		logger(LOGLEVEL.WARN,"Function isn't defined for interface protocol. Please use one of the protocol types.","PeerFrameworkProtocolInterface");
	}
	
	//TODO Dequeue every item and clean data inside each packet
	Destroy = function(){
		
	}
}