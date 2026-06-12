function fn_actor_event_create()
{
	/* Presets */
	/*switch (object_index)
	{
		// Good/Peaceful entities
		// Evil/Hostile entities
		// Vehicles
	}*/
	
	/* Custom */
	switch (object_index)
	{
		// User
		case obj_actor_user:
			talk.active = true;
			talk.trigger.active = true;
			facing[FACING_WEST].sprite = spr_user_facing_west;
			facing[FACING_EAST].sprite = spr_user_facing_east;
			facing[FACING_NORTH].sprite = spr_user_facing_north;
			facing[FACING_SOUTH].sprite = spr_user_facing_south;
			walk.mode = WALK_MODE_MANUAL;
			walk.timeMax = 16;
			walk.delay.active = false;
			walk.chain.active = false;
			walk.step.active = true;
			walk.step.audio_asset = snd_user_step;
			walk.step.audio_emitter = CONFIG_AUDIO_EMITTER.USER;
			break;
		// Good/Peaceful entities
		case obj_actor_macaco_monkey:
			myself.imageSpeed = (random_range(0.5, 1.5) / 30);
			talk.active = true;
			talk.bell.active = true;
			talk.bell.audio_assets = [snd_actor_macaco_monkey_0, snd_actor_macaco_monkey_1, snd_actor_macaco_monkey_2, snd_actor_macaco_monkey_3, snd_actor_macaco_monkey_4, snd_actor_macaco_monkey_5, snd_actor_macaco_monkey_6];
			talk.bell.audio_assetsRarity = [10, 10, 10, 10, 10, 1, 1]
			break;
		// Evil/Hostile entities
		// Vehicles
		case obj_actor_kart:
			talk.active = true;
			talk.ride.active = true;
			talk.ride.mode = TALK_RIDE_MODE_DRIVER;
			call.audio[0].asset = snd_user_func_kart_call_0;
			call.audio[0].loops = false;
			call.audio[1].asset = snd_user_func_kart_call_1;
			for (var a = 0; a < call.audio_lengthMax; a++)
				call.audio[a].emitter = CONFIG_AUDIO_EMITTER.USER;	
			walk.active = false;
			slide.steer.audio.asset = snd_user_func_kart_steer;
			slide.steer.audio.emitter = CONFIG_AUDIO_EMITTER.USER;
			slide.crash.audio.asset = snd_user_func_kart_crash;
			slide.crash.audio.emitter = CONFIG_AUDIO_EMITTER.USER;
			break;
	}
}
function fn_actor_event_stepBegin()
{
	/* Custom */
	/*switch (object_index)
	{
		// Good/Peaceful entities
		// Evil/Hostile entities
		// Vehicles
	}*/
}
function fn_actor_event_stepEnd()
{
	/* Custom */
	switch (object_index)
	{
		// Good/Peaceful entities
		// Evil/Hostile entities
		// Vehicles
		case obj_actor_kart:
			if (passengers[0].id == undefined)
			{
				call.active = false;
				slide.active = false;
			}
			else
			{
				call.active = true;
				call.audio[call.audio_curr].pitch = (1 + (1.75 * (slide.speed / slide.speedLimit)));
				slide.active = true;
			}
			break;
	}
}
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