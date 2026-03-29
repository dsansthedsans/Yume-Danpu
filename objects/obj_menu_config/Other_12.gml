/// @descr Option's value cycle result
// Refer to {lvl[lvl_curr].option_curr} as {_opt_curr}
// Refer to the sign of the option's value cycle as {_cycle_sign}

if (lvl_curr == LVL_MAIN && _opt_curr == 0)
{
	var _lang_curr = (global.config.lang_curr + _cycle_sign);
	if (_lang_curr < 0)
		_lang_curr = (array_length(global.config.lang) - 1);
	if (_lang_curr >= array_length(global.config.lang))
		_lang_curr = 0;
	fn_config_lang_mod(_lang_curr);
}
else if (lvl_curr == LVL_VID)
{
	switch (_opt_curr)
	{
		case 0:
			global.config.video.fscr.act = !global.config.video.fscr.act;
			break;
		case 1:
			global.config.video.vsync.act = !global.config.video.vsync.act;
			break;
		case 2:
			global.config.video.hideCsr.act = !global.config.video.hideCsr.act;
			break;
		case 3:
			global.config.video.showVer.act = !global.config.video.showVer.act;
			break;
		case 4:
			global.config.video.showBdr.act = !global.config.video.showBdr.act;
			break;
		case 5:
			global.config.video.showFps.act = !global.config.video.showFps.act;
			break;
	}

	fn_config_file_save();
}
else if (lvl_curr == LVL_AUD)
{
	global.config.aud.emtr[_opt_curr].vol = clamp((global.config.aud.emtr[_opt_curr].vol + (0.1 * _cycle_sign)), 0, 1);
	fn_config_file_save();
}
else if (lvl_curr == LVL_ACCESS)
{
	if (_opt_curr == 0)
	{
		global.config.access.rdcdMot.act = !global.config.access.rdcdMot.act;
		fn_config_file_save();
	}
}