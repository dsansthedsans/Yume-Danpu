
//////// Functions related to actors (characters like entities and the user)
// I'm Old!

function fn_actor_event_createAAAAAAAAAAAA() // Create Event determined by the actor's object index
{
	// Main data (presets)
	switch (object_index)
	{
		// Good/Peaceful entities
		case obj_actor_macaco_monkey: // Macacolandia monkey citizen
			talk.type.bell.audio_emitter = CONFIG_AUDIO_EMITTER.ACTOR;
			call.audio.emitter = CONFIG_AUDIO_EMITTER.ACTOR;
			move.wait.active = true;
			move.mode.auto.active = true;
			move.type.walk.active = true;
			move.type.walk.dur = 32;
			move.chain.active = true;
		break;
		
		
		// Evil/Hostile entities
		case obj_actor_dbgwrld_blood: // Debug World blood monkey
			call.audio.emitter = CONFIG_AUDIO_EMITTER.ACTOR;
			call.aud.asset = snd_prop_call_weird;
			move.mode.auto.active = true;
			move.mode.auto.chase_act = true;
			move.mode.auto.chase_tgt = obj_actor_user;
			move.type.walk.active = true;
			move.type.walk.dur = 24;
		break;
	}
	
	// Other data (object-specific personalization)
	switch (object_index)
	{
		// Player
		case obj_actor_user:
			myself.draw.active = true;
			talkTrig.active = true;
			dir[DIR_LT].spr = spr_user_dir_lt;
			dir[DIR_RT].spr = spr_user_dir_rt;
			dir[DIR_UP].spr = spr_user_dir_up;
			dir[DIR_DN].spr = spr_user_dir_dn;
			move.precise = false;
			move.mode.manual.active = true;
			move.type.walk.active = true;
			move.type.walk.fstep.active = true;
			move.type.walk.fstep.snd_asset = snd_actor_user_walk_step;
			move.type.walk.fstep.snd_emitter = CONFIG_AUDIO_EMITTER.USER;
			move.type.roll.active = false;
			
			if (global.user.effect_curr == -1 && global.user.func_curr == -1)
			{
				if (func_old == USER_FUNC.KART)
				{
					x = fn_actor_xRound(id, x);
					y = fn_actor_xRound(id, y);
					myself.x = x;
					myself.y = y;
					move.type.roll.dist = 0;
				}
			}
			else if (global.user.func_curr == USER_FUNC.KART)
			{
				myself.draw.active = false;
				move.precise = false;
				move.type.walk.active = false;
				move.type.roll.active = true;
				move.type.roll.snd_asset = snd_user_func_kart;
				move.type.roll.snd_emitter = CONFIG_AUDIO_EMITTER.USER;
				move.type.roll.start.snd_asset = snd_actor_user_func_kart_start;
				move.type.roll.start.snd_emitter = CONFIG_AUDIO_EMITTER.USER;
				move.type.roll.turn.snd_asset = snd_actor_user_func_kart_turn;
				move.type.roll.turn.snd_emitter = CONFIG_AUDIO_EMITTER.USER;
				move.type.roll.hit.snd_asset = snd_actor_user_func_kart_hit;
				move.type.roll.hit.snd_emitter = CONFIG_AUDIO_EMITTER.USER;
			}
		break;
		
		// Good/Peaceful entities
		case obj_actor_macaco_monkey: // Macacolandia monkey citizen
			myself.imgSpeed = (random_range(0.5, 1.5) / 30);
			talk.active = true;
			talk.type.bell.active = true;
			for (var a = 0; a < 7; a++)
				talk.type.bell.aud_asset[a] = asset_get_index($"snd_actor_macaco_monkey_{a}");
		break;
		
		// Evil/Hostile entities
		case obj_actor_dbgwrld_blood: // Debug World blood monkey
			myself.imgSpeed = (random_range(0.5, 1.5) / 30);
		break;
	}
}
function fn_actor_qwewqeqwewqewqeqweevent_stepBegin() // Step Event determined by the actor's object index
{
	if (talk.type.bell.active == true && talk.stage == 0)
	{
		switch (object_index)
		{
			case obj_actor_macaco_monkey: // Macacolandia monkey citizen
				talk.type.bell.aud_idx = irandom_range(0, 4);
				if (irandom_range(1, 100) <= 5)
					talk.type.bell.aud_idx = irandom_range(5, 6);
				break;
		}
	}
}


function fn_actor_dir(_obj, _dir)
{
	if (fn_obj_exists(_obj) == true)
		_obj.dir_curr = _dir;
}
function fn_actor_dir_spr(_obj, _lt_spr, _rt_spr = _lt_spr, _up_spr = _lt_spr, _dn_spr = _lt_spr)
{
	if (fn_obj_exists(_obj) == true)
	{
		_obj.dir[_obj.DIR_LT].spr = _lt_spr;
		_obj.dir[_obj.DIR_RT].spr = _rt_spr;
		_obj.dir[_obj.DIR_UP].spr = _up_spr;
		_obj.dir[_obj.DIR_DN].spr = _dn_spr;
	}
}


function fn_actor_xRound(_obj, _x)
{
	if (fn_obj_exists(_obj) == true)
		return (16 * round(_x / 16));
	else
		return 0;
}
function fn_actor_yRound(_obj, _y)
{
	if (fn_obj_exists(_obj) == true)
		return (16 * round(_y / 16));
	else
		return 0;
}
function fn_actor_xAhead(_obj, _x, _dir, _dist)
{
	if (fn_obj_exists(_obj) == true)
		return (_x + ((_dist * _obj.dir[_dir].sign) * (_obj.dir[_dir].axis == _obj.DIR_AXIS_HOR)));
	else
		return 0;
}
function fn_actor_yAhead(_obj, _y, _dir, _dist)
{
	if (fn_obj_exists(_obj) == true)
		return (_y + ((_dist * _obj.dir[_dir].sign) * (_obj.dir[_dir].axis == _obj.DIR_AXIS_VER)));
	else
		return 0;
}



