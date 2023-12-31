function Machine(PeerFrameworkDataSource) constructor{
	_PeerFrameworkData = PeerFrameworkDataSource;
	_CurrentStatus = -1;
	_DrawDebugInterface = true;
	
	ChangeStatus =  function(NewStatus){
		switch(NewStatus){
			case 0:
			break;
		}
	}
	
	Create = function(){
		self._CurrentStatus = new MachineStateConfiguration(self);
	}
	
	Step = function(){
		if(input_check_pressed("debug")) self._DrawDebugInterface = !self._DrawDebugInterface;
		self._CurrentStatus.Step();
	}
	
	Draw = function(){
		if(self._DrawDebugInterface){
			draw_text(10,10,"Peer Framework");
			draw_text(10,30,$"Current Page: {self._CurrentStatus._CurrentWindow}");
			draw_text(10,50,"<- A || D -> || Hide: F3");
			_CurrentStatus.Draw();
		}
	}
}