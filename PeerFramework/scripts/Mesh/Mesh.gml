function Mesh(SessionKey,MaxStations,CurrentStations,MeshesConstantId,Manager) constructor{
	_SessionKey = SessionKey;
	_MaxStations = MaxStations;
	_CurrenStations = CurrentStations;
	_MeshesConstantId = MeshesConstantId;
	_StationMeshData = -1;
	_CommunicationProtocol = -1;
	_MeshManager = Manager;
	
	Create =  function(){
		self._StationMeshData = ds_map_create();
	}
	
	Destroy = function(){
		CleanDSMapContents(self._StationMeshData);
		ds_map_destroy(self._StationMeshData);
	}
}