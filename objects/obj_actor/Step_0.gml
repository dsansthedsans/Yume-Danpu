event_inherited();

/* Movement sequences */
// Walking movement sequence
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
				for (var f = 0; f < array_length(facing); f++)
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
				var _x = fn_actor_facing_x(id, x, facing_curr, walk.distance);
				var _y = fn_actor_facing_y(id, y, facing_curr, walk.distance);
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
		fn_actor_stage_loop();
		fn_obj_depth(, -myself.y);
	}
}
// Sliding movement sequence
if (slide.active == true)
{
	var _facing_new = undefined;
	if (slide.mode == SLIDE_MODE_MANUAL)
	{
		for (var f = 0; f < array_length(facing); f++)
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
	if (_facing_new != undefined) || (_facing_new == undefined && slide.speed > 0)
	{
		if (_facing_new != undefined && _facing_new != facing_curr)
		{
			facing_curr = _facing_new;
			if (slide.steer.audio.asset != undefined && slide.steer.audio.emitter != undefined)
			{
				var _audio_volume = (slide.steer.audio.volumeMin + ((slide.steer.audio.volumeMax - slide.steer.audio.volumeMin) * (slide.speed / slide.speedLimit)));
				var _audio_pitch = (slide.steer.audio.pitchMin + ((slide.steer.audio.pitchMax - slide.steer.audio.pitchMin) * (slide.speed / slide.speedLimit)));
				fn_audio_play(slide.steer.audio.asset, slide.steer.audio.emitter, _audio_volume, _audio_pitch);
			}
			myself.shake.time = (slide.steer.shake.timeMin + ((slide.steer.shake.timeMax - slide.steer.shake.timeMin) * (slide.speed / slide.speedLimit)));
			myself.shake.distance = (slide.steer.shake.distanceMin + ((slide.steer.shake.distanceMax - slide.steer.shake.distanceMin) * (slide.speed / slide.speedLimit)));
			slide.speed = 0;
		}
		var _speed = clamp((slide.speed + ((_facing_new != undefined) ? slide.speedIncrease : -slide.speedDecrease)), 0, slide.speedLimit);
		var _propList = ds_list_create();
		var _propLength = instance_place_list(fn_actor_facing_x(id, x, facing_curr, max(_speed, 1)), fn_actor_facing_y(id, y, facing_curr, max(_speed, 1)), obj_prop, _propList, true);
		for (var p = 0; p < _propLength; p++)
		{
			var _prop = _propList[| p];
			if (_prop == noone) || (_prop != noone && _prop.solid == false && p >= (_propLength - 1))
			{
				x = fn_actor_facing_x(id, x, facing_curr, _speed);
				y = fn_actor_facing_y(id, y, facing_curr, _speed);
				slide.speed = _speed;
				continue;
			}
			else if (_prop != noone && _prop.solid == true)
			{
				x = round(fn_actor_facing_x(id, x, facing_curr, ((facing_curr == FACING_WEST) ? (bbox_left - _prop.bbox_right) : (_prop.bbox_left - bbox_right)) ));
				y = round(fn_actor_facing_y(id, y, facing_curr, ((facing_curr == FACING_NORTH) ? (bbox_top - _prop.bbox_bottom) : (_prop.bbox_top - bbox_bottom)) ));
				if (slide.speed > 0)
				{
					if (slide.crash.audio.asset != undefined && slide.crash.audio.emitter != undefined)
					{
						var _audio_volume = (slide.crash.audio.volumeMin + ((slide.crash.audio.volumeMax - slide.crash.audio.volumeMin) * (slide.speed / slide.speedLimit)));
						var _audio_pitch = (slide.crash.audio.pitchMin + ((slide.crash.audio.pitchMax - slide.crash.audio.pitchMin) * (slide.speed / slide.speedLimit)));
						fn_audio_play(slide.crash.audio.asset, slide.crash.audio.emitter, _audio_volume, _audio_pitch);
					}
					myself.shake.time = (slide.crash.shake.timeMin + ((slide.crash.shake.timeMax - slide.crash.shake.timeMin) * (slide.speed / slide.speedLimit)));
					myself.shake.distance = (slide.crash.shake.distanceMin + ((slide.crash.shake.distanceMax - slide.crash.shake.distanceMin) * (slide.speed / slide.speedLimit)));
					slide.speed = 0;
				}
				break;
			}
		}
		myself.x = x;
		myself.y = y;
		fn_actor_stage_loop();
		depth = -myself.y;
		if (global.config_dbg.active == true && global.config_dbg.logOverdose == true)
			fn_log($"x = {x} | y = {y} | myself.x = {myself.x} | myself.y = {myself.y} | slide.speed = {slide.speed}");
	}
}
