
// Graphics
	// Resolution
if (res_wait <= 0) 
{
	if (res_curr != global.config.video.res_curr)
	{
		window_set_size(global.config.video.res[global.config.video.res_curr].width, global.config.video.res[global.config.video.res_curr].height);
		window_center();
		res_curr = global.config.video.res_curr;
		res_wait = res_waitMax;
	}
}
else
	res_wait -= 1;
	// Fullscreen
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
		if (global.config.video.fscr.act == false)
			res_curr = undefined;
		fscr_act = global.config.video.fscr.act;
		fscr_wait = fscr_waitMax;
	}
}
else
	fscr_wait -= 1
	// Vsync
if (vsync_act != global.config.video.vsync.act)
{
	display_reset(0, global.config.video.vsync.act)
	vsync_act = global.config.video.vsync.act;
}
	// Hide Cursor
if (hideCsr_act != global.config.video.hideCsr.act)
{
	window_set_cursor(cr_default);
	if (global.config.video.hideCsr.act == true)
		window_set_cursor(cr_none);
	hideCsr_act = global.config.video.hideCsr.act;
}


