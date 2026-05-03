event_inherited();

/* Movement sequence */
if (walk.active == true)
{
	// Movement sequence is inactive, waiting/preparing to activate
	if (walk.stage == -1)
	{
		if (walk.delay.active == false) || (walk.delay.active == true && walk.delay.time <= 0)
		{
			walk.delay.time = irandom_range(walk.delay.timeMin, walk.delay.timeMax);
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
				var _distance = walk.distance;
				while (_distance > 0)
				{
					var _endX = fn_actor_walk_endX_get(id, x, facing_curr, _distance);
					var _endY = fn_actor_walk_endY_get(id, y, facing_curr, _distance);
					var _endBarrier = instance_place(_endX, _endY, obj_prop);
					if (_endBarrier == noone) || (_endBarrier != noone && _endBarrier.solid == false)
					{
						if (walk.chain.active == false) || (walk.chain.active == true && abs(xstart - _endX) < walk.chain.distance && abs(ystart - _endY) < walk.chain.distance)
						{
							move.stage = 0;
							move.startX = x;
							move.startY = y;
							move.endX = _endX;
							move.endY = _endY;
							x = move.endX;
							y = move.endY;
							if (global.config_dbg.active == true && global.config_dbg.logOverdose == true)
								fn_log($"x = {x} | y = {y} | myself.x = {myself.x} | myself.y = {myself.y}");
						}
					}
				}
			}
		}
		else if (walk.delay.active == true && walk.delay.time > 0)
			walk.delay.time -= 1;
	}
	// Movement sequence is active
	else if (walk.stage == 0)
	{
		
	}
}