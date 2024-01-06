enum MediatorNotificationKey{
	DebugUI = 0,
	TCP = 1,
	IncomingNetworkData = 2,
	UDP = 3,
}

enum DebugUINotificationKey{
	TCPStart = 0,
	TCPDestroy = 1,
	UDPStart = 2,
	UDPDestroy = 3,
}

enum TCPNotificationKey{
	Attempt = 0,
	Connected = 1,
	Failed = 2,
	ApplicationAccepted = 3,
	ApplicationRejected = 4,
	DataPortUDPReport = 5
}

enum IncomingNetworkType{
	TCP = 0,
	UDP = 1,
}

enum UDPNotificationKey{
	SocketCreationOk = 0,
	SocketCreationFailed = 1
}