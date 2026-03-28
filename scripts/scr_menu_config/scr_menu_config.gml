
//////// Functions related to the settings menu


// Functions related to setting up the menu
function fn_menu_config_evCreate_0()
{
	// Main level [#0]
	LVL_MAIN = 0;
	var l = LVL_MAIN;
	
		// Title
	fn_menu_ttl_add(l, fn_config_lang_data_getText("menu_config_main_ttl"));
	
	
	
	
	// All levels [#0]
	for (var l = 0; l < lvl_lenMax; l++)
	{
		// Dark translucent background
		fn_menu_rect_add(l, 0, 0, 0, 320, 240, global.user.thm[global.user.thm_curr].col.blur, 0.75);
		
		// Box
		var _box_xMargin = (draw_dist * 4);
		var _box_yMargin = (draw_dist * 3);
		if (l != LVL_MAIN)
		{
			_box_xMargin = (draw_dist * 2);
			_box_yMargin = _box_xMargin;
		}
		
		var _box_x = _box_xMargin;
		var _box_y = (ttl_box_y[l] + ttl_box_h[l] + _box_yMargin);
		var _box_w = (320 - (_box_x * 2));
		var _box_h = (240 - _box_y - _box_yMargin);
		fn_menu_box_add(l, 0, _box_x, _box_y, _box_w, _box_h);
	}
	
	
	
	
	// Main level [#1]
	var l = LVL_MAIN;
	
		// Options
	fn_menu_opt_add_ext(l, "menu_config_main_opt_");
	
	var _opt_yDist_0 = (draw_dist * 1.5);
	var _opt_yDist_1 = draw_dist;
	
	var _opt_hAll = _opt_yDist_0;
	for (var o = 1; o < (opt_len[l] - 1); o++)
		_opt_hAll += _opt_yDist_1;
	_opt_hAll += global.game.fnt_h;
	
	var _opt_yAdd = 0;
	for (var o = 0; o < opt_len[l]; o++)
	{	
		if (o == 0)
			opt_x[l, o] = (box_x[l, 0] + draw_dist);
		else if (o >= 1)
			opt_x[l, o] = (box_x[l, 0] + (box_w[l, 0] / 2) - (opt_w[l, o] / 2));
		
		opt_y[l, o] = (box_y[l, 0] + (box_h[l, 0] / 2) - (_opt_hAll / 2) + _opt_yAdd);
		fn_menu_opt_slctr_add(l, o); // Option selector
		
		if (o == 0)
			_opt_yAdd += _opt_yDist_0;
		else
			_opt_yAdd += _opt_yDist_1;
	}
	
			// Options' settings
	var _opt_config_xDist = (draw_dist * 2);
	var _opt_config_x = (opt_x[l, 0] + opt_w[l, 0] + _opt_config_xDist);
	var _opt_config_y = opt_y[l, 0];
	fn_menu_opt_config_add(l, 0, "Salenis", _opt_config_x, _opt_config_y);
	fn_menu_opt_config_slctr_add(l, 0); // Selector of the option's setting
	
	
	
	
	// Graphics level
	LVL_GFX = 3;
	var l = LVL_GFX;
	
		// Title
	fn_menu_ttl_add(l, fn_config_lang_data_getText("menu_config_gfx_ttl"));
	
		// Options
	fn_menu_opt_add_ext(l, "menu_config_gfx_opt_");
	
	
	
	
	// Music & Sounds level
	LVL_AUD = 4;
	var l = LVL_AUD;
	
		// Title
	fn_menu_ttl_add(l, fn_config_lang_data_getText("menu_config_aud_ttl"));
	
		// Options
	fn_menu_opt_add_ext(l, "menu_config_aud_opt_");
	
	
	
	
	// Accessibility
	LVL_A11Y = 5;
	var l = LVL_A11Y;
	
		// Title
	fn_menu_ttl_add(l, fn_config_lang_data_getText("menu_config_a11y_ttl"));
	
		// Options
	fn_menu_opt_add_ext(l, "menu_config_a11y_opt_");
	
	
	
	// All levels [#1]
	for (var l = 0; l < lvl_lenMax; l++)
	{
		// Options and their settings
		for (var o = 0; o < opt_len[l]; o++)
		{
			if (opt_x[l, o] == 0 && opt_y[l, o] == 0)
			{
				// Option
				opt_x[l, o] = (box_x[l, 0] + draw_dist);
				opt_y[l, o] = (box_y[l, 0] + draw_dist + (draw_dist * o));
				fn_menu_opt_slctr_add(l, o);
				
					// Option's setting
				var _opt_config_x = (box_x[l, 0] + round(box_w[l, 0] / 1.75));
				var _opt_config_y = opt_y[l, o];
				fn_menu_opt_config_add(l, o, "", _opt_config_x, _opt_config_y);
				fn_menu_opt_config_slctr_add(l, o); // Selector of the option's setting
			}
		}
	}
}
function fn_menu_config_evCreate_1()
{
	// Main level
	lvl = LVL_MAIN;
}


// Functions related to the options
function fn_menu_config_opt_slct()
{
	var l = lvl;
	var o = opt_move_pos[l];
	
	// Main level
	if (l == LVL_MAIN)
	{
		// "Graphics"
		if (o == 1)
			fn_menu_lvlNew(LVL_GFX);
		
		// "Music & Sounds"
		if (o == 2)
			fn_menu_lvlNew(LVL_AUD);
			
		// "Music & Sounds"
		if (o == 3)
			fn_menu_lvlNew(LVL_A11Y);
	}
}
function fn_menu_config_opt_cncl()
{
	var l = lvl;
	
	// Main level
	if (l == LVL_MAIN)
	{
		fn_menu_lvlNew(LVL_EMPTY, , true);
		
		var _menu_home_obj = fn_menu_obj_find("home");
		if (_menu_home_obj != -1)
		{
			with (_menu_home_obj)
				fn_menu_lvlNew(LVL_MAIN);
		}
		
		var _menu_pse_obj = fn_menu_obj_find("pse");
		if (_menu_pse_obj != -1)
		{
			with (_menu_pse_obj)
				fn_menu_lvlNew(LVL_MAIN);
		}
	}
	
	// Graphics level
	if (l == LVL_GFX) || (l == LVL_AUD) || (l == LVL_A11Y)
		fn_menu_lvlNew(LVL_MAIN);
}

function fn_menu_config_opt_config_move()
{
	if (press_lt == true) || (press_rt == true)
	{
		var l = lvl;
		var o = opt_move_pos[l];
		
		// Main level
		if (l == LVL_MAIN)
		{
			// "Language"
			if (o == 0)
			{
				var _config_lang = global.config_langCurr;
				var _config_langOld = _config_lang;
				
				_config_lang += (press_rt - press_lt);
				if (_config_lang < 0)
					_config_lang = (global.config_lang_len - 1);
				if (_config_lang >= global.config_lang_len)
					_config_lang = 0;
			
				if (_config_langOld != _config_lang)
					fn_config_lang_mod(_config_lang);
			}
		}
		
		// Graphics level
		else if (l == LVL_GFX)
		{
			// "Fullscreen"
			if (o == 0)
				global.config_fscr = !global.config_fscr;
			
			// "Low Graphics"
			if (o == 1)
				global.config_lowGfx = !global.config_lowGfx;
			
			// "Hide Cursor"
			if (o == 2)
				global.config_hideCsr = !global.config_hideCsr;
			
			// "Show FPS"
			if (o == 3)
				global.config_showFps = !global.config_showFps;
			
			// "Show Border"
			if (o == 4)
				global.config_showBdr = !global.config_showBdr;
			
			// "Show Version"
			if (o == 5)
				global.config_showVer = !global.config_showVer;
		}
		
		// Music & Sounds level
		else if (l == LVL_AUD)
		{
			var _volType = global.CONFIG_AUD_EMTR[o].vol;
			
			// Volumes
			_volType += ((press_rt - press_lt) * 0.1);
			if (_volType < 0)
				_volType = 1;
			else if (_volType > 1)
				_volType = 0;
			
			global.CONFIG_AUD_EMTR[o].vol = _volType;
		}
		
		// Accessibility level
		else if (l == LVL_A11Y)
		{
			// "Reduced Motion"
			if (o == 0)
				global.config_rdcdMot = !global.config_rdcdMot;
		}
		
		fn_aud_play(opt_move_snd[l], CONFIG_AUD_EMTR.MENU);
		fn_config_file_save();
	}	
}
function fn_menu_config_opt_config_update()
{
	var l = lvl;
	
	// Main level
	if (l == LVL_MAIN)
		opt_config_text[l, 0] = global.config_lang[global.config_langCurr].name;
	
	// Graphics level
	else if (l == LVL_GFX)
	{
		opt_config_text[l, 0] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_fscr}");
		opt_config_text[l, 1] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_lowGfx}");
		opt_config_text[l, 2] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_hideCsr}");
		opt_config_text[l, 3] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_showFps}");
		opt_config_text[l, 4] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_showBdr}");
		opt_config_text[l, 5] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_showVer}");
	}
	
	// Music & Sounds level
	else if (l == LVL_AUD)
	{
		for (var v = 0; v < array_length(global.CONFIG_AUD_EMTR); v++)
			opt_config_text[l, v] = $"{round(global.CONFIG_AUD_EMTR[v].vol * 100)}%";
	}
	
	// Accessibility level
	else if (l == LVL_A11Y)
		opt_config_text[l, 0] = fn_config_lang_data_getText($"menu_config_all_opt_config_{global.config_rdcdMot}");
}
