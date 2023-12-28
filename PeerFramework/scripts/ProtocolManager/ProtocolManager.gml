function ProtocolManager(TickRate,MyMediator) constructor{
	_SubscribedProtocolsMap = ds_map_create();
	_Mediator = MyMediator;
	_SubscribedProtocolsArray = [];
	_InternalProtocolClock = 0;
	_TickRate = TickRate;
	
	InitializeProtocolManager = function(){
		self._InternalProtocolClock = time_source_create(time_source_game,_TickRate,time_source_units_frames,self.NotifySubscribersEngineTick,[],-1);
		time_source_start(self._InternalProtocolClock);
		logger(LOGLEVEL.DEBUG,"Protocol Manager Initialized!", "PeerFrameworkProtocolManager");
	}
	
	Destroy = function(){
		ds_map_destroy(self._SubscribedProtocolsMap);
		time_source_stop(self._InternalProtocolClock);
		time_source_destroy(self._InternalProtocolClock);
		_SubscribedProtocolsArray = 0;
	}
	
	UpdateSubscribedProtocolsArray = function(){
		self._SubscribedProtocolsArray =  ds_map_values_to_array(_SubscribedProtocolsMap);
	}
	
	//TODO
	InitializeProtocol = function(ProtocolType){		
		var _NewProtocol = 0;
		
		switch(ProtocolType){
			case ProtocolTypes.Unreliable:
			break;
			
			case ProtocolTypes.Reliable:
			break;
			
			case ProtocolTypes.Event:
			break;
		}
		
		ds_map_add(self._SubscribedProtocolsMap,_NewProtocol._ProtocolId,_NewProtocol);
		self.UpdateSubscribedProtocolsArray();
	}
	
	//TODO
	DestroyProtocol = function(){
		
	}
	
	SubscribeProtocol =  function(ProtocolToRegister){
		ds_map_add(self._SubscribedProtocolsMap,ProtocolToRegister._ProtocolId,ProtocolToRegister);
		self.UpdateSubscribedProtocolsArray();
	}
	
	UnSubscribeProtocol = function(ProtocolToUnSubscribe){
		ds_map_delete(self._SubscribedProtocolsMap,ProtocolToUnSubscribe._ProtocolId);
		self.UpdateSubscribedProtocolsArray();
	}
	
	//TODO
	NotifySubscribersEngineTick = function(){
		//logger(LOGLEVEL.DEBUG,"Protocol Manager Subscriber Update!", "PeerFrameworkProtocolManager");
	}
}