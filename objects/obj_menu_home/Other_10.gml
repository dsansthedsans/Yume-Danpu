/// @descr Option confirm results

var l = lvl_curr;
var o = lvl[l].option_curr;
if (l == LVL_LANG)
{
	global.config.lang_hasChosen = true;
	fn_config_file_save();
	fn_menu_lvl_fader_start(LVL_MAIN, , , , 120);
}
else if (l == LVL_MAIN)
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
