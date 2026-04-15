
if (is_array(lvl) == true)
{
	// Main level
	if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN)
	{	
		var l = LVL_MAIN;
		
		// Panel
		var _panel = lvl[l].panel[0];
		var _panel_xMarg = 48;
		var _panel_yMarg = 64;
		_panel.width = round(global.config.video.width - (_panel_xMarg * 2));
		_panel.height = round(global.config.video.height - (_panel_yMarg * 2));
		_panel.x = round((global.config.video.width / 2) - (_panel.width / 2));
		_panel.y = round((global.config.video.height / 2) - (_panel.height / 2) + (_panel.title.height / 2));
		_panel.title.label.text = "menu_home_main_option_1";
		var _panel_yPad = (16 + 4);
		
		// Options
		var _opt = lvl[l].option;
		for (var o = 0; o < array_length(_opt); o++)
		{
			_opt[o].text = $"menu_config_main_option_{o}";
			_opt[o].icon.spr = spr_menu_config_main_option_icon;
			_opt[o].icon.img = o;
			_opt[o].icon.xGap = fn_menu_lvl_option_icon_xGap_getDflt(l, o);
			if (o == 0)
			{
				_opt[o].value.text = $"config_lang_{global.config.lang[global.config.lang_curr].code}";
				var _opt_widthAll = (fn_textdata_width(_opt[o].text) + _opt[o].value.xGap + (fn_textdata_width(_opt[o].value.text) / 2) + _opt[o].value.arrow[1].xGap + (fn_textdata_width(_opt[o].value.text) / 2) + (fn_text_width(_opt[o].value.arrow[1].text) / 2));
				_opt[o].x = round(_panel.x + (_panel.width / 2) - (_opt_widthAll / 2) + (_opt[o].icon.xGap / 2));
				_opt[o].y = round(_panel.y + _panel_yPad);
			}
			else
			{
				var _opt_len = (array_length(_opt) - 1);
				var _opt_yGap = 16;
				var _opt_heightAll = ((_opt_yGap * (_opt_len - 1)) + fn_text_height("Salenis"));
				_opt[o].x = round(_panel.x + (_panel.width / 2) - (fn_textdata_width(_opt[o].text) / 2) + (_opt[o].icon.xGap / 2));
				_opt[o].y = round(_panel.y + _panel.height - _panel_yPad - _opt_heightAll + (_opt_yGap * (o - 1)));
			}
		}
	}
	
	// Video, Music & Sounds and Accessibility levels
	for (var l = LVL_VIDEO; l <= LVL_ACCESS; l++)
	{
		if (lvl_curr == l) || (lvl_fader.next.lvl == l)
		{
			// Panel
			var _panel = lvl[l].panel[0];
			var _panel_xMarg = (48 - 16);
			var _panel_yMarg = (64 - 16);
			_panel.width = (global.config.video.width - (_panel_xMarg * 2));
			_panel.height = (global.config.video.height - (_panel_yMarg * 2));
			_panel.x = round((global.config.video.width / 2) - (_panel.width / 2));
			_panel.y = round((global.config.video.height / 2) - (_panel.height / 2) + (_panel.title.height / 2));
			_panel.title.label.text = $"menu_config_main_option_{l - 1}";
			
			// Options
			var _opt = lvl[l].option;
			if (l == LVL_VIDEO)
			{
				_opt[0].text = global.config.video.scale_name;
				_opt[0].value.text = $"{global.config.video.width * global.config.video.scale[global.config.video.scale_curr]}x{global.config.video.height * global.config.video.scale[global.config.video.scale_curr]}";
				_opt[1].text = global.config.video.fscr.name;
				_opt[1].value.text = $"menu_config_all_option_value_{global.config.video.fscr.act}";
				_opt[2].text = global.config.video.vsync.name;
				_opt[2].value.text = $"menu_config_all_option_value_{global.config.video.vsync.act}";
				_opt[3].text = global.config.video.hideCsr.name;
				_opt[3].value.text = $"menu_config_all_option_value_{global.config.video.hideCsr.act}";
				_opt[4].text = global.config.video.showVer.name;
				_opt[4].value.text = $"menu_config_all_option_value_{global.config.video.showVer.act}";
				_opt[5].text = global.config.video.showBdr.name;
				_opt[5].value.text = $"menu_config_all_option_value_{global.config.video.showBdr.act}";
				_opt[6].text = global.config.video.showFps.name;
				_opt[6].value.text = $"menu_config_all_option_value_{global.config.video.showFps.act}";
			}
			else if (l == LVL_AUD)
			{
				for (var o = 0; o < array_length(global.config.aud.emtr); o++)
				{
					var _emtr_vol = global.config.aud.emtr[o].vol;
					_opt[o].text = global.config.aud.emtr[o].name;
					_opt[o].value.text = $"{round(_emtr_vol * 100)}%";
					_opt[o].value.arrow[0].act = ((_emtr_vol > 0) ? true : false);
					_opt[o].value.arrow[1].act = ((_emtr_vol < 1) ? true : false);
				}
			}
			else if (l == LVL_ACCESS)
			{
				_opt[0].text = global.config.access.rdcdMot.name;
				_opt[0].value.text = $"menu_config_all_option_value_{global.config.access.rdcdMot.act}";
			}
			var _opt_yGap = 16;
			var _opt_value_xGap = (32 + 32);
			var _opt_widthAll = (fn_menu_lvl_option_getWidthMax(l) + _opt_value_xGap + (fn_text_width("Salenis") / 2) + _opt[0].value.arrow[0].xGap);
			var _opt_heightAll = ((_opt_yGap * (array_length(_opt) - 1)) + fn_text_height("Salenis"));
			for (var o = 0; o < array_length(_opt); o++)
			{
				_opt[o].x = round(_panel.x + (_panel.width / 2) - (_opt_widthAll / 2));
				_opt[o].y = round(_panel.y + (_panel.height / 2) - (_opt_heightAll / 2) + (_opt_yGap * o));
				_opt[o].value.x = round(_opt[o].x + fn_menu_lvl_option_getWidthMax(l) + _opt_value_xGap);
				//_opt[o].value.x = round(_opt[o].x + fn_menu_lvl_option_getWidthMax(l) + (((_panel.x + _panel.width) - (_opt[o].x + fn_menu_lvl_option_getWidthMax(l))) / 2));
			}
		}
	}
	
	// Video level
	if (lvl_curr == LVL_VIDEO) || (lvl_fader.next.lvl == LVL_VIDEO)
	{	
		var l = LVL_MAIN;
	}
}


event_inherited();
