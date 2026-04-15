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
		global.config.video.res_curr += _cycle_sign;
		if (global.config.video.res_curr < 0)
			global.config.video.res_curr = (array_length(global.config.video.res) - 1);
		if (global.config.video.res_curr >= array_length(global.config.video.res))
			global.config.video.res_curr = 0;
	}
	else if (o == 1)
		global.config.video.fscr.act = !global.config.video.fscr.act;
	else if (o == 2)
		global.config.video.vsync.act = !global.config.video.vsync.act;
	else if (o == 3)
		global.config.video.hideCsr.act = !global.config.video.hideCsr.act;
	else if (o == 4)
		global.config.video.showVer.act = !global.config.video.showVer.act;
	else if (o == 5)
		global.config.video.showBdr.act = !global.config.video.showBdr.act;
	else if (o == 6)
		global.config.video.showFps.act = !global.config.video.showFps.act;
	fn_config_file_save();
}
else if (l == LVL_AUD)
{
	global.config.aud.emtr[o].vol = clamp((global.config.aud.emtr[o].vol + (0.1 * _cycle_sign)), 0, 1);
	fn_config_file_save();
}
else if (l == LVL_ACCESS)
{
	if (o == 0)
	{
		global.config.access.rdcdMot.act = !global.config.access.rdcdMot.act;
		fn_config_file_save();
	}
}