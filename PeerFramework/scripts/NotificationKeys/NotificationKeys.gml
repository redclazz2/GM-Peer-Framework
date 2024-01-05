enum MediatorNotificationKey{
	DebugUI = 0,
	TCP = 1,
	IncomingNetworkData = 2,
}

enum DebugUINotificationKey{
	TCPStart = 0,
	TCPDestroy = 1,
}

enum TCPNotificationKey{
	Attempt = 0,
	Connected = 1,
	Failed = 2,
	ApplicationAccepted = 3,
	ApplicationRejected = 4,
}

enum IncomingNetworkType{
	TCP = 0,
	UDP = 1,
}