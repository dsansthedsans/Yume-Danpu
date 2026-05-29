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
				var _x = fn_actor_x(id, x, facing_curr, walk.distance);
				var _y = fn_actor_y(id, y, facing_curr, walk.distance);
				var _prop = instance_place(_x, _y, obj_prop);
				if (_prop == noone) || (_prop != noone && _prop.solid == false)
				{
					if (walk.chain.active == false) || (walk.chain.active == true && abs(xstart - _x) < walk.chain.distance && abs(ystart - _y) < walk.chain.distance)
					{
						walk.stage = 0;
						walk.time = walk.timeMax;
						walk.startX = x;
						walk.startY = y;
						x = _x;
						y = _y;
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
		fn_obj_depth(, -myself.y);
	}
}
if (slide.active == true)
{
	var _facing_new = undefined;
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
	if (_facing_new != undefined) || (_facing_new == undefined && slide.speed > 0)
	{
		if (_facing_new != undefined && _facing_new != facing_curr)
		{
			if (slide.shake.active == true)
			{
				myself.shake.time = ((slide.speed < (slide.speedMax / 2)) ? slide.shake.timeMin : slide.shake.timeMax);
				myself.shake.distance = ((slide.speed < (slide.speedMax / 2)) ? slide.shake.distanceMin : slide.shake.distanceMax);
			}
			slide.speed = 0;
		}
		facing_curr = ((_facing_new != undefined) ? _facing_new : facing_curr);
		var _x = fn_actor_x(id, x, facing_curr, slide.speed);
		var _y = fn_actor_y(id, y, facing_curr, slide.speed);
		var _prop = instance_place(_x, _y, obj_prop);
		if (_prop != noone && _prop.solid == true && distance_to_object(_prop) > 0)
		{
			_x = fn_actor_x(id, x, facing_curr, distance_to_object(_prop));
			_y = fn_actor_y(id, y, facing_curr, distance_to_object(_prop));
			_prop = instance_place(_x, _y, obj_prop);
		}
		if (_prop == noone) || (_prop != noone && _prop.solid == false)
		{
			x = _x;
			y = _y;
			myself.x = _x;
			myself.y = _y;
			slide.speed = clamp((slide.speed + ((_facing_new != undefined) ? slide.acceleration : -slide.deceleration)), 0, slide.speedMax);
			fn_obj_depth(, -myself.y);
		}
		else
		{
			if (slide.shake.active == true)
			{
				myself.shake.time = slide.shake.timeMin;
				myself.shake.distance = slide.shake.distanceMin;
			}
			slide.speed = 0;
		}
	}
}
