/// @descr Option cancel results

var l = lvl_curr;
var o = lvl[l].option_curr;
// Main level
if (l == LVL_MAIN)
{
	fn_menu_lvl_fader_start(LVL_EMPTY);
	with (obj_menu_home)
		fn_menu_lvl_fader_start(LVL_MAIN);
}
// Graphics, Music & Sounds and Accessibility levels
else if (l >= LVL_VIDEO && l <= LVL_ACCESS)
	fn_menu_lvl_fader_start(LVL_MAIN);
