function fn_actor_evCreate()
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
			talk.fucker.active = true;
			call.active = true;
			call.audio.asset = snd_user_func_kart_call_0;
			call.audio.loops = false;
			walk.active = false;
			slide.active = true;
			//carry.active = true;
			break;
	}
}
function fn_actor_evStep()
{
	switch (object_index)
	{
		// Vehicles
		case obj_actor_kart:
			if (call.audio.asset == snd_user_func_kart_call_0 && call.audio.id != undefined && audio_is_playing(call.audio.id) == false)
			{
				call.audio.id = undefined;
				call.audio.asset = snd_user_func_kart_call_1;
				call.audio.loops = true;
			}
			call.audio.pitch = (1 + (0.5 * (slide.speed / slide.speedMax)));
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