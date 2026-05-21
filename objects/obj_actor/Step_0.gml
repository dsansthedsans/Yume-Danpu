event_inherited();

/* Movement sequence */
if (walk.active == true)
{
	// Movement sequence is inactive, waiting/preparing to activate
	if (walk.stage == -1)
	{
		walk.delay.time -= 1;
		if (walk.delay.active == false) || (walk.delay.active == true && walk.delay.time <= 0)
		{
			var _facing_new = undefined;
			if (walk.mode == WALK_MODE_AUTO)
			{
				_facing_new = choose(FACING_WEST, FACING_EAST, FACING_NORTH, FACING_SOUTH);
			}
			else if (walk.mode == WALK_MODE_MANUAL)
			{
				for (var f = 0; f < 4; f++)
				{
					if (fn_config_key_held(facing[f].key) == true)
					{
						_facing_new = f;
						break;
					}
					else
						continue;
				}
			}
			if (_facing_new != undefined)
			{
				facing_curr = _facing_new;
				var _endX = fn_actor_walk_endX_get(id, x, facing_curr, walk.distance);
				var _endY = fn_actor_walk_endY_get(id, y, facing_curr, walk.distance);
				var _endProp = instance_place(_endX, _endY, obj_prop);
				if (_endProp == noone) || (_endProp != noone && _endProp.solid == false)
				{
					if (walk.chain.active == false) || (walk.chain.active == true && abs(xstart - _endX) < walk.chain.distance && abs(ystart - _endY) < walk.chain.distance)
					{
						walk.stage = 0;
						walk.time = walk.timeMax;
						walk.startX = x;
						walk.startY = y;
						x = _endX;
						y = _endY;
						if (global.config_dbg.active == true && global.config_dbg.logOverdose == true && object_index == obj_actor_user)
							fn_log($"x = {x} | y = {y} | myself.x = {myself.x} | myself.y = {myself.y}");
					}
				}
			}
			
			if (walk.delay.active == true)
				walk.delay.time = irandom_range(walk.delay.timeMin, walk.delay.timeMax);
		}
	}
	// Movement sequence is active
	if (walk.stage == 0)
	{
		myself.x += ((x - walk.startX) / walk.timeMax);
		myself.y += ((y - walk.startY) / walk.timeMax);
		if (walk.step.active == true)
		{
			walk.step.time -= 1;
			if (walk.step.time <= 0)
			{
				myself.image += 1;
				walk.step.time = floor(walk.timeMax / clamp((round(16 / walk.timeMax) + 1), 2, infinity)); // the clamp() is the amount of images will be added during the movement sequence
				if (myself.image % 2 == 1 && walk.step.audio_asset != undefined)
					fn_audio_play(walk.step.audio_asset, walk.step.audio_emitter);
			}
		}
		walk.time -= 1;
		if (walk.time <= 0)
		{
			if (global.config_dbg.active == true && global.config_dbg.logOverdose == true && object_index == obj_actor_user)
				fn_log($"x = {x} | y = {y} | myself.x = {myself.x} | myself.y = {myself.y}");
			myself.x = x;
			myself.y = y;
			walk.stage = -1;
			if (walk.step.active == true)
			{
				if (myself.image % 2 == 1)
					myself.image += 1;
				walk.step.time = 0;
			}
		}
		depth = -myself.y;
	}
}



/*
if (walk.step.active == true)
{
	if (walk.step.time <= 0)
	{
		image_index += 1;
		if (image_index % 2 == 1 && walk.step.audio_asset != undefined && walk.step.audio_emitter != undefined)
			fn_audio_play(walk.step.audio_asset, walk.step.audio_emitter);
		walk.step.time = floor(walk.time / min(2, (round(16 / walk.time) + 1)));
	}
	else
		walk.step.time -= 1;
}
*/