function CommunicationInterface(Port,MyMediator) constructor{
	_SocketGMLNativePort = Port;
	_Socket = -1;
	_Mediator = MyMediator;
	_CurrentIncomeNetworkDataInterpreter = -1;
	
	Create = function(){};
	Destroy = function(){};
	InitializeCommunicationInterface = function(){}
	HandleIncomeNetworkData = function(){
	}	
}