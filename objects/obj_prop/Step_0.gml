fn_prop_evStep();

/* Interaction sequence */
if (talk.active == true)
{
	if (talk.stage >= 0)
	{
		/* Types */
		// Plays an audio
		if (talk.bell.active == true)
		{
			var b = talk.bell;
			if (talk.stage == 0)
			{
				var _roulette = array_create(0);
				for (var a = 0; a < array_length(b.audio_assetsRarity); a++)
				{
					for (var r = 0; r < b.audio_assetsRarity[a]; r++)
						array_push(_roulette, a);
				}
				fn_audio_play(b.audio_assets[_roulette[irandom_range(0, (array_length(_roulette) - 1))]], b.audio_emitter);
				talk.stage = 1;
				b.time = 0;
			}
			else if (talk.stage == 1)
			{
				b.time += 1;
				if (b.time >= b.timeTarget)
				{
					talk.stage = -1;
					if (myself.type == MYSELF_TYPE_ACTOR)
						walk.stage = -1;
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
				if (d.open.imageSpeed > 0 && (image_index + d.open.imageSpeed) < image_number)
					image_index += d.open.imageSpeed;
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
			if (myself.type == MYSELF_TYPE_ACTOR)
				walk.stage = -1;
		}
	}
	else if (talk.stage == -1)
	{
		/* Types */
		// Starts another object's interaction sequence
		if (talk.trigger.active == true && fn_config_key_pressed(talk.trigger.key) == true && myself.type == MYSELF_TYPE_ACTOR && walk.stage == -1)
		{
			var _target = instance_place(fn_actor_x(id, x, facing_curr, talk.trigger.distance), fn_actor_y(id, y, facing_curr, talk.trigger.distance), obj_prop);
			if (_target != noone && _target.talk.active == true && _target.talk.stage == -1 && ((_target.myself.type == MYSELF_TYPE_PROP) || (_target.myself.type == MYSELF_TYPE_ACTOR && _target.walk.stage == -1)))
			{
				talk.stage = -2;
				walk.stage = -2;
				talk.trigger.target = _target;
				_target.talk.stage = 0;
				if (_target.myself.type == MYSELF_TYPE_ACTOR)
					_target.walk.stage = -2;
				
				fn_log("!!!!!!!!!!!!!!!!!!");
			}
		}
	}
	else if (talk.stage == -2)
	{
		/* Types */
		// Another object's interaction sequence has ended
		if (talk.trigger.active == true && talk.trigger.target != undefined && talk.trigger.target.talk.stage == -1)
		{
			talk.stage = -1;
			if (myself.type == MYSELF_TYPE_ACTOR)
				walk.stage = -1;
			talk.trigger.target = undefined;
		}
	}
}

/* Plays an audio the player can only hear if they're close */
if (call.active == true && call.audio.asset != undefined && call.audio.emitter != undefined)
{
	// Delay
	if (call.delay.active == true)
	{
		call.delay.time -= 1;
		if (call.delay.time <= 0)
		{
			if (call.audio.id != undefined)
			{
				if (audio_is_playing(call.audio.id) == true)
					fn_audio_stop(call.audio.id);
				call.audio.id = undefined;
			}
			call.delay.time = irandom_range(call.delay.timeMin, call.delay.timeMax);
		}
	}
	// Audio
	if (call.audio.id == undefined)
		call.audio.id =  fn_audio_play(call.audio.asset, call.audio.emitter, 0, , , call.audio.loops);	
	else if (audio_is_playing(call.audio.id) == true)
	{
		var _clamp = (clamp(distance_to_object(obj_actor_user), 0, call.audio.distance) / call.audio.distance);
		call.audio.volume = lerp(call.audio.volume, (1 - _clamp), call.audio.volumeSpeed);
		call.audio.pitchOffset = lerp(call.audio.pitchOffset, (call.audio.pitchOffsetMax * _clamp), call.audio.pitchSpeed);
		fn_audio_volume(call.audio.asset, call.audio.id, call.audio.emitter, call.audio.volume);
		fn_audio_pitch(call.audio.asset, call.audio.id, (call.audio.pitch - call.audio.pitchOffset));
	}
}