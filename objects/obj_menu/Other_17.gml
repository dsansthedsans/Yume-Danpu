/// @descr Option cancellation results
// Disable the cancellation sound by modifying the variable _cancel_snd to undefined
var l = lvl_curr;
switch (object_index)
{
	/* Settings menu */
	case obj_menu_config:
	{
		if (l == LVL_MAIN) // Main level
		{
			fn_menu_lvl_fader_start(LVL_EMPTY);
			with (obj_menu_home)
				fn_menu_lvl_fader_start(LVL_MAIN);
		}
		else if (l >= LVL_VIDEO && l <= LVL_ACCESS) // Graphics, Music & Sounds and Accessibility levels
			fn_menu_lvl_fader_start(LVL_MAIN);
		break;
	}
	
	/* Inventory menu */
	case obj_menu_user:
	{
		if (l == LVL_MAIN) // Main level
			fn_menu_lvl_fader_start(LVL_EMPTY, , true);
		else if (l >= LVL_USER_EFFECT && l <= LVL_USER_THEME) // User levels
			fn_menu_lvl_fader_start(LVL_MAIN)
		break;
	}
}