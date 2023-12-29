/*これは、単純なパケットの作成を適切に記録するように書き換えることができる。しかし、当面は通常の関数で十分である*/
function PacketSimple(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType = buffer_grow, EncriptionEnabled = true)
	:Packet(PacketId, NumberOfDestinations, DestinationStations = [], ProtocolType, ServiceType, DataBufferType, EncriptionEnabled) constructor{}