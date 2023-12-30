function Machine(PeerFrameworkDataSource) constructor{
	_PeerFrameworkData = PeerFrameworkDataSource;
	_CurrentStatus = -1;
	
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
	
	}
	
	Draw = function(){
		draw_text(10,10,"Peer Framework");
		draw_text(10,30,"<- A | D ->");
		draw_text(10,50,$"Current Page: {self._CurrentStatus._CurrentWindow}");
		_CurrentStatus.Draw();
	}
}