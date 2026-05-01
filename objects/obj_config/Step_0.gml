
// Graphics
	// Resolution
if (resolution_wait <= 0) 
{
	if (resolution_curr != global.config.video.resolution_curr)
	{
		window_set_size(global.config.video.resolution[global.config.video.resolution_curr].width, global.config.video.resolution[global.config.video.resolution_curr].height);
		window_center();
		resolution_curr = global.config.video.resolution_curr;
		resolution_wait = resolution_waitMax;
	}
}
else
	resolution_wait -= 1;
	// Fullscreen
if (fn_config_key_pressed(CONFIG_KEY.FULLSCREEN) == true)
{
	global.config.video.fullscreen.active = !global.config.video.fullscreen.active;
	fn_config_file_save();
}
if (fullscreen_wait <= 0) 
{
	if (fullscreen_act != global.config.video.fullscreen.active)
	{
		window_set_fullscreen(global.config.video.fullscreen.active);
		if (global.config.video.fullscreen.active == false)
			resolution_curr = undefined;
		fullscreen_act = global.config.video.fullscreen.active;
		fullscreen_wait = fullscreen_waitMax;
	}
}
else
	fullscreen_wait -= 1
	// Vsync
if (vsync_act != global.config.video.vsync.active)
{
	display_reset(0, global.config.video.vsync.active)
	vsync_act = global.config.video.vsync.active;
}
	// Hide Cursor
if (hideCursor_act != global.config.video.hideCursor.active)
{
	window_set_cursor(cr_default);
	if (global.config.video.hideCursor.active == true)
		window_set_cursor(cr_none);
	hideCursor_act = global.config.video.hideCursor.active;
}


