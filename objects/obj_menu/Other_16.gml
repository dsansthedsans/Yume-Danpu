/// @descr Option confirmation results
// Disable the confirmation sound by modifying the variable _confirm_snd to undefined
var l = lvl_curr;
var o = lvl[l].option_curr;
switch (object_index)
{
	/* Main menu */
	case obj_menu_home:
	{
		if (l == LVL_LANG) // Languages level
		{
			global.config.lang_hasChosen = true;
			fn_config_file_save();
			fn_menu_lvl_fader_start(LVL_MAIN, , , , 120);
		}
		else if (l == LVL_MAIN) // Main level
		{
			if (o == 0)
			{
				fn_menu_lvl_fader_start(LVL_EMPTY);
				fn_fader_obj_create();
			}
			else if (o == 1)
			{
				fn_menu_lvl_fader_start(LVL_EMPTY);
				fn_object_create(obj_menu_config);
			}
			else if (o == 2)
				fn_menu_lvl_fader_start(LVL_EMPTY, , , true, 90, snd_fader_portal);
		}
		break;
	}
	
	/* Settings menu */
	case obj_menu_config:
	{
		var l = lvl_curr;
		var o = lvl[l].option_curr;
		if (l == LVL_MAIN) // Main level
		{
			if (o == 0)
				_confirm_snd = undefined;
			else
				fn_menu_lvl_fader_start(o + 1);
		}
		break;
	}
	
	/* Inventory menu */
	case obj_menu_user:
	{
		var l = lvl_curr;
		var o = lvl[l].option_curr;
		if (l == LVL_MAIN) // Main level
		{
			// User levels
			if (o >= 0 && o <= 2)
				fn_menu_lvl_fader_start(LVL_USER_EFFECT + o);
		}
		if (l >= LVL_USER_EFFECT && l <= LVL_USER_THEME) // User levels
		{
			var _item = lvl[l].data[0];
			if (is_array(_item) == true && array_length(_item) > o && array_get(_item, o).unlocked == true)
			{
				_confirm_snd = global.user.theme[global.user.theme_curr].audio.equip;
				// Functions level
				if (l == LVL_USER_FUNC)
					global.user.func_curr = (o != global.user.func_curr ? o : undefined);
				// Themes level
				if (l == LVL_USER_THEME)
					global.user.theme_curr = (o != global.user.theme_curr ? o : USER_THEME.DFLT);
				// Functions and themes levels
				if (l == LVL_USER_FUNC && global.user.func_curr == undefined) || (l == LVL_USER_THEME && o != global.user.theme_curr && global.user.theme_curr == USER_THEME.DFLT)
					_confirm_snd = global.user.theme[global.user.theme_curr].audio.unequip;
			}
			else
				_confirm_snd = global.user.theme[global.user.theme_curr].audio.error;
		}
		break;
	}
}