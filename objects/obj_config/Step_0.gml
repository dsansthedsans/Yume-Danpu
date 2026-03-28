
// Video/Graphics
	// Toggles Fullscreen on/off
if (fn_config_key_pressed(CONFIG_KEY.FSCR) == true)
{
	global.config.vid.fscr.act = !global.config.vid.fscr.act;
	fn_config_file_save();
}
if (fscr_wait <= 0) 
{
	if (fscr_act != global.config.vid.fscr.act)
	{
		window_set_fullscreen(global.config.vid.fscr.act);
		fscr_act = global.config.vid.fscr.act;
		fscr_wait = fscr_waitMax;
	}
}
else
	fscr_wait -= 1
	// Toggles Vsync on/off
if (vsync_act != global.config.vid.vsync.act)
{
	display_reset(0, global.config.vid.vsync.act)
	vsync_act = global.config.vid.vsync.act;
}
	// Toggles Hide Cursor on/off
if (hideCsr_act != global.config.vid.hideCsr.act)
{
	window_set_cursor(cr_default);
	if (global.config.vid.hideCsr.act == true)
		window_set_cursor(cr_none);
	hideCsr_act = global.config.vid.hideCsr.act;
}


