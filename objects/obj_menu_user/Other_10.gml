/// @descr Option confirm results

var l = lvl_curr;
var o = lvl[l].option_curr;
// Main level
if (l == LVL_MAIN)
{
	// User levels
	if (o >= 0 && o <= 2)
		fn_menu_lvl_fader_start(LVL_USER_EFFECT + o);
}
// User levels
if (l >= LVL_USER_EFFECT && l <= LVL_USER_THEME)
{
	var _item = lvl[l].data[0];
	if (is_array(_item) == true && array_length(_item) > o && array_get(_item, o).unlocked == true)
	{
		_confirm_snd = global.user.theme[global.user.theme_curr].audio.equip;
		// Functions level
		if (l == LVL_USER_FUNC)
			global.user.func_curr = (o != global.user.func_curr ? o : undefined);
		// Themes level
		if (l == LVL_USER_THEME)
			global.user.theme_curr = (o != global.user.theme_curr ? o : USER_THEME.DFLT);
		// Functions and themes levels
		if (l == LVL_USER_FUNC && global.user.func_curr == undefined) || (l == LVL_USER_THEME && o != global.user.theme_curr && global.user.theme_curr == USER_THEME.DFLT)
			_confirm_snd = global.user.theme[global.user.theme_curr].audio.unequip;
	}
	else
		_confirm_snd = global.user.theme[global.user.theme_curr].audio.error;
}
