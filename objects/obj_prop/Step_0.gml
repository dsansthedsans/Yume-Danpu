/* Interaction sequence */
if (talk.active == true)
{
	// Interaction sequence is inactive
	if (talk.stage == -1)
	{
		/* Types */
		// Starts another object's interaction sequence
		if (talk.trigger.active == true && fn_config_key_pressed(talk.trigger.key) == true && type == TYPE_ACTOR && walk.stage == -1)
		{
			var _target = instance_place(fn_actor_facing_x(id, x, facing_curr, talk.trigger.distance), fn_actor_facing_y(id, y, facing_curr, talk.trigger.distance), obj_prop);
			if (_target != noone && _target.talk.active == true && _target.talk.stage == -1 && ((_target.type == TYPE_PROP) || (_target.type == TYPE_ACTOR && _target.walk.stage == -1)))
			{
				talk.stage = -2;
				if (walk.active == true)
					walk.stage = -2;
				talk.trigger.target = _target;
				_target.talk.stage = 0;
				_target.talk.trigger_id = id;
				if (_target.type == _target.TYPE_ACTOR && _target.walk.active == true)
					_target.walk.stage = -2;
			}
		}
	}
	// Interaction sequence is active
	else if (talk.stage >= 0)
	{
		var _trigger = talk.trigger_id;
		
		/* Types */
		// Plays an audio
		if (talk.bell.active == true)
		{
			if (talk.stage == 0)
			{
				var _roulette = array_create(0);
				for (var a = 0; a < array_length(talk.bell.audio_assetsRarity); a++)
				{
					for (var r = 0; r < talk.bell.audio_assetsRarity[a]; r++)
						array_push(_roulette, a);
				}
				fn_audio_play(talk.bell.audio_assets[_roulette[irandom_range(0, (array_length(_roulette) - 1))]], talk.bell.audio_emitter);
				talk.stage = 1;
				talk.bell.time = 0;
			}
			else if (talk.stage == 1)
			{
				talk.bell.time += 1;
				if (talk.bell.time >= talk.bell.timeLimit)
				{
					talk.stage = -1;
					if (type == TYPE_ACTOR && walk.active == true)
						walk.stage = -1;
					talk.trigger_id = undefined;
					_trigger.talk.stage = -1;
					if (_trigger.type == _trigger.TYPE_ACTOR && _trigger.walk.active == true)
						_trigger.walk.stage = -1;
					_trigger.talk.trigger.target = undefined;
				}
			}
		}
		// Starts a room transition
		else if (talk.door.active == true)
		{
			var d = talk.door;
			if (talk.stage == 0)
			{
				fn_fader_obj_create();
				talk.stage = 1;
				if (d.open.audio_asset != -1 && d.open.audio_emitter != -1)
					fn_audio_play(d.open.audio_asset, d.open.audio_emitter);
			}
			else if (talk.stage == 1)
			{
				if (d.open.imageSpeed > 0 && (myself.image + d.open.imageSpeed) < sprite_get_number(myself.sprite))
					myself.image += d.open.imageSpeed;
			}
		}
		// Unlocks an Effect, a Function or a Theme
		else if (talk.gift.active == true)
		{
			var g = talk.gift;
			if (g.contents != undefined && g.contents[g.contents_index].unlocked == false)
			{
				g.contents[g.contents_index].unlocked = true;
				fn_user_file_save();
			}
			talk.stage = -1;
			if (type == TYPE_ACTOR)
				walk.stage = -1;
		}
		// CARRYCARRYCARRYCARRYCARRYCARRYCARRYCARRYCARRY
		else if (talk.ride.active == true)
		{
			if (talk.ride.mode == TALK_RIDE_MODE_PASSENGER)
			{
				
			}
			else if (talk.ride.mode == TALK_RIDE_MODE_DRIVER)
			{
				for (var p = 0; p < passengers_lengthMax; p++)
				{
					if (passengers[p].id == undefined)
					{
						passengers[p].id = talk.trigger_id;
						break;
					}
				}
			}
			talk.stage = -1;
			if (type == TYPE_ACTOR && walk.active == true)
				walk.stage = -1;
		}
	}
}

/* Plays an audio the player can only hear if they're close */
if (call.active == true && call.audio != undefined)
{
	var _curr = call.audio_curr;
	if (is_real(_curr) >= 0 && call.audio[_curr].asset != undefined && call.audio[_curr].emitter != undefined)
	{
		// Starts playing audio
		if (call.audio[_curr].id == undefined)
		{
			if (call.audio[_curr].delay_active == false) || (call.audio[_curr].delay_time <= 0)
			{
				if (call.audio_currOld != undefined)
					call.audio[_curr].id = undefined;
				call.audio_currOld = call.audio_curr;
				call.audio[_curr].id = fn_audio_play(call.audio[_curr].asset, call.audio[_curr].emitter, 0, call.audio[_curr].pitch, , call.audio[_curr].loops);
			}
			else
				call.audio[_curr].delay_time += 1;
		}
		// Updates playing audio's volume and pitch
		if (call.audio[_curr].id != undefined && audio_is_playing(call.audio[_curr].id) == true)
		{
			call.audio[_curr].volume = (1 - (clamp(distance_to_object(obj_actor_user), 0, call.distance) / call.distance));
			fn_audio_volume(call.audio[_curr].asset, call.audio[_curr].id, call.audio[_curr].emitter, call.audio[_curr].volume);
			fn_audio_pitch(call.audio[_curr].asset, call.audio[_curr].id, call.audio[_curr].pitch);
		}
		// 
		else if (call.audio[_curr].id != undefined && audio_is_playing(call.audio[_curr].id) == false)
		{
			if (call.audio_autoplay == true)
			{
				call.audio_curr += 1;
				if (call.audio_curr >= array_length(call.audio))
					call.audio_curr = 0;
			}
		}
	}
}