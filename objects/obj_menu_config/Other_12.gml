/// @descr Option's value cycle result

var l = lvl_curr;
var o = lvl[l].option_curr;
if (l == LVL_MAIN && o == 0)
{
	var _lang_curr = (global.config.lang_curr + _cycle_sign);
	if (_lang_curr < 0)
		_lang_curr = (array_length(global.config.lang) - 1);
	if (_lang_curr >= array_length(global.config.lang))
		_lang_curr = 0;
	fn_config_lang_mod(_lang_curr);
}
else if (l == LVL_VIDEO)
{
	if (o == 0)
	{
		global.config.video.resolution_curr += _cycle_sign;
		if (global.config.video.resolution_curr < 0)
			global.config.video.resolution_curr = (array_length(global.config.video.resolution) - 1);
		if (global.config.video.resolution_curr >= array_length(global.config.video.resolution))
			global.config.video.resolution_curr = 0;
	}
	else if (o == 1)
		global.config.video.fullscreen.active = !global.config.video.fullscreen.active;
	else if (o == 2)
		global.config.video.vsync.active = !global.config.video.vsync.active;
	else if (o == 3)
		global.config.video.hideCursor.active = !global.config.video.hideCursor.active;
	else if (o == 4)
		global.config.video.showVer.active = !global.config.video.showVer.active;
	else if (o == 5)
		global.config.video.showBdr.active = !global.config.video.showBdr.active;
	else if (o == 6)
		global.config.video.showFps.active = !global.config.video.showFps.active;
	fn_config_file_save();
}
else if (l == LVL_AUDIO)
{
	global.config.audio.emitter[o].volume = clamp((global.config.audio.emitter[o].volume + (0.1 * _cycle_sign)), 0, 1);
	fn_config_file_save();
}
else if (l == LVL_ACCESS)
{
	if (o == 0)
	{
		global.config.access.reduceMotion.active = !global.config.access.reduceMotion.active;
		fn_config_file_save();
	}
}