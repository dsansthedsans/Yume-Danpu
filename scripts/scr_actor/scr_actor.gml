/* Actors */
function fn_actor_facing_x(_object, _x, _facing, _distance)
{
	return (_x + ((_distance * _object.facing[_facing].sign) * (_object.facing[_facing].axis == _object.FACING_AXIS_HORIZ)));
}
function fn_actor_facing_y(_object, _y, _facing, _distance)
{
	return (_y + ((_distance * _object.facing[_facing].sign) * (_object.facing[_facing].axis == _object.FACING_AXIS_VERT)));
}
function fn_actor_stage_loop()
{
	var _xDist = 0;
	var _yDist = 0;
	var _stg = obj_stage;
	if (fn_obj_exists(_stg) == true)
	{
		if (_stg.loop.xAct == true)
		{
			if (_stg.cam.lock.x == undefined)
			{
				if (x < 0)
					_xDist = room_width;
				if (x >= room_width)
					_xDist = -room_width;
			}
			else
			{
				if (x < -sprite_width)
					_xDist = (room_width + sprite_width);
				if (x > room_width)
					_xDist = -(room_width + sprite_width);
			}
		}
		if (_stg.loop.yAct == true)
		{
			if (_stg.cam.lock.y == undefined)
			{
				if (y <= 0)
					_yDist = room_height;
				if (y > room_height)
					_yDist = -room_height;
			}
			else
			{
				if (y < 0)
					_yDist = (room_height + sprite_height);
				if (y > (room_height + sprite_height))
					_yDist = -(room_height + sprite_height);
			}
		}
	}
	x += _xDist;
	y += _yDist;
	myself.x += _xDist;
	myself.y += _yDist;
}


// I am not insane. I am not in pain. I am not Shane.
// Have you seen the walls? Have you seen the balls? Have you seen the dolls?
// The dog is barking for food. The dog is barking for good. The dog is barking for wood.
// There is no one here. There is no one near. There is no fun fear.