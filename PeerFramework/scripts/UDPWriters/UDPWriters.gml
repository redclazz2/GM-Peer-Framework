function UDPWriterSendAuthenticationRequest(CommunicationUDP):NetworkDataWriter(CommunicationUDP) constructor{
	Write = function(_data){
		var buffer = self._CommunicationInterface._InterfaceUDPBuffer;
		show_debug_message(buffer)
		if(buffer_exists(buffer)){
			buffer_seek(buffer,buffer_seek_start,1);
			buffer_write(buffer,buffer_u16,UDPAuthenticationStatus.NotAuthenticated);
			
			var Socket = self._CommunicationInterface._Socket,
				Url = self._CommunicationInterface._Mediator._CommunicationTCP._SocketGMLNativeRemoteIp,
				Port = self._CommunicationInterface._Mediator._CommunicationTCP._SocketGMLNativePort;
			
			network_send_udp(Socket,Url,Port,buffer,buffer_tell(buffer));
			
			logger(LOGLEVEL.INFO,"Send Auth Request to main server UDP.","PeerFrameworkUDPCommunicationInterface");
		}
	}
}