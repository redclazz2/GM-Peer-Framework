function SubPageUDPNotAvaliable(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Not Avaliable";
	
	Draw = function(){
		draw_text(10,210,"Connection hasn't started with main server. Unable to start UDP.");
	}
}

function SubPageUDPNotStarted(MyMainPage):SubPage(MyMainPage) constructor{
	_CurrentSubPageName = "Not Started";
	
	Draw = function(){
		draw_text(10,210,"Press ENTER to create UDP local server!");
	}
}