
/// @descr Create Event
switch (object_index)
{
	/* Main menu */
	case obj_menu_home:
	{
		// Language level
		LVL_LANG = 1;
		var l = LVL_LANG;
		fn_menu_lvl_add(l);
		if (global.config.lang_hasChosen == false)
			fn_menu_lvl_fader_start(l, global.user.theme[global.user.theme_curr].audio.start, , , 120);
		fn_menu_lvl_panel_add(l, 0); // Panel
		fn_menu_lvl_panel_title_add(l, 0); // Panel's title
		for (var o = 0; o < array_length(global.config.lang); o++) // Options and decorations
		{
			fn_menu_lvl_option_add(l, o);
			fn_menu_lvl_option_icon_add(l, o);	
			fn_menu_lvl_decor_add(l, o);
		}
		lvl[l].option_move.list.key = [CONFIG_KEY.WEST, CONFIG_KEY.EAST];
		lvl[l].option_cancel.active = false;
		// Main level
		LVL_MAIN = 2;
		var l = LVL_MAIN;
		fn_menu_lvl_add(l);
		if (global.config.lang_hasChosen == true)
			fn_menu_lvl_fader_start(l, , , 0);
		fn_menu_lvl_train_add(l, 0);
		for (var p = 0; p < 2; p++)
			fn_menu_lvl_panel_add(l, p);
		fn_menu_lvl_card_add(l, 0);
		for (var o = 0; o < 3; o++)
		{
			fn_menu_lvl_option_add(l, o);
			fn_menu_lvl_option_icon_add(l, o)
		}
		fn_menu_lvl_decor_add(l, 0);
		lvl[l].option_cancel.active = false;
		break;
	}
	
	/* Settings menu */
	case obj_menu_config:
	{
		
		// Main level
		LVL_MAIN = 1;
		var l = LVL_MAIN;
		fn_menu_lvl_add(l);
		fn_menu_lvl_fader_start(l);
		fn_menu_lvl_panel_add(l, 0);
		fn_menu_lvl_panel_title_add(l, 0);
		for (var o = 0; o < 4; o++)
		{
			fn_menu_lvl_option_add(l, o);
			fn_menu_lvl_option_icon_add(l, o);
		}
		fn_menu_lvl_option_value_add(l, 0);
		// Graphics, Music & Sounds and Accessibility levels
		LVL_VIDEO = 2;
		LVL_AUDIO = 3;
		LVL_ACCESS = 4;
		for (var l = LVL_VIDEO; l <= LVL_ACCESS; l++)
		{
			fn_menu_lvl_add(l);
			fn_menu_lvl_panel_add(l, 0);
			fn_menu_lvl_panel_title_add(l, 0);
			if (l == LVL_VIDEO) || (l == LVL_AUDIO)
			{
				for (var o = 0; o < 7; o++)
				{
					fn_menu_lvl_option_add(l, o);
					fn_menu_lvl_option_value_add(l, o);
				}
			}
		}
		fn_menu_lvl_option_add(LVL_ACCESS, 0);
		fn_menu_lvl_option_value_add(LVL_ACCESS, 0);
		break;
	}
	
	/* Inventory menu */
	case obj_menu_user:
	{
		// All levels
		LVL_MAIN = 1;
		LVL_USER_EFFECT = 2;
		LVL_USER_FUNC = 3;
		LVL_USER_THEME = 4;
		fn_menu_lvl_add(LVL_MAIN);
		fn_menu_lvl_add(LVL_USER_EFFECT);
		fn_menu_lvl_add(LVL_USER_FUNC);
		fn_menu_lvl_add(LVL_USER_THEME);
		for (var l = 0; l < array_length(lvl); l++)
			fn_menu_lvl_rect_add(l, 0, 0, 0, global.config.video.resolution[0].width, global.config.video.resolution[0].height);
		// Main level
		var l = LVL_MAIN;
		lvl[l].option_cancel.key[1] = CONFIG_KEY.MENU_USER;
		fn_menu_lvl_fader_start(l, , , , , global.user.theme[global.user.theme_curr].audio.confirm);
		for (var o = 0; o < 3; o++)
		{
			fn_menu_lvl_option_add(l, o);
			fn_menu_lvl_option_icon_add(l, o);
		}
		for (var p = 0; p < 2; p++)
			fn_menu_lvl_panel_add(l, p);
		fn_menu_lvl_decor_add(l, 0);
		fn_menu_lvl_decor_add(l, 1, (irandom_range(1, 100) > 5 ? (fn_object_exists(obj_actor_user) == true ? obj_actor_user.dir[obj_actor_user.DIR_DN].spr : spr_user_dir_dn) : spr_actor_macaco_monkey));
		for (var a = 0; a < 3; a++)
			fn_menu_lvl_label_add(l, a);
		fn_menu_lvl_label_icon_add(l, 1);
		// User levels
		for (var l = LVL_USER_EFFECT; l <= LVL_USER_THEME; l++)
		{
			lvl[l].data[0] = (l == LVL_USER_EFFECT ? global.user.effect : (l == LVL_USER_FUNC ? global.user.func : global.user.theme));
			fn_menu_lvl_panel_add(l, 0);
			fn_menu_lvl_panel_title_add(l, 0);
			for (var o = 0; o < 10; o++)
				fn_menu_lvl_option_add(l, o);
			fn_menu_lvl_label_add(l, 0);
			lvl[l].option_move.list.active = false;
			lvl[l].option_move.table.active = true;
		}
		break;
	}
}