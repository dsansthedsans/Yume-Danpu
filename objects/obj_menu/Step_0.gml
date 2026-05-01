
if (is_array(lvl) == true)
{
	var l = lvl_curr;
	
	// Fade transition is inactive
	if (lvl_fader.stage == -1)
	{
		// Options
		if (is_array(lvl[l].option) == true)
		{
			// Movement
			if (lvl[l].option_move.active == true)
			{
				var _option_currOld = lvl[l].option_curr;
				
				// List type
				if (lvl[l].option_move.list.active == true)
				{
					lvl[l].option_curr += (fn_config_key_pressed(lvl[l].option_move.list.key[1]) - fn_config_key_pressed(lvl[l].option_move.list.key[0]));
					if (lvl[l].option_curr <= -1)
						lvl[l].option_curr = (array_length(lvl[l].option) - 1);
					if (lvl[l].option_curr >= array_length(lvl[l].option))
						lvl[l].option_curr = 0;
				}
				// Table type
				else if (lvl[l].option_move.table.active == true)
				{
					if (fn_config_key_pressed(CONFIG_KEY.RT) == true) || (fn_config_key_pressed(CONFIG_KEY.LT) == true)
					{
						if (lvl[l].option_curr % 2 == 0)
							lvl[l].option_curr += 1;
						else if (lvl[l].option_curr % 2 == 1)
							lvl[l].option_curr -= 1;
					}
					if (fn_config_key_pressed(CONFIG_KEY.DN) == true)
					{
						if ((lvl[l].option_curr + 2) <= (array_length(lvl[l].option) - 1))
							lvl[l].option_curr += 2;
						else
							lvl[l].option_curr = (0 + (lvl[l].option_curr % 2));
					}
					else if (fn_config_key_pressed(CONFIG_KEY.UP) == true)
					{
						if ((lvl[l].option_curr - 2) >= 0)
							lvl[l].option_curr -= 2;
						else
							lvl[l].option_curr = (array_length(lvl[l].option) - 1 - !(lvl[l].option_curr % 2));
					}
				}
			
				if (_option_currOld != lvl[l].option_curr)
				{
					_move_snd = ((lvl[l].option_move.snd != undefined) ? lvl[l].option_move.snd : global.user.theme[global.user.theme_curr].snd.move);
					event_user(4);
					if (_move_snd != undefined)
						fn_audio_play(_move_snd, CONFIG_AUDIO_EMITTER.MENU);
				}
			}
			var o = lvl[l].option_curr;
			// Confirmation
			if (lvl[l].option_confirm.active == true && fn_config_key_pressed(lvl[l].option_confirm.key) == true)
			{
				// Option's checkbox
				if (is_struct(lvl[l].option[o].check) == true)
					lvl[l].option[o].check.mark.active = !lvl[l].option[o].check.mark.active;
				
				_confirm_snd = ((is_struct(lvl[l].option[o].value) == false) ? ((lvl[l].option_confirm.snd != undefined) ? lvl[l].option_confirm.snd : global.user.theme[global.user.theme_curr].snd.confirm) : undefined);
				event_user(0);
				if (_confirm_snd != undefined)
					fn_audio_play(_confirm_snd, CONFIG_AUDIO_EMITTER.MENU);
			}
			// Cancellation
			else if (lvl[l].option_cancel.active == true && (fn_config_key_pressed(lvl[l].option_cancel.key[0]) == true || (lvl[l].option_cancel.key[1] != undefined && fn_config_key_pressed(lvl[l].option_cancel.key[1]) == true)))
			{
				_cancel_snd = ((lvl[l].option_cancel.snd != undefined) ? lvl[l].option_cancel.snd : global.user.theme[global.user.theme_curr].snd.cancel);
				event_user(1);
				if (_cancel_snd != undefined)
					fn_audio_play(_cancel_snd, CONFIG_AUDIO_EMITTER.MENU);
			}
			// Value cycling
			else if (lvl[l].option[o].value != undefined)
			{
				for (var a = 0; a < 2; a++)
				{
					if (fn_config_key_pressed(lvl[l].option[o].value.arrow[a].key) == true && lvl[l].option[o].value.arrow[a].active == true)
					{
						_cycle_sign = (fn_config_key_pressed(lvl[l].option[o].value.arrow[1].key) - fn_config_key_pressed(lvl[l].option[o].value.arrow[0].key));
						event_user(2);
						if (global.config.access.reduceMotion.active == false)
						{
							lvl[l].option[o].value.scale = lvl[l].option[o].value.scaleTargets[true];
							lvl[l].option[o].value.colorVal = lvl[l].option[o].value.colorValTargets[true];
							lvl[l].option[o].value.arrow[a].alpha = lvl[l].option[o].value.arrow[a].alphaTargets[true];
							lvl[l].option[o].value.arrow[a].scale = lvl[l].option[o].value.arrow[a].scaleTargets[true];
						}
						fn_audio_play(global.user.theme[global.user.theme_curr].snd.move, CONFIG_AUDIO_EMITTER.MENU, , 1.5);
						break;
					}
				}
			}
		}
	}
	
	// Fade transition is active
	else if (lvl_fader.stage > -1)
	{
		lvl[lvl_curr].alpha = fn_lerp(lvl[lvl_curr].alpha, 0, lvl_fader.alpSpeed);
		if (lvl_fader.prev.snd != undefined)
			fn_audio_play(lvl_fader.prev.snd, CONFIG_AUDIO_EMITTER.MENU);
		lvl_fader.prev.snd = undefined;
		if (lvl_fader.next.wait_dur <= 0)
		{
			lvl[lvl_fader.next.lvl].alpha = fn_lerp(lvl[lvl_fader.next.lvl].alpha, 1, lvl_fader.alpSpeed);
			if (lvl[lvl_fader.next.lvl].alpha >= (1 - lvl_fader.alpJump))
			{
				lvl[lvl_curr].alpha = 0;
				lvl[lvl_fader.next.lvl].alpha = 1;
				lvl_curr = lvl_fader.next.lvl;
				lvl_fader.stage = -1;
				if (lvl_fader.next.snd != undefined)
					fn_audio_play(lvl_fader.next.snd, CONFIG_AUDIO_EMITTER.MENU);
				lvl_fader.next.snd = undefined;
				if (lvl_fader.next.destroy == true)
				{
					if (fn_obj_exists(obj_actor_user) == true && obj_actor_user.move.active == false)
						obj_actor_user.move.active = true;
					fn_obj_destroy();
				}
				if (lvl_fader.next.endgame == true)
					game_end();
			}
		}
		else
			lvl_fader.next.wait_dur -= 1;
	}
}
