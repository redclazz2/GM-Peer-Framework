function ServiceStation() constructor{
	_StationMapData = -1;
	_CommunicationProtocol = -1;
	_LocalStationConstantId = -1;
	
	Create =  function(){
		self._StationMapData = ds_map_create();
		logger(LOGLEVEL.DEBUG,"Station service initialized!","PeerFrameworkStationService");
	}
	
	Destroy = function(){
		self.UnregisterAll();
		ds_map_destroy(self._StationMapData);
	}
	
	RegisterLocalStation = function(_ConstantId,_StationPortTCP,_StationAddress){
		self._LocalStationConstantId = _ConstantId;
		ds_map_add(self._StationMapData,_ConstantId,new StationInformation(_ConstantId,_StationAddress,_StationPortTCP));
	}
	
	RegisterLocalStationLocalPortUDP = function(NewPort){
		var LocalStation = ds_map_find_value(self._StationMapData,self._LocalStationConstantId);
		if(LocalStation != undefined) LocalStation.SetNewLocalPortUDP(NewPort);
	}
	
	RegisterLocalStationReportedPortUDP = function(NewPort){
		var LocalStation = ds_map_find_value(self._StationMapData,self._LocalStationConstantId);
		if(LocalStation != undefined) LocalStation.SetNewReportedPortUDP(NewPort);
	}
	
	UnregisterStation = function(_ConstantId){
		var Station = ds_map_find_value(self._StationMapData,_ConstantId);
		Station.Destroy();
		delete Station;
		ds_map_delete(self._StationMapData,_ConstantId);
	}
	
	UnregisterAll = function(){
		var _ArrayMap = ds_map_keys_to_array(self._StationMapData);
		for(var i = 0; i < array_length(_ArrayMap); i++){
			self.UnregisterStation(_ArrayMap[i]);
		}
	}
	
	GetStationInformation = function(_ConstantId){
		var myReturn = undefined;
		if(ds_exists(self._StationMapData,ds_type_map)) myReturn = ds_map_find_value(self._StationMapData,_ConstantId);
		return myReturn;
	}
}