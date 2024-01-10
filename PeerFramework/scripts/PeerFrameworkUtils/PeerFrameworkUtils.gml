function CleanDSMapContents(DsMap,HasDestructor = false){
		var ArrayMap = ds_map_keys_to_array(DsMap),
			ArrayLenght = array_length(ArrayMap),
			Data = -1;
		
		for(var i = 0; i < ArrayLenght; i ++){
			Data = ds_map_find_value(DsMap,ArrayMap[i]);
			if(HasDestructor) Data.Destroy();
			ds_map_replace(DsMap,ArrayMap[i],-1);
			delete Data;
		}
		
		Data = -1;
}