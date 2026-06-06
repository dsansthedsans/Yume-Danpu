
//////// Functions related to the effect, item and theme unlock menu


// Functions related to setting up the menu
function fn_menu_unlock_event_create_0()
{
	// Main level
	LVL_MAIN = 0;
	var l = LVL_MAIN;
	
		// Box
	var _box_x = (draw_dist * 4);
	var _box_y = (240 / 2) + (draw_dist * 3);
	var _box_w = (320 - (_box_x * 2));
	var _box_h = (draw_dist * 2);
	fn_menu_box_add(l, 0, _box_x, _box_y, _box_w, _box_h);
	
		// Name [#0]
	fn_menu_info_add(l, 0, menu_info[1]);
	
		// Icon
	main_nameIco_spr = spr_menu_inv_optIco;
	main_nameIco_img = menu_info[0];
	main_nameIco_w = fn_spr_width(main_nameIco_spr);
	main_nameIco_h = fn_spr_height(main_nameIco_spr);
	var _nameIco_xTextGap = round(draw_dist / 4);
	var _nameIco_wAll = (main_nameIco_w + _nameIco_xTextGap + info_w[l, 0]);
	main_nameIco_x = (box_x[l, 0] + round(box_w[l, 0] / 2) - round(_nameIco_wAll / 2) - 1);
	main_nameIco_y = (box_y[l, 0] + round(box_h[l, 0] / 2) - round(main_nameIco_h / 2));
	main_nameIco_col = info_col[l][0][0];
	
		// Name [#1]
	info_x[l, 0] = (main_nameIco_x + main_nameIco_w + _nameIco_xTextGap);
	info_y[l, 0] = (main_nameIco_y + round(main_nameIco_h / 2) - round(info_h[l, 0] / 2) - 1);
}
function fn_menu_unlock_event_create_1()
{
	// Main level
	lvl = LVL_MAIN;
	
	var _unlock_snd = choose(global.user.theme[global.user.theme_curr].unlock_snd[0], global.user.theme[global.user.theme_curr].unlock_snd[1], global.user.theme[global.user.theme_curr].unlock_snd[2]);
	if (irandom_range(1, 100) <= 5)
		_unlock_snd = snd_;
	fn_audio_play(_unlock_snd, CONFIG_AUDIO_EMITTER.MENU);
}
function fn_menu_unlock_event_stepBegin()
{
	// Main level
	if (lvl == LVL_MAIN && lvl_alp[lvl] == 1)
	{
		if (press_slct == true) || (press_cncl == true)
			fn_menu_lvlNew(LVL_EMPTY, , true);
	}
}
function fn_menu_unlock_evDrawGUI_2(l)
{
	// Main level
	if (l == LVL_MAIN)
	{
		// Icon
		fn_draw_spr(main_nameIco_spr, main_nameIco_img, main_nameIco_x, main_nameIco_y, main_nameIco_col, (lvl_alp[l] * draw_alp));
	}
}
