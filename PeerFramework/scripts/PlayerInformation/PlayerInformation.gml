function PlayerInformation(Username) constructor{
	_Username = Username;
	
	SetUsername = function(NewUsername){
		self._Username = NewUsername;
	}
}