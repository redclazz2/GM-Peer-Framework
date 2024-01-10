function TCPWriterSendMeshCreationRequest(CommunicationTCP):NetworkDataWriter(CommunicationTCP) constructor{
	Write = function(_data){
		var buffer = self._CommunicationInterface._InterfaceTCPBuffer,
			socket = self._CommunicationInterface._Socket;
		
		if(buffer_exists(buffer)){
			buffer_seek(buffer,buffer_seek_start,0);
			buffer_write(buffer,buffer_u16,TCPMessageTypes.StationMeshCreationRequest);	
			network_send_raw(socket,buffer,buffer_tell(buffer));

			logger(LOGLEVEL.INFO,"Sent Mesh Creation Request","PeerFrameworkTCPCommunicationInterface");
		}
	}
}

