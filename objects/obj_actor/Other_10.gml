/// @descr Create Event

/* Presets */
/*switch (object_index)
{
	// Good/Peaceful entities
	// Evil/Hostile entities
	// Vehicles
}*/
		
/* Custom (per-object customization) */
switch (object_index)
{
	// User
	case obj_actor_user:
		talk.active = true;
		talk.trigger.active = true;
		facing[FACING_WEST].sprite = spr_actor_user_facing_west;
		facing[FACING_EAST].sprite = spr_actor_user_facing_east;
		facing[FACING_NORTH].sprite = spr_actor_user_facing_north;
		facing[FACING_SOUTH].sprite = spr_actor_user_facing_south;
		walk.mode = WALK_MODE_MANUAL;
		walk.timeLimit = 16;
		walk.delay.active = false;
		walk.chain.active = false;
		walk.step.active = true;
		walk.step.audio_asset = snd_actor_user_walk_step;
		walk.step.audio_emitter = CONFIG_AUDIO_EMITTER.USER;
		break;
	// Good/Peaceful entities
	case obj_actor_macaco_monkey:
		myself.imageSpeed = (random_range(0.5, 1.5) / 30);
		talk.active = true;
		talk.bell.active = true;
		talk.bell.audio_assets = [snd_actor_macaco_monkey_0, snd_actor_macaco_monkey_1, snd_actor_macaco_monkey_2, snd_actor_macaco_monkey_3, snd_actor_macaco_monkey_4, snd_actor_macaco_monkey_5, snd_actor_macaco_monkey_6];
		talk.bell.audio_assetsRarity = [10, 10, 10, 10, 10, 1, 1];
		break;
	// Evil/Hostile entities
	// Vehicles
	case obj_actor_user_func_kart:
		talk.active = true;
		talk.ride.active = true;
		talk.ride.mode = TALK_RIDE_MODE_DRIVER;
		call.audio[0].asset = snd_actor_user_func_kart_call_0;
		call.audio[0].emitter = CONFIG_AUDIO_EMITTER.USER;
		call.audio[0].loops = false;
		call.audio[1].asset = snd_actor_user_func_kart_call_1;
		call.audio[1].emitter = CONFIG_AUDIO_EMITTER.USER;
		facing[FACING_WEST].sprite = spr_actor_user_func_kart_facing_west;
		facing[FACING_EAST].sprite = spr_actor_user_func_kart_facing_east;
		facing[FACING_NORTH].sprite = spr_actor_user_func_kart_facing_north;
		facing[FACING_SOUTH].sprite = spr_actor_user_func_kart_facing_south;
		walk.active = false;
		slide.steer.audio.asset = snd_actor_user_func_kart_steer;
		slide.steer.audio.emitter = CONFIG_AUDIO_EMITTER.USER;
		slide.crash.audio.asset = snd_actor_user_func_kart_crash;
		slide.crash.audio.emitter = CONFIG_AUDIO_EMITTER.USER;
		break;
}