function SubPageUDPNotAvaliable(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Not Avaliable";
	
	Draw = function(){
		draw_text(10,210,"No connection to TCP Server. Unable to start UDP.");
	}
}

function SubPageUDPNotStarted(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Not Started";
	
	Draw = function(){
		draw_text(10,210,"Press ENTER to create UDP local server!");
	}
	
	Step = function(){
		if(input_check_pressed("action")){
			self._MainPage.Notify(DebugUINotificationKey.UDPStart);
		}
	}
}

function SubPageUDPStarted(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Started OK";
	
	Draw = function(){	
		draw_text(10,210,$"Authentication Status: {(self._MainPage._UDPData._InternalAuthenticationStatus == UDPAuthenticationStatus.NotAuthenticated ? "N/A" : "OK")}");
		draw_text(10,230,"Press ENTER to destroy UDP local server!");
	}
	
	Step = function(){
		if(input_check_pressed("action")){
			self._MainPage.Notify(DebugUINotificationKey.UDPDestroy);
		}
	}
}