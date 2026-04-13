/// @descr Option cancel results

// Main level
if (lvl_curr == LVL_MAIN)
	fn_menu_lvl_fader_start(LVL_EMPTY, , true);
// User levels
else if (lvl_curr >= LVL_USER_EFF && lvl_curr <= LVL_USER_THM)
	fn_menu_lvl_fader_start(LVL_MAIN)
