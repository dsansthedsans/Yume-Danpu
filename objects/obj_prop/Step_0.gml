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
				if (b.audio_index == undefined)
					b.audio_index = irandom_range(0, (array_length(b.audio_assets) - 1));
				fn_audio_play(b.audio_assets[b.audio_index], b.audio_emitter);
				talk.stage = 1;
				b.time = 0;
			}
			else if (talk.stage == 1)
			{
				b.time += 1;
				if (b.time >= b.timeTarget)
				{
					talk.stage = -1;
					if (myself.type == "actor")
						move.stage = -1;
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
			if (myself.type == "actor")
				move.stage = -1;
		}
	}
	else if (talk.stage == -1)
	{
		/* Types */
		// Starts another object's interaction sequence
		if (talk.trigger.active == true && fn_config_key_pressed(talk.trigger.key) == true && ((myself.type == "prop") || (myself.type == "actor" && move.stage == -1)))
		{
			var _target = instance_place(fn_actor_xAhead(id, x, dir_curr, talk.trigger.distance), fn_actor_yAhead(id, y, dir_curr, talk.trigger.distance), obj_prop);
			if (_target != noone && _target.talk.active == true && _target.talk.stage == -1 && ((_target.myself.type == "prop") || (_target.myself.type == "actor" && _target.move.stage == -1)))
			{
				talk.stage = -2;
				if (myself.type == "actor")
					move.stage = -2;
				talk.trigger.target = _target;
				talk.trigger.target.talk.stage = 0;
				if (talk.trigger.target.myself.type == "actor")
					talk.trigger.target.move.stage = -2;
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
			if (myself.type == "actor")
				move.stage = -1;
			talk.trigger.target = undefined;
		}
	}
}

/* Plays an audio the player can only hear if they're close */
if (noise.active == true && noise.audio.asset != undefined && noise.audio.emitter != undefined)
{
	// Delay
	if (noise.delay.active == true)
	{
		noise.delay.time -= 1;
		if (noise.delay.time <= 0)
		{
			if (noise.audio.id != undefined)
			{
				if (audio_is_playing(noise.audio.id) == true)
					fn_audio_stop(noise.audio.id);
				noise.audio.id = undefined;
			}
			noise.delay.time = irandom_range(noise.delay.timeMin, noise.delay.timeMax);
		}
	}
	// Audio
	if (noise.audio.id == undefined)
		noise.audio.id =  fn_audio_play(noise.audio.asset, noise.audio.emitter, 0, , , noise.audio.loops);	
	else if (audio_is_playing(noise.audio.id) == true)
	{
		var _clamp = (clamp(distance_to_object(obj_actor_user), 0, noise.audio.distance) / noise.audio.distance);
		noise.audio.volume = lerp(noise.audio.volume, (1 - _clamp), noise.audio.volumeSpeed);
		noise.audio.pitchOffset = lerp(noise.audio.pitchOffset, (noise.audio.pitchOffsetMax * _clamp), noise.audio.pitchSpeed);
		fn_audio_volume(noise.audio.asset, noise.audio.id, noise.audio.emitter, noise.audio.volume);
		fn_audio_pitch(noise.audio.asset, noise.audio.id, (noise.audio.pitch - noise.audio.pitchOffset));
	}
}