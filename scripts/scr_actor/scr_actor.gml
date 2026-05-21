function fn_actor_evCreate()
{
	/* Presets */
	//switch (object_index)
	//{
		
	//}
	
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
	}
}
function fn_actor_walk_endX_get(_object, _x, _facing_index, _walk_distance)
{
	if (fn_obj_exists(_object) == true)
		return (_x + ((_walk_distance * _object.facing[_facing_index].sign) * (_object.facing[_facing_index].axis == _object.FACING_AXIS_HORIZ)));
	else
		return 0;
}
function fn_actor_walk_endY_get(_object, _y, _facing_index, _walk_distance)
{
	if (fn_obj_exists(_object) == true)
		return (_y + ((_walk_distance * _object.facing[_facing_index].sign) * (_object.facing[_facing_index].axis == _object.FACING_AXIS_VERT)));
	else
		return 0;
}