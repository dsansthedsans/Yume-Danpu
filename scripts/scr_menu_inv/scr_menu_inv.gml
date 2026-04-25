
//////// Functions related to the inventory menu


// Functions related to setting up the menu
function fn_menu_inv_evCreate_0()
{
	// Main level [#0]
	LVL_MAIN = 0;
	var l = LVL_MAIN;
	
	
	
	
	// All levels
	for (var l = 0; l < lvl_lengthMax; l++)
	{
		// Dark translucent background
		var _rect_alp = 0.5;
		if (l != LVL_MAIN)
			_rect_alp = 0.75;
		fn_menu_rect_add(l, 0, 0, 0, 320, 240, global.user.theme[global.user.theme_curr].col.blur, _rect_alp);
	}
	
	
	
	
	// Main level [#1]
	var l = LVL_MAIN;
	
	
		// Information box
	var _box_x = round(draw_dist / 1);
	var _box_y = round(draw_dist / 2);
	var _box_w = (draw_dist * 6);
	var _box_h = (draw_dist * 7);
	fn_menu_box_add(l, 0, _box_x, _box_y, _box_w, _box_h);
	
			// Player's picture frame
	main_picFrm_spr = global.user.theme[global.user.theme_curr].inv_picFrm_spr;
	main_picFrm_w = fn_spr_width(main_picFrm_spr);
	main_picFrm_h = fn_spr_height(main_picFrm_spr);
	main_picFrm_x = (box_x[l, 0] + round(box_w[l, 0] / 2) - round(main_picFrm_w / 2));
	main_picFrm_y = (box_y[l, 0] + draw_dist);
	
			// Player's picture
	main_pic_spr = obj_actor_user.dir[obj_actor_user.DIR_DN].spr;
	main_pic_snd = snd_user_fstep;
	if (irandom_range(1, 100) == 1)
	{
		main_pic_spr = spr_actor_macaco_monkey;
		main_pic_snd = snd_actor_macaco_monkey_1;
	}
	
	main_pic_w = fn_spr_width(main_pic_spr);
	main_pic_h = fn_spr_height(main_pic_spr);
	main_pic_x = (main_picFrm_x + round(main_picFrm_w / 2) - round(main_pic_w / 2));
	main_pic_y = (main_picFrm_y + round(main_picFrm_h / 2) + round(main_pic_h / 2) - 1);
	main_pic_xSc = 1;
	main_pic_ySc = 1;
	main_pic_scLen = 0.2;
	main_pic_scSpd = 0.35;
	
			// Player's name
	var _name_text = global.user.name;
	fn_menu_info_add(l, 0, _name_text);
	var _name_w = info_w[l, 0];
	var _name_h = info_h[l, 0];
	var _name_x = (main_picFrm_x + round(main_picFrm_w / 2) - round(_name_w / 2));
	var _name_yDist = round(draw_dist / 8);
	var _name_y = (main_picFrm_y + main_picFrm_h + _name_yDist);
	info_x[l, 0] = _name_x;
	info_y[l, 0] = _name_y;
	
			// Player's currency [#0]
	var _ccy_text = global.user.money[global.user.awake].ccy;
	fn_menu_info_add(l, 1, _ccy_text);
	var _ccy_w = info_w[l, 1];
	var _ccy_h = info_h[l, 1];
	
			// Player's money [#0]
	var _mny_text = global.user.money[global.user.awake].amt;
	fn_menu_info_add(l, 2, _mny_text);
	var _mny_w = info_w[l, 2];
	
			// Icon of the user's money
	main_mnyIco_spr = spr_menu_inv_mnyIco;
	main_mnyIco_w = fn_spr_width(main_mnyIco_spr);
	main_mnyIco_h = fn_spr_height(main_mnyIco_spr);
	var _mnyIco_xTextGap = round(draw_dist / 4);
	var _mnyIco_wAll = (main_mnyIco_w + _mnyIco_xTextGap + _ccy_w + _mny_w);
	main_mnyIco_x = (main_picFrm_x + round(main_picFrm_w / 2) - round(_mnyIco_wAll / 2) - 1);
	var _mnyIco_yNameGap = (draw_dist / 2);
	main_mnyIco_y = (_name_y + _name_h + _mnyIco_yNameGap);
	main_mnyIco_col = global.user.theme[global.user.theme_curr].col.whiteLight;
	
			// Player's currency [#1]
	var _ccy_x = (main_mnyIco_x + main_mnyIco_w + _mnyIco_xTextGap);
	var _ccy_y = (main_mnyIco_y + round(main_mnyIco_h / 2) - round(_ccy_h / 2) - 1);
	var _ccy_col_0 = global.user.theme[global.user.theme_curr].col.grayLight;
	var _ccy_col_1 = global.user.theme[global.user.theme_curr].col.grayDark;
	info_x[l, 1] = _ccy_x;
	info_y[l, 1] = _ccy_y;
	info_col[l][1][0] = _ccy_col_0;
	info_col[l][1][1] = _ccy_col_1;
	
			// Player's money [#1]
	var _mny_x = (_ccy_x + _ccy_w);
	var _mny_y = _ccy_y;
	var _mny_col_0 = global.user.theme[global.user.theme_curr].col.whiteLight;
	var _mny_col_1 = global.user.theme[global.user.theme_curr].col.whiteDark;
	info_x[l, 2] = _mny_x;
	info_y[l, 2] = _mny_y;
	info_col[l][2][0] = _mny_col_0;
	info_col[l][2][1] = _mny_col_1;
	
	
		// Option box
	var _box_x = box_x[l, 0];
	var _box_y = (box_y[l, 0] + box_h[l, 0] + box_y[l, 0]);
	var _box_w = box_w[l, 0]
	var _box_h = 70;
	fn_menu_box_add(l, 1, _box_x, _box_y, _box_w, _box_h);
	
			// Options [#0]
	fn_menu_opt_add_ext(l, "menu_inv_main_opt_");
	opt_cncl_key[l, 1] = CONFIG_KEY.MENU_USER;
	
			// Icon of the options [#0]
	main_optIco_spr = spr_menu_inv_optIco;
	main_optIco_w = fn_spr_width(main_optIco_spr);
	main_optIco_h = fn_spr_height(main_optIco_spr);
	var _optIco_xTextGap = _mnyIco_xTextGap;
	var _optIco_wAll = (main_optIco_w + _optIco_xTextGap + opt_wMax[l]);
	main_optIco_x = (box_x[l, 1] + round(box_w[l, 1] / 2) - round(_optIco_wAll / 2) - 1);
	var _optIco_yDist = draw_dist;
	var _optIco_hAll = ((_optIco_yDist * (opt_len[l] - 1)) + main_optIco_h);
	
			// Icon of the options [#1], options [#1]
	for (var o = 0; o < opt_len[l]; o++)
	{
		// Icon of the options [#1]
		main_optIco_y[o] = (box_y[l, 1] + round(box_h[l, 1] / 2) - round(_optIco_hAll / 2) + (_optIco_yDist * o));
		
		// Options [#1]
		opt_x[l, o] = (main_optIco_x + main_optIco_w + _optIco_xTextGap);
		opt_y[l, o] = (main_optIco_y[o] + round(main_optIco_h / 2) - round(opt_h[l, o] / 2) - 1);
		
			// Option selector
		fn_menu_opt_slctr_add(l, o);
		opt_slctr_x[l, o] = (opt_slctr_x[l, o] - _optIco_xTextGap - main_optIco_w - 1);
		opt_slctr_w[l, o] = (opt_slctr_w[l, o] + _optIco_xTextGap + main_optIco_w + 1);
	}
	
	
	
	
	// Other levels (Effects, Items and Themes)
	LVL_OTHER_EFFECT = 1;
	LVL_OTHER_FUNC = 2;
	LVL_OTHER_THEME = 3;
	
	for (var l = LVL_OTHER_EFFECT; l <= LVL_OTHER_THM; l++)
	{
		// Get data of the current level
		other_textData_key = "effect";
		other_arr = global.user.effect;
		
		if (l == LVL_OTHER_FUNC)
		{
			other_textData_key = "func";
			other_arr = global.user.func;
		}
		
		else if (l == LVL_OTHER_THEME)
		{
			other_textData_key = "theme";
			other_arr = global.user.theme;
		}
		
		other_lengthMax = 14;
		
		
		// Title
		fn_menu_ttl_add(l, fn_config_lang_data_getText($"menu_inv_{other_textData_key}_ttl"));
		
		// Box
		var _box_xMargin = (draw_dist * 2);
		var _box_yMargin = draw_dist;
		
		var _box_x = _box_xMargin;
		var _box_y = (ttl_box_y[l] + ttl_box_h[l] + _box_yMargin);
		var _box_w = (320 - (_box_x * 2));
		var _box_h = (240 - _box_y - _box_yMargin);
		fn_menu_box_add(l, 0, _box_x, _box_y, _box_w, _box_h);
		
		// Options
		var _opt_xMul = 0;
		var _opt_yMul = 0;
		for (var o = 0; o < other_lengthMax; o++)
		{
			// Options
			var _opt_text = "----------";
			var _opt_slct_snd = global.user.theme[global.user.theme_curr].opt_error_snd;
			if (o < array_length(other_arr) && array_get(other_arr, o).unlocked == true)
				_opt_text = array_get(other_arr, o).name;
			
			fn_menu_opt_add(l, o, _opt_text);
			
			opt_x[l, o] = (box_x[l, 0] + ((box_w[l, 0] / 2) * _opt_xMul) + (draw_dist * 2));
			opt_y[l, o] = (box_y[l, 0] + draw_dist + (draw_dist * _opt_yMul));
			opt_slct_snd[l, o] = _opt_slct_snd;
			_opt_xMul += 1;
			if (_opt_xMul == 2)
			{
				_opt_xMul = 0;
				_opt_yMul += 1;
			}
			
			fn_menu_opt_slctr_add(l, o); // Option selector
			
			
				// Options' description
			if (o < array_length(other_arr) && array_get(other_arr, o).unlocked == true)
			{
				var _info_text = array_get(other_arr, o).desc;
				fn_menu_opt_desc_add(l, o, _info_text);
				
				opt_desc_x[l, o] = (box_x[l, 0] + draw_dist);
				opt_desc_y[l, o] = (box_y[l, 0] + box_h[l, 0] - draw_dist - opt_desc_h[l, o]);
			}
		}
		opt_move_type[l] = OPT_MOVE_TYPE_invOther;
	}
}
function fn_menu_inv_evCreate_1()
{
	// Main level
	lvl = LVL_MAIN;
	fn_audio_play(global.user.theme[global.user.theme_curr].opt_slct_snd, CONFIG_AUDIO_EMITTER.MENU);
}
function fn_menu_inv_evDrawGUI_2(l)
{
	// Main level
	if (l == LVL_MAIN)
	{	
		// Information box
			// Draws the user's picture frame
		fn_draw_spr(main_picFrm_spr, 0, main_picFrm_x, main_picFrm_y, , (lvl_alp[l] * draw_alp));
		
			// Draws the user's picture
		if (global.config_hideCursor == false && mouse_check_button_pressed(mb_any) == true)
		{
			var _ptr_x = (window_mouse_get_x() / 2);
			var _ptr_y = (window_mouse_get_y() / 2);
			var _ptr_xMeet = (_ptr_x > main_pic_x && _ptr_x < (main_pic_x + main_pic_w));
			var _ptr_yMeet = (_ptr_y < main_pic_y && _ptr_y > (main_pic_y - main_pic_h));
			var _ptr_meet = (_ptr_xMeet == true && _ptr_yMeet == true)
			if (_ptr_meet == true)
			{
				var _pic_scLen_mulMin = 0.75;
				var _pic_scLen_mulMax = 1.5;
				main_pic_xSc += (main_pic_scLen * random_range(_pic_scLen_mulMin, _pic_scLen_mulMax));
				main_pic_ySc -= (main_pic_scLen * random_range(_pic_scLen_mulMin, _pic_scLen_mulMax));
				
				var _ptr_snd_pitch = random_range(0.75, 2.25);
				var _ptr_snd = fn_audio_play(main_pic_snd, CONFIG_AUDIO_EMITTER.USER);
				fn_audio_pitch(_ptr_snd, _ptr_snd_pitch);
			}
		}
		
		fn_draw_spr(main_pic_spr, 0, main_pic_x - ((main_pic_w / 2) * abs(main_pic_xSc - 1)), main_pic_y, , (lvl_alp[l] * draw_alp), main_pic_xSc, main_pic_ySc);
		main_pic_xSc = lerp(main_pic_xSc, 1, main_pic_scSpd);
		main_pic_ySc = lerp(main_pic_ySc, 1, main_pic_scSpd);
		
			// Draws the icon of the user's money
		fn_draw_spr(main_mnyIco_spr, 0, main_mnyIco_x, main_mnyIco_y, main_mnyIco_col, (lvl_alp[l] * draw_alp), , , , true);
		
		
		// Option box
			// Icon of the options
		for (var o = 0; o < opt_len[l]; o++)
			fn_draw_spr(main_optIco_spr, o, main_optIco_x, main_optIco_y[o], opt_col[l][o][0], (opt_alp[l, o] * lvl_alp[l] * draw_alp), , , , true);
	}
}


// Functions related to the options
function fn_menu_inv_opt_slct()
{
	var l = lvl;
	var o = opt_move_pos[l];
	
	// Main level
	if (l == LVL_MAIN)
		fn_menu_lvlNew((o + 1));
	
	// Other levels (effects, items and themes)
	else if (l == LVL_OTHER_FUNC)
	{
		if (o < array_length(global.user.func) && global.user.func[o].unlocked == true)
		{
			if (global.user.func_curr != o)
			{
				fn_user_func_equip(o);
				opt_slct_snd[l, o] = global.user.theme[global.user.theme_curr].equip_snd[0];
			}
			else
			{
				global.user.func_curr = -1;
				opt_slct_snd[l, o] = global.user.theme[global.user.theme_curr].equip_snd[1];
			}
		}
	}
	else if (l == LVL_OTHER_THEME)
	{
		if (o < array_length(global.user.theme) && global.user.theme[o].unlocked == true)
		{
			if (global.user.theme_curr != o)
			{
				fn_user_theme_equip(o);
				opt_slct_snd[l, o] = global.user.theme[global.user.theme_curr].equip_snd[0];
			}
		}
		else
			opt_slct_snd[l, o] = global.user.theme[global.user.theme_curr].opt_error_snd;
	}
}
function fn_menu_inv_opt_cncl()
{
	var l = lvl;
	
	// Main level
	if (l == LVL_MAIN)
		fn_menu_lvlNew(LVL_EMPTY, , true);
	
	// Other levels (Effects, Items and Themes)
	else if (l >= LVL_OTHER_EFFECT && l <= LVL_OTHER_THEME)
		fn_menu_lvlNew(LVL_MAIN);
}
