/// @descr Option confirm results
// Refer to {lvl[lvl_curr].option_curr} as {_opt_curr}
// Disable the confirmation sound by modifying the variable {_confirm_snd} to -1

if (lvl_curr == LVL_LANG)
{
	global.config.lang_hasChosen = true;
	fn_config_file_save();
	fn_menu_lvl_fader_start(LVL_MAIN, , , 120);
}
else if (lvl_curr == LVL_MAIN)
{
	if (_opt_curr == 0)
	{
		fn_menu_lvl_fader_start(LVL_EMPTY);
		fn_fader_obj_create();
	}
	else if (_opt_curr == 1)
	{
		fn_menu_lvl_fader_start(LVL_EMPTY);
		fn_obj_create(obj_menu_config);
	}
	else if (_opt_curr == 2)
	{
		fn_menu_lvl_fader_start(LVL_EMPTY);
	}
}
