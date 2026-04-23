
//////// Functions related to the user

function fn_user_setup(_file_curr = undefined)
{
	global.user =
	{
		name : "Eleanor",
		asleep : false,
		
		// Money
		money :
		{
			amt : [(choose(10, 20) + (choose(1, 3, 7, 9) * choose(-1, 1))), 0],
			ccy : ["R$ ", "₢$ "],
		},
		// Effects
		eff : undefined,
		eff_curr : undefined, // Determines which effect is currently active (undefined == none)
		// Items
		fcn : undefined,
		fcn_curr : undefined, // Determines which item is currently active (undefined == none)
		// Themes
		thm : undefined,
		thm_curr : 0, // Determines which theme is currently active
		// Save files
		file : undefined,
		file_curr : _file_curr, // Determines which save file is currently active (undefined == none)
		file_lengthMax : 3,
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
	fn_user_fcn_add(USER_FCN.KART, "kart", true);
		// Themes
	enum USER_THM
	{
		DFLT,	// Default theme
		MADOT,	// Madotsuki theme
	}
	fn_user_thm_add(USER_THM.DFLT, "dflt", true, #FFFFFF, #FFFFFF, #595959, #595959, c_black, c_black); // Default theme
	global.user.thm[USER_THM.DFLT].alpha.shadow = 0;
	global.user.thm[USER_THM.DFLT].alpha.panel_title_label = 0.5;
	fn_user_thm_add(USER_THM.MADOT, "madot", true, #DEB2E7, #9C619C, #7B5184, #420439, #290831, #290831); // Madotsuki theme
	
	// Save files
	for (var f = 0; f < global.user.file_lengthMax; f++)
	{
		global.user.file[f] =
		{
			name : $"{global.config.ver}/user_{f}.ini",
			msg : choose("I wonder why someone would come here. It wouldn't be to cheat, would it?" /*Reference to Telltale's The Walking Dead (2012)*/, "Got bored of walking?", "Simon says turn all the zeros into ones.", "As long as you're having fun, right?", "At least you'll be playing the game.", "Viva la revolución!", "Just do what you gotta do.", "So many numbers... It's like a number world..." /*Reference to Yume Nikki*/, "Don't forget to save changes.", "Was it really that boring...?"),
		}
	}
	if (global.user.file_curr != undefined)
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
		icon_spr : spr_menu_user_main_option_icon,
		icon_img : 0
	}
}
	// Functions
function fn_user_fcn_add(_idx, _code, _unlocked = false)
{
	global.user.fcn[_idx] =
	{
		name : $"user_fcn_name_{_code}",
		desc : $"user_fcn_desc_{_code}",
		code : _code,
		unlocked : _unlocked,
		icon_spr : spr_menu_user_main_option_icon,
		icon_img : 1
	}
}
function fn_user_fcn_unlock(_idx)
{
	global.user.fcn[_idx].unlocked = true;
	fn_user_file_save();
		
	//fn_menu_obj_create("unlock", 1, global.user.fcn[_idx].name);
}
	// Themes
function fn_user_thm_add(_idx, _code, _unlocked = false, _color_whiteLight, _color_whiteDark, _color_grayLight, _color_grayDark, _color_blackLight, _color_blackDark)
{
	global.user.thm[_idx] =
	{
		name : $"user_thm_name_{_code}",
		desc : $"user_thm_desc_{_code}",
		code : _code,
		unlocked : _unlocked,
		icon_spr : spr_menu_user_main_option_icon,
		icon_img : 2,
		// Colors
		color :
		{
			whiteLight : _color_whiteLight,
			whiteDark : _color_whiteDark,
			grayLight : _color_grayLight,
			grayDark : _color_grayDark,
			blackLight : _color_blackLight,
			blackDark : _color_blackDark,
		},
		// Alpha
		alpha :
		{
			shadow: 1,
			blurLight : 0.5, // Alpha for lightly dimmed background
			blurHeavy : 0.75, // Alpha for heavily dimmed background
			panel_title_label : 1,
		},
		// Sprites
		spr :
		{
			train : fn_user_thm_asset("spr_user_thm_train_", _code),
			panel : fn_user_thm_asset("spr_user_thm_panel_", _code),
			panel_title : fn_user_thm_asset("spr_user_thm_panel_title_", _code),
			card : fn_user_thm_asset("spr_user_thm_card_", _code),
			option_select : fn_user_thm_asset("spr_user_thm_option_select_", _code),
			option_button : fn_user_thm_asset("spr_user_thm_option_select_", _code),
			option_check : fn_user_thm_asset("spr_user_thm_option_check_", _code),
			option_check_mark : fn_user_thm_asset("spr_user_thm_option_check_mark_", _code),
			picFrame : fn_user_thm_asset("spr_user_thm_picFrame_", _code),
		},
		// Sounds
		snd : 
		{
			start : fn_user_thm_asset("snd_user_thm_start_", _code),
			move : fn_user_thm_asset("snd_user_thm_move_", _code),
			confirm : fn_user_thm_asset("snd_user_thm_confirm_", _code),
			cancel : fn_user_thm_asset("snd_user_thm_cancel_", _code),
			error : fn_user_thm_asset("snd_user_thm_error_", _code),
			unlock : [fn_user_thm_asset($"snd_user_thm_unlock_0_", _code), fn_user_thm_asset($"snd_user_thm_unlock_1_", _code), fn_user_thm_asset("snd_user_thm_unlock_2_", _code)],
			equip : fn_user_thm_asset("snd_user_thm_equip_", _code),
			unequip : fn_user_thm_asset("snd_user_thm_unequip_", _code),
		}
	}
}
function fn_user_thm_asset(_asset_name_noCode, _code)
{
	var _asset_name = $"{_asset_name_noCode}{_code}";
	fn_log(_asset_name);
	var _asset = asset_get_index(_asset_name);
	if (_asset == -1)
		_asset = asset_get_index($"{_asset_name_noCode}{global.user.thm[0].code}");
	return _asset;
}
	// Save files
function fn_user_file_save()
{
	var _file = global.user.file[global.user.file_curr];	
	ini_open(_file.name);
	ini_write_string("about", "msg", _file.msg);
	ini_write_string("main", "name", global.user.name);
	for (var m = 0; m < array_length(global.user.money.amt); m++)
		ini_write_string("money", $"amt_{m}", global.user.money.amt[m]);
	for (var e = 0; e < array_length(global.user.eff); e++)
		ini_write_string("eff", $"unlocked_{e}", global.user.eff[e].unlocked);
	for (var f = 0; f < array_length(global.user.fcn); f++)
		ini_write_string("fcn", $"unlocked_{e}", global.user.fcn[f].unlocked);
	for (var t = 0; t < array_length(global.user.thm); t++)
		ini_write_string("thm", $"unlocked_{t}", global.user.thm[t].unlocked);
	ini_write_string("thm", "curr", global.user.thm_curr);
	ini_close();
}
function fn_user_file_load()
{
	var _idx = global.user.file_curr;
	ini_open(global.user.file[_idx].name);
	global.user.name = ini_read_string("main", "name", "Salenis");
	for (var m = 0; m < array_length(global.user.money.amt); m++)
		global.user.money.amt[m] = real(ini_read_string("money", $"amt_{m}", "0"));
	for (var e = 0; e < array_length(global.user.eff); e++)
		global.user.eff[e].unlocked = real(ini_read_string("eff", $"unlocked_{e}", "0"));
	for (var e = 0; e < array_length(global.user.fcn); e++)
		global.user.fcn[e].unlocked = real(ini_read_string("fcn", $"unlocked_{e}", "0"));
	for (var e = 0; e < array_length(global.user.thm); e++)
		global.user.thm[e].unlocked = real(ini_read_string("thm", $"unlocked_{e}", "0"));
	global.user.thm_curr = real(ini_read_string("thm", "curr", "0"));
	ini_close();
}
function fn_user_file_erase(_idx)
{
	file_delete(global.user.file[_idx].name);
}