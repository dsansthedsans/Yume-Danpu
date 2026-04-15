/// @descr Option confirm results

var l = lvl_curr;
var o = lvl[l].option_curr;
// Main level
if (l == LVL_MAIN)
{
	// User levels
	if (o >= 0 && o <= 2)
		fn_menu_lvl_fader_start(LVL_USER_EFF + o);
}
// User levels
if (l >= LVL_USER_EFF && l <= LVL_USER_THM)
{
	var _item = lvl[l].data[0];
	if (is_array(_item) == true && array_length(_item) > o && array_get(_item, o).unlocked == true)
	{
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.equip;
		// Functions level
		if (l == LVL_USER_FCN)
			global.user.fcn_curr = (o != global.user.fcn_curr ? o : undefined);
		// Themes level
		if (l == LVL_USER_THM)
			global.user.thm_curr = (o != global.user.thm_curr ? o : USER_THM.DFLT);
		// Functions and themes levels
		if (l == LVL_USER_FCN && global.user.fcn_curr == undefined) || (l == LVL_USER_THM && o != global.user.thm_curr && global.user.thm_curr == USER_THM.DFLT)
			_confirm_snd = global.user.thm[global.user.thm_curr].snd.unequip;
	}
	else
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.error;
}
	
	
	/*
	var _item = lvl[l].data[0];
	var _item_curr = lvl[l].data[1];
	if (is_array(_item) == true && array_length(_item) > _opt_curr && array_get(_item, _opt_curr).unlocked == true && struct_exists(global.user, _item_curr) == true)
	{
		struct_set(global.user, _item_curr, (_opt_curr != struct_get(global.user, _item_curr) ? _opt_curr : (l != LVL_USER_THM ? undefined : USER_THM.DFLT)));
		fn_config_file_save();
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.equip;
		if (struct_get(global.user, _item_curr) == (l != LVL_USER_THM ? undefined : USER_THM.DFLT))
			_confirm_snd = global.user.thm[global.user.thm_curr].snd.unequip;
	}
	*/
	
/*
variable_struct_set(global.user, d[1], (o != variable_struct_get(global.user, d[1]) ? o : (l != LVL_USER_THM ? undefined : USER_THM.DFLT)));
		_confirm_snd = variable_struct_get(global.user.thm[global.user.thm_curr].snd, );
*/

	/*
	var u = (l == LVL_USER_EFF ? global.user.eff : (l == LVL_USER_FCN ? global.user.fcn : global.user.thm));
	if (is_array(u) == true && o < array_length(u) && array_get(u, o).unlocked == true)
	{
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.equip;
		// Functions level
		if (l == LVL_USER_FCN)
			global.user.fcn_curr = (o != global.user.fcn_curr ? o : undefined);
		// Themes level
		if (l == LVL_USER_THM)	
			global.user.thm_curr = (o != global.user.thm_curr ? o : USER_THM.DFLT);
		// Effects, functions and themes levels
		if (o != global.user.thm_curr && global.user.thm_curr == USER_THM.DFLT)
			_confirm_snd = global.user.thm[global.user.thm_curr].snd.unequip;
	}
	else
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.error;
		*/

/*
var _item = (l == LVL_USER_EFF ? global.user.eff : (l == LVL_USER_FCN ? global.user.fcn : global.user.thm));
	//var _item_curr = (l == LVL_USER_EFF ? global.user.eff_curr : (l == LVL_USER_FCN ? global.user.fcn_curr : global.user.thm_curr));
	if (is_array(_item) == true && _opt_curr < array_length(_item) && array_get(_item, _opt_curr).unlocked == true)
	{
		if (l == LVL_USER
		switch (l)
		{
			// Effects level
			case LVL_USER_EFF:
				global.user.eff_curr = (global.user.eff_curr == undefined ? _opt_curr : undefined);
			// Functions level
		}
		////////////////
		switch (l)
		{
			// Effects level
			case LVL_USER_EFF:
				fn_user_eff_equip((global.user.eff_curr == undefined ? _opt_curr : undefined));
			// Functions level
			case LVL_USER_FCN:
				fn_user_fcn_equip((global.user.fcn_curr == undefined ? _opt_curr : undefined));
			// Themes level
			case LVL_USER_THM:
				fn_user_thm_equip((global.user.thm_curr == USER_THM.DFLT ? _opt_curr : USER_THM.DFLT));
		}
		////////////////////////////////
		if (_item_curr == undefined)
		{
			if (l == LVL_USER_EFF)
				fn_user_eff_equip(_opt_curr);
			else if (l == LVL_USER_FCN)
				fn_user_fcn_equip(_opt_curr);
			else
				fn_user_thm_equip(_opt_curr);
			_confirm_snd = global.user.thm[global.user.thm_curr].snd.equip;
		}
		else
		{
			if (l == LVL_USER_EFF)
				fn_user_eff_equip(undefined);
			else if (l == LVL_USER_FCN)
				fn_user_fcn_equip(undefined);
			else
				fn_user_thm_equip(USER_THM.DFLT);
			_confirm_snd = global.user.thm[global.user.thm_curr].snd.unequip;
		}
		////////////////
	}
	else
		_confirm_snd = global.user.thm[global.user.thm_curr].snd.error;
*/
