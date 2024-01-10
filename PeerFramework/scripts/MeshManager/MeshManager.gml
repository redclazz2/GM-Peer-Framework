function ServiceMesh(_Mediator) constructor{
	_CurrentMediator = _Mediator;
	_CurrentMeshes = -1;
	
	Create = function(){
		self._CurrentMeshes = ds_map_create();
	}
	
	Destroy =  function(){
	
	}
	
	RegisterMesh = function(){}
	
	DestroyMesh = function(){}
	
	GetMesh = function(_MeshId){
		
	}
	
	CreateMesh = function(){
		
	}
}