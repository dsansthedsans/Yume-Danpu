/// @descr Option confirm results

// Main level
if (lvl_curr == LVL_MAIN)
{
	// User levels
	if (_opt_curr >= 0 && _opt_curr <= 2)
		fn_menu_lvl_fader_start(LVL_USER_EFF + _opt_curr);
}
// User levels
if (lvl_curr >= LVL_USER_EFF && lvl_curr <= LVL_USER_THM)
{
	var _user_item = (lvl_curr == LVL_USER_EFF ? global.user.eff : (lvl_curr == LVL_USER_FCN ? global.user.fcn : global.user.thm));
	if (is_array(_user_item) == true && _opt_curr < array_length(_user_item) && array_get(_user_item, _opt_curr).unlocked == true)
	{
		
	}
	else
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.error;
}
	
