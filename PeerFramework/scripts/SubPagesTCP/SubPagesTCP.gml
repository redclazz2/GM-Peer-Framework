function SubPageTCPNotStarted(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Not Started";
	
	Draw = function(){
		draw_text(10,170,"Press ENTER to attempt connection!");
	}
	
	Step = function(){
		if(input_check_pressed("action")){
			self._MainPage.Notify(DebugUINotificationKey.TCPStart);
		}
	}
}

function SubPageTCPAttempt(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Attempting ...";
}

function SubPageTCPConnected(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Connected";
	
	Draw = function(){
		draw_text(10,170,$"TCP Application Status: {self._MainPage._TCPData._ApplicationAuthorizationStatus}");	
		draw_text(10,190,"-------------------------------------");
		draw_text(10,210,"Press ENTER to destroy TCP connection!");
	}
	
	Step = function(){
		if(input_check_pressed("action")){
			self._MainPage.Notify(DebugUINotificationKey.TCPDestroy);
		}
	}
}

function SubPageTCPFailed(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Failed";
	Draw = function(){
		draw_text(10,170,"Press ENTER to restart TCP communication Interface!");
	}
	
	Step = function(){
		if(input_check_pressed("action")){
			self._MainPage.Notify(DebugUINotificationKey.TCPDestroy);
		}
	}
}