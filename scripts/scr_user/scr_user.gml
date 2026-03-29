
//////// Functions related to the user

function fn_user_setup(_file_curr = -1)
{
	global.user =
	{
		name : "Eleanor",
		awake : true,
		
		// Money
		money :
		[{ // While sleeping
			amt : 0,
			ccy : "₢$ "
		},
		{ // While awake
			amt : (choose(10, 20) + (choose(1, 3, 7, 9) * choose(-1, 1))),
			ccy : "R$ "
		}],
		
		// Effects
		eff : [-1],
		eff_amt : 0,
		eff_curr : -1, // Determines which effect is currently active (-1 == none)
		
		// Items
		fcn : [-1],
		fcn_amt : 0,
		fcn_curr : -1, // Determines which item is currently active (-1 == none)
		
		// Themes
		thm : [-1],
		thm_amt : 0,
		thm_curr : 0, // Determines which theme is currently active
		
		// Save files
		file : [-1],
		file_curr : _file_curr, // Determines which save file is currently active (-1 == none)
		file_amtMax : 3
	}
	
		// Effects
	enum USER_EFF
	{
		
	}
	
		// Functions
	enum USER_FCN
	{
		KART
	}
	fn_user_fcn_add(USER_FCN.KART, "kart");
	
		// Themes
	enum USER_THM
	{
		DFLT,	// Default theme
		SIMPLE, // Simple theme
		MADOT	// Madotsuki theme
	}
	fn_user_thm_add(USER_THM.DFLT, "dflt", true, #FFFFFF, #FFFFFF, #595959, #595959, c_black, c_black, 0); // Default theme
	fn_user_thm_add(USER_THM.SIMPLE, "simple", true, c_white, c_ltgray, c_gray, c_dkgray, -1, c_black, 0); // Simple theme
	fn_user_thm_add(USER_THM.MADOT, "madot", true, #DEB2E7, #9C619C, #7B5184, #420439, #290831, c_black, , 1, 1); // Madotsuki theme
	
		// Save files
	for (var f = 0; f < global.user.file_amtMax; f++)
	{
		global.user.file[f] =
		{
			name : $"{global.config.ver}/user_{f}.ini",
			msg : choose("I wonder why someone would come here. It wouldn't be to cheat, would it?", "Got bored of walking?", "Simon says turn all the zeros into ones.", "As long as you're having fun, right?", "At least you'll be playing the game.", "Viva la revolución!", "Just do what you gotta do.", "So many numbers... It's like a number world...", "Don't forget to save changes.", "Easy to change, huh?")
		}
	}
	if (global.user.file_curr != -1)
	{
		if (file_exists(global.user.file[global.user.file_curr].name) == false)
			fn_user_file_save();
		else
			fn_user_file_load();
	}
}

	// Effects
function fn_user_eff_add(_idx, _code, _unlocked = false)
{
	global.user.eff[_idx] =
	{
		name : $"user_eff_name_{_code}",
		desc : $"user_eff_desc_{_code}",
		code : _code,
		unlocked : _unlocked,
		icon_spr : spr_menu_inv_main_option_icon,
		icon_img : 0
	}
	global.user.eff_amt += 1;
}

	// Items
function fn_user_fcn_add(_idx, _code, _unlocked = false)
{
	global.user.fcn[_idx] =
	{
		name : $"user_fcn_name_{_code}",
		desc : $"user_fcn_desc_{_code}",
		code : _code,
		unlocked : _unlocked,
		icon_spr : spr_menu_inv_main_option_icon,
		icon_img : 1
	}
	global.user.fcn_amt += 1;
}
function fn_user_fcn_unlock(_idx)
{
	global.user.fcn[_idx].unlocked = true;
	fn_user_file_save();
		
	//fn_menu_obj_create("unlock", 1, global.user.fcn[_idx].name);
}
function fn_user_fcn_equip(_idx)
{
	if (_idx !=	-1)
	{
		global.user.fcn_curr = _idx;
		fn_user_file_save();
	}
}

	// Themes
function fn_user_thm_add(_idx, _code, _unlocked = false, _color_whiteLight, _color_whiteDark, _color_grayLight, _color_grayDark, _color_blackLight, _color_blackDark, _alpha_shadow = 1, _alpha_blurLight = 0.5, _alpha_blurHeavy = 0.75)
{
	global.user.thm[_idx] =
	{
		name : $"user_thm_name_{_code}",
		desc : $"user_thm_desc_{_code}",
		code : _code,
		unlocked : _unlocked,
		icon_spr : spr_menu_inv_main_option_icon,
		icon_img : 2,
		
		// Colors
		color :
		{
			whiteLight : _color_whiteLight,
			whiteDark : _color_whiteDark,
			grayLight : _color_grayLight,
			grayDark : _color_grayDark,
			blackLight : _color_blackLight,
			blackDark : _color_blackDark
		},
		
		// Alpha
		alpha :
		{
			shadow: _alpha_shadow,
			blurLight : _alpha_blurLight, // Alpha for lightly dimmed background
			blurHeavy : _alpha_blurHeavy // Alpha for heavily dimmed background
		},
		
		// Sprites
		spr :
		{
			panel : fn_user_thm_asset("spr_user_thm_panel_", _code),
			panel_title : fn_user_thm_asset("spr_user_thm_panel_title_", _code),
			card : fn_user_thm_asset("spr_user_thm_card_", _code),
			option_select : fn_user_thm_asset("spr_user_thm_option_select_", _code),
			option_button : fn_user_thm_asset("spr_user_thm_option_select_", _code),
			option_check : fn_user_thm_asset("spr_user_thm_option_check_", _code),
			option_check_mark : fn_user_thm_asset("spr_user_thm_option_check_mark_", _code),
			picFrame : fn_user_thm_asset("spr_user_thm_picFrame_", _code),
		},
		
		snd : // Sounds
		{
			start : fn_user_thm_asset("snd_user_thm_start_", _code),
			move : fn_user_thm_asset("snd_user_thm_move_", _code),
			confirm : fn_user_thm_asset("snd_user_thm_confirm_", _code),
			cancel : fn_user_thm_asset("snd_user_thm_cancel_", _code),
			error : fn_user_thm_asset("snd_user_thm_error_", _code),
			unlock : [fn_user_thm_asset($"snd_user_thm_unlock_0_", _code), fn_user_thm_asset($"snd_user_thm_unlock_1_", _code), fn_user_thm_asset("snd_user_thm_unlock_2_", _code)],
			equip : [fn_user_thm_asset("snd_user_thm_equip_0_", _code), fn_user_thm_asset("snd_user_thm_equip_1_", _code)],
		}
	}
	global.user.thm_amt += 1;
}
function fn_user_thm_asset(_asset_name_noCode, _code)
{
	var _asset = asset_get_index($"{_asset_name_noCode}{_code}");
	if (_asset == -1)
		_asset = asset_get_index($"{_asset_name_noCode}{global.user.thm[0].code}");
	return _asset;
}
function fn_user_thm_equip(_idx)
{
	if (_idx != -1)
	{
		global.user.thm_curr = _idx;
		fn_user_file_save();
	}
}

	// Save files
function fn_user_file_save()
{
	var _file = global.user.file[global.user.file_curr];	
	ini_open(_file.name);
	ini_write_string("about", "ver", global.config.ver);
	ini_write_string("about", "msg", _file.msg);
	ini_write_string("main", "name", global.user.name);
	for (var m = 0; m < 2; m++)
		ini_write_string("money", $"amt_{m}", global.user.money[m].amt);
	for (var e = 0; e < global.user.eff_amt; e++)
		ini_write_string("eff", $"unlocked_{e}", global.user.eff[e].unlocked);
	for (var e = 0; e < global.user.fcn_amt; e++)
		ini_write_string("fcn", $"unlocked_{e}", global.user.fcn[e].unlocked);
	for (var e = 0; e < global.user.thm_amt; e++)
		ini_write_string("thm", $"unlocked_{e}", global.user.thm[e].unlocked);
	ini_write_string("thm", "curr", global.user.thm_curr);
	ini_close();
}
function fn_user_file_load()
{
	var _idx = global.user.file_curr;
	ini_open(global.user.file[_idx].name);
	if (ini_read_real("about", "ver", -1) == global.user.file[_idx].ver)
	{
		global.user.name = ini_read_string("main", "name", "Salenis");
		for (var m = 0; m < 2; m++)
			global.user.money[m].amt = real(ini_read_string("money", $"amt_{m}", "0"));
		for (var e = 0; e < global.user.eff_amt; e++)
			global.user.eff[e].unlocked = real(ini_read_string("eff", $"unlocked_{e}", "0"));
		for (var e = 0; e < global.user.fcn_amt; e++)
			global.user.fcn[e].unlocked = real(ini_read_string("fcn", $"unlocked_{e}", "0"));
		for (var e = 0; e < global.user.thm_amt; e++)
			global.user.thm[e].unlocked = real(ini_read_string("thm", $"unlocked_{e}", "0"));
		global.user.thm_curr = real(ini_read_string("thm", "curr", "0"));
	}
	ini_close();
}
function fn_user_file_erase(_idx)
{
	file_delete(global.user.file[_idx].name);
}