
if (is_array(lvl) == true)
{
	var l = lvl_curr;
	
	// Fade transition is inactive
	if (lvl_fader.stg == -1)
	{
		// Options
		if (is_array(lvl[l].option) == true)
		{
			// Movement
			if (lvl[l].option_move.act == true)
			{
				var _option_currOld = lvl[l].option_curr;
				
				// List type
				if (lvl[l].option_move.list.act == true)
				{
					lvl[l].option_curr += (fn_config_key_pressed(lvl[l].option_move.list.key[1]) - fn_config_key_pressed(lvl[l].option_move.list.key[0]));
					if (lvl[l].option_curr <= -1)
						lvl[l].option_curr = (array_length(lvl[l].option) - 1);
					if (lvl[l].option_curr >= array_length(lvl[l].option))
						lvl[l].option_curr = 0;
				}
				// Table type
				else if (lvl[l].option_move.table.act == true)
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
					_move_snd = ((lvl[l].option_move.snd != undefined) ? lvl[l].option_move.snd : global.user.thm[global.user.thm_curr].snd.move);
					event_user(4);
					if (_move_snd != undefined)
						fn_aud_play(_move_snd, CONFIG_AUD_EMTR.MENU);
				}
			}
			var o = lvl[l].option_curr;
			// Confirmation
			if (lvl[l].option_confirm.act == true && fn_config_key_pressed(lvl[l].option_confirm.key) == true)
			{
				_confirm_snd = ((is_struct(lvl[l].option[o].value) == false) ? ((lvl[l].option_confirm.snd != undefined) ? lvl[l].option_confirm.snd : global.user.thm[global.user.thm_curr].snd.confirm) : undefined);
				event_user(0);
				if (_confirm_snd != undefined)
					fn_aud_play(_confirm_snd, CONFIG_AUD_EMTR.MENU);
				// Option's checkbox
				if (is_struct(lvl[l].option[o].check) == true)
					lvl[l].option[o].check.mark.act = !lvl[l].option[o].check.mark.act;
			}
			// Cancellation
			else if (lvl[l].option_cancel.act == true && (fn_config_key_pressed(lvl[l].option_cancel.key[0]) == true || (lvl[l].option_cancel.key[1] != undefined && fn_config_key_pressed(lvl[l].option_cancel.key[1]) == true)))
			{
				_cancel_snd = ((lvl[l].option_cancel.snd != undefined) ? lvl[l].option_cancel.snd : global.user.thm[global.user.thm_curr].snd.cancel);
				event_user(1);
				if (_cancel_snd != undefined)
					fn_aud_play(_cancel_snd, CONFIG_AUD_EMTR.MENU);
			}
			// Value cycling
			else if (lvl[l].option[o].value != undefined)
			{
				for (var a = 0; a < 2; a++)
				{
					if (fn_config_key_pressed(lvl[l].option[o].value.arrow[a].key) == true && lvl[l].option[o].value.arrow[a].act == true)
					{
						_cycle_sign = (fn_config_key_pressed(lvl[l].option[o].value.arrow[1].key) - fn_config_key_pressed(lvl[l].option[o].value.arrow[0].key));
						event_user(2);
						if (global.config.access.rdcdMot.act == false)
						{
							lvl[l].option[o].value.scale = lvl[l].option[o].value.scaleTgts[true];
							lvl[l].option[o].value.colorVal = lvl[l].option[o].value.colorValTgts[true];
							lvl[l].option[o].value.arrow[a].alpha = lvl[l].option[o].value.arrow[a].alphaTgts[true];
							lvl[l].option[o].value.arrow[a].scale = lvl[l].option[o].value.arrow[a].scaleTgts[true];
						}
						fn_aud_play(global.user.thm[global.user.thm_curr].snd.move, CONFIG_AUD_EMTR.MENU, , , 1.5);
						break;
					}
				}
			}
		}
	}
	
	// Fade transition is active
	else if (lvl_fader.stg > -1)
	{
		lvl[lvl_curr].alpha = fn_lerp(lvl[lvl_curr].alpha, 0, lvl_fader.alpSpd);
		if (lvl_fader.prev.snd != undefined)
			fn_aud_play(lvl_fader.prev.snd, CONFIG_AUD_EMTR.MENU);
		lvl_fader.prev.snd = undefined;
		if (lvl_fader.next.wait_dur <= 0)
		{
			lvl[lvl_fader.next.lvl].alpha = fn_lerp(lvl[lvl_fader.next.lvl].alpha, 1, lvl_fader.alpSpd);
			if (lvl[lvl_fader.next.lvl].alpha >= (1 - lvl_fader.alpJump))
			{
				lvl[lvl_curr].alpha = 0;
				lvl[lvl_fader.next.lvl].alpha = 1;
				lvl_curr = lvl_fader.next.lvl;
				lvl_fader.stg = -1;
				if (lvl_fader.next.snd != undefined)
					fn_aud_play(lvl_fader.next.snd, CONFIG_AUD_EMTR.MENU);
				lvl_fader.next.snd = undefined;
				if (lvl_fader.next.destroy == true)
				{
					if (fn_obj_exists(obj_actor_user) == true && obj_actor_user.move.act == false)
						obj_actor_user.move.act = true;
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
