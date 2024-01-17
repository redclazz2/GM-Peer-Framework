function MachineStateMeshService(MyMachine):MachineDebugUIState(MyMachine) constructor{
	_CurrentWindow = "Mesh Service";
	_CurrentStatus = -1;
	
	Draw = function(){
		draw_text(10,90,"General Data:");
		draw_text(10,110,$"Current number of meshes: {0}");
		draw_text(10,130,$"Press ENTER to create a mesh!  (By default 4 slots)");
		draw_text(10,150,$"-----------------------------");
		draw_text(10,170,$"Press Z or C to browse the different meshes!");
	}
	
	Step = function(){
		if(input_check_pressed("action")){
			self._Machine.Notify(DebugUINotificationKey.MeshCreationRequest);
		}
		
		//Z or C logic
	}
}