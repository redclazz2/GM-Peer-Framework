function Machine(PeerFrameworkDataSource) constructor{
	_PeerFrameworkData = PeerFrameworkDataSource;
	_CurrentStatus = -1;
	_CurrentPage = 0;
	_MaxPageIndex = 1;
	_DrawDebugInterface = true;
	
	ChangeStatus =  function(_MenuChange){
		//Change according to the direction & if out of index reset to 0
		self._CurrentPage += _MenuChange < 0 ? -1 : 1;
		if(self._CurrentPage < 0 || self._CurrentPage > self._MaxPageIndex) self._CurrentPage = 0;
		//Last state clean up
		delete self._CurrentStatus;
		//Change to new state
		switch(self._CurrentPage){
			case 0:
				self._CurrentStatus = new MachineStateConfiguration(self);
			break;
			
			case 1:
				self._CurrentStatus = new MachineStateTCPInterface(self);
			break;
		}
	}
	
	Create = function(){
		self._CurrentStatus = new MachineStateConfiguration(self);
	}
	
	Step = function(){
		//Hides or shows the debug UI interface
		if(input_check_pressed("debug")) self._DrawDebugInterface = !self._DrawDebugInterface;
		//If there's an input the menu on display has to change.
		var _MenuChange = input_check_pressed("left") - input_check_pressed("right");
		if(_MenuChange != 0) ChangeStatus(_MenuChange);
		
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