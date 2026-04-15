/// @descr Option confirm results

var l = lvl_curr;
var o = lvl[l].option_curr;
// Main level
if (l == LVL_MAIN)
{
	if (o == 0)
		_confirm_snd = undefined;
	else
		fn_menu_lvl_fader_start(o + 1);
}
