///Incoming Packets
var net_event_type = ds_map_find_value(async_load,"type");
//show_debug_message("Event type: " + string(net_event_type))

try{
	switch(net_event_type){
		case network_type_data:
			var buffer = ds_map_find_value(async_load,"buffer");
			buffer_seek(buffer,buffer_seek_start,0);
			//handlepacketclient(buffer,buffer_read(buffer, buffer_s16),socket,ds_map_find_value(async_load,"ip"),ds_map_find_value(async_load,"port"));
		break;
	
		case network_type_non_blocking_connect:
			var succeeded = ds_map_find_value(async_load, "succeeded");
			if (succeeded == 0) PeerFramework.Notify(MediatorNotificationKey.TCP,new NotificationData(TCPNotificationKey.Failed));
			else if (succeeded == 1) PeerFramework.Notify(MediatorNotificationKey.TCP,new NotificationData(TCPNotificationKey.Connected));	
		break;
	}
}catch(e){
	logger(LOGLEVEL.ERROR,$"Fatal error when reading incoming network event: {e.message}","Async Networking: GML Event");
}