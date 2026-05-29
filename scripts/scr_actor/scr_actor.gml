function fn_actor_evCreate()
{
	/* Presets */
	switch (object_index)
	{
		// Good/Peaceful entities
		// Evil/Hostile entities
		// Vehicles
		case obj_actor_kart:
			walk.active = false;
			slide.active = true;
			break;
	}
	
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
	}
}
function fn_actor_x(_object, _x, _facing_index, _distance)
{
	if (fn_obj_exists(_object) == true)
		return (_x + ((_distance * _object.facing[_facing_index].sign) * (_object.facing[_facing_index].axis == _object.FACING_AXIS_HORIZ)));
	else
		return 0;
}
function fn_actor_y(_object, _y, _facing_index, _distance)
{
	if (fn_obj_exists(_object) == true)
		return (_y + ((_distance * _object.facing[_facing_index].sign) * (_object.facing[_facing_index].axis == _object.FACING_AXIS_VERT)));
	else
		return 0;
}