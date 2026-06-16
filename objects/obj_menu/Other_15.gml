/// @descr Option movement results
// Disable sound effect by modifying the variable _move_snd to undefined
switch (object_index)
{
	/* Main menu */
	case obj_menu_home:
	{
		var l = lvl_curr;
		var o = lvl[l].option_curr;
		if (l == LVL_LANG)
			fn_config_lang_mod(o);
		break;
	}
}
