function ServiceStation() constructor{
	_StationMapData = -1;
	_CommunicationProtocol = -1;
	_LocalStationConstantId = -1;
	
	Create =  function(){
		self._StationMapData = ds_map_create();
		logger(LOGLEVEL.DEBUG,"Station service initialized!","PeerFrameworkStationService");
	}
	
	Destroy = function(){
		var _ArrayMap = ds_map_values_to_array(self._StationMapData);
		for(var i = 0; i < _ArrayMap.length; i++){
			_ArrayMap[i].Destroy();
			delete _ArrayMap[i];
			_ArrayMap[i] = -1;
		}
		
		ds_map_destroy(self._StationMapData);
	}
	
	RegisterLocalStation = function(_ConstantId,_StationPortTCP,_StationAddress){
		self._LocalStationConstantId = _ConstantId;
		ds_map_add(self._StationMapData,_ConstantId,new StationInformation(_ConstantId,_StationAddress,_StationPortTCP));
	}
	
	GetStationInformation = function(_ConstantId){
		var myReturn = undefined;
		if(ds_exists(self._StationMapData,ds_type_map)) myReturn = ds_map_find_value(self._StationMapData,_ConstantId);
		return myReturn;
	}
}