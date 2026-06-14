/// @descr End Step Event
switch (object_index)
{
	// Vehicles
	case obj_actor_user_func_kart:
		if (passengers[0].id == undefined)
		{
			talk.trigger.active = false;
			call.active = false;
			slide.active = false;
		}
		else
		{
			fn_log($"{talk.trigger.active} | {fn_config_key_pressed(talk.trigger.key)} | {type} | {walk.stage}");
			talk.trigger.active = true;
			call.active = true;
			call.audio[call.audio_curr].pitch = (1 + (2 * (slide.speed / slide.speedLimit)) + random(0.5));
			slide.active = true;
		}
		break;
}