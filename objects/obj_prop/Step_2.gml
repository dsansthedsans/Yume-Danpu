/* CARYCARYCARYCARYCARYCARYCARYCARYCARYCARYCARYCARYCARYCARY */
for (var p = 0; (p < passengers_lengthMax && passengers[p].id != undefined); p++)
{
	var _passenger = passengers[p].id;
	_passenger.solid = false;
	_passenger.x = x;
	_passenger.y = y;
	_passenger.myself.x = myself.x;
	_passenger.myself.y = myself.y;
	_passenger.myself.alpha = 0;
	if (_passenger.type == _passenger.TYPE_ACTOR)
		_passenger.walk.active = false;
	//
	if (passengers[p].exit_active == true && fn_config_key_pressed(passengers[p].exit_key) == true)
	{
		
	}
}

event_user(2);