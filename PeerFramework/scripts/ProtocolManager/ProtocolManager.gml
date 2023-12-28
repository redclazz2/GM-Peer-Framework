function ProtocolManager(TickRate,MyMediator) constructor{
	_SubscribedProtocolsMap = ds_map_create();
	_Mediator = MyMediator;
	_SubscribedProtocolsArray = [];
	_InternalProtocolClock = 0;
	
	InitializeProtocolManager = function(){
		self._InternalProtocolClock = time_source_create(time_source_game,TickRate,time_source_units_frames,self.NotifySubscribersEngineTick,[],-1);
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
	
	DestroyProtocol = function(){
		
	}
	
	SubscribeProtocol =  function(){
	
	}
	
	UnSubscribeProtocol = function(){
	}
	
	NotifySubscribersEngineTick = function(){
	
	}
}