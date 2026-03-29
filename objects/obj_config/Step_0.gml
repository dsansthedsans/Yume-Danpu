
// Video/Graphics
	// Toggles Fullscreen on/off
if (fn_config_key_pressed(CONFIG_KEY.FSCR) == true)
{
	global.config.video.fscr.act = !global.config.video.fscr.act;
	fn_config_file_save();
}
if (fscr_wait <= 0) 
{
	if (fscr_act != global.config.video.fscr.act)
	{
		window_set_fullscreen(global.config.video.fscr.act);
		fscr_act = global.config.video.fscr.act;
		fscr_wait = fscr_waitMax;
	}
}
else
	fscr_wait -= 1
	// Toggles Vsync on/off
if (vsync_act != global.config.video.vsync.act)
{
	display_reset(0, global.config.video.vsync.act)
	vsync_act = global.config.video.vsync.act;
}
	// Toggles Hide Cursor on/off
if (hideCsr_act != global.config.video.hideCsr.act)
{
	window_set_cursor(cr_default);
	if (global.config.video.hideCsr.act == true)
		window_set_cursor(cr_none);
	hideCsr_act = global.config.video.hideCsr.act;
}


