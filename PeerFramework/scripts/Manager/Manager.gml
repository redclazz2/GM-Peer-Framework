function DebugUIMachine(PeerFrameworkDataSource) constructor{
	_PeerFrameworkData = PeerFrameworkDataSource;
	_CurrentStatus = -1;
	_CurrentPage = 0;
	_MaxPageIndex = 3;
	_DrawDebugInterface = true;
	
	ChangeStatus =  function(_MenuChange){
		//Change according to the direction & if out of index reset to 0
		self._CurrentPage += _MenuChange > 0 ? -1 : 1;
		if(self._CurrentPage < 0) self._CurrentPage	= self._MaxPageIndex; 
		if(self._CurrentPage > self._MaxPageIndex) self._CurrentPage = 0;

		//Last state clean up
		delete self._CurrentStatus;
		//Change to new state
		switch(self._CurrentPage){
			case 0:
				self._CurrentStatus = new MachineStateConfiguration(self);
			break;
			
			case 1:
				self._CurrentStatus = new MachineStateTCPInterface(self);
				self._CurrentStatus.ChangeStatus();
			break;
			
			case 2:
				self._CurrentStatus = new MachineStateStationService(self);
				self._CurrentStatus.ChangeStatus();
			break;
			
			case 3:
				self._CurrentStatus = new MachineStateUDPInterface(self);
				self._CurrentStatus.ChangeStatus();
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
		if(self._DrawDebugInterface) self._CurrentStatus.Step();
	}
	
	Draw = function(){
		if(self._DrawDebugInterface){
			draw_text(10,10,"Peer Framework - Debug UI");
			draw_set_color(c_lime);
			draw_text(10,30,$"Current Page: {self._CurrentStatus._CurrentWindow}");
			draw_set_color(c_white);
			draw_text(10,50,"<- A || D -> || Hide: F3");
			_CurrentStatus.Draw();
		}
	}
	
	Notify = function(Identification,Data = noone){
		self._PeerFrameworkData.Notify(MediatorNotificationKey.DebugUI,new NotificationData(Identification,Data));
	}
}