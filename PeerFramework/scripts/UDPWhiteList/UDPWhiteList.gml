function WhiteList() constructor{
	_StationWhiteList = -1;
	_WhiteListLeaseTimer = -1;
	
	Create = function(){
		self._StationWhiteList = ds_map_create();
		self._WhiteListLeaseTimer = time_source_create(time_source_global,1,time_source_units_seconds,self.StationLeaseCountdown,[],-1);
	}
	
	Destroy = function(){
		ds_map_destroy(self._StationWhiteList);
		self._StationWhiteList = -1;
		if(time_source_exists(self._WhiteListLeaseTimer)){
			time_source_stop(self._WhiteListLeaseTimer);
			time_source_destroy(self._WhiteListLeaseTimer);	
		}
		self._WhiteListLeaseTimer = -1;
	}
	
	SetStationWhiteListing = function(_StationConstantId,_StationAddress,_StationPort,_LeaseTime){
		var StationData = new WhiteListedStation(_StationConstantId,_StationAddress,_StationPort);
		if(ds_map_exists(self._StationWhiteList,_StationConstantId)){
			ds_map_replace(self._StationWhiteList,StationData,_LeaseTime);
		}else{
			ds_map_add(self._StationWhiteList,StationData,_LeaseTime);
		}
	}
	
	GetStationWhiteListing = function(_StationConstantId,_StationIp,_StationPort){
		var _Found = ds_map_find_value(self._StationWhiteList,_StationConstantId),
			_Return = false;
			
		if(!is_undefined(_Found)){
			if(_Found._Ip == _StationIp && _Found._Port == _StationPort){
				_Return = true;
			}
		}
		
		return _Return;
	}
	
	DeleteStationWhiteListing = function(_StationConstantId){
		if(ds_map_exists(self._StationWhiteList,_StationConstantId)){
			ds_map_delete(self._StationWhiteList,_StationConstantId);
		}
	}
		
	StationLeaseCountdown = function(){
		var ArrayMap = ds_map_keys_to_array(self._StationWhiteList),
			ArrayLenght = array_length(ArrayMap),
			CurrentValue = -2;
			
		for(var i = ArrayLenght; i < ArrayLenght; i++){
			CurrentValue = ds_map_find_value(self._StationWhiteList,ArrayMap[i]);
			if(CurrentValue != -1 && CurrentValue > 0){
				ds_map_replace(self._StationWhiteList,ArrayMap[i],CurrentValue - 1);
			}else if(CurrentValue == 0) self.DeleteStationWhiteListing(ArrayMap[i]);
		}
	}
}