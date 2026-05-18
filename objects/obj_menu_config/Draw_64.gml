
if (is_array(lvl) == true)
{
	var _res_width = global.config.video.resolution[0].width;
	var _res_height = global.config.video.resolution[0].height;
	
	// Main level
	if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN)
	{	
		var l = LVL_MAIN;
		
		// Panel
		var _panel = lvl[l].panel[0];
		var _panel_xMarg = 48;
		var _panel_yMarg = 64;
		_panel.width = round(_res_width - (_panel_xMarg * 2));
		_panel.height = round(_res_height - (_panel_yMarg * 2));
		_panel.x = round((_res_width / 2) - (_panel.width / 2));
		_panel.y = round((_res_height / 2) - (_panel.height / 2) + (_panel.title.height / 2));
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
	// Graphics, Music & Sounds and Accessibility levels
	for (var l = LVL_VIDEO; l <= LVL_ACCESS; l++)
	{
		if (lvl_curr == l) || (lvl_fader.next.lvl == l)
		{
			// Panel
			var _panel = lvl[l].panel[0];
			var _panel_xMarg = (48 - 16);
			var _panel_yMarg = (64 - 16);
			_panel.width = (_res_width - (_panel_xMarg * 2));
			_panel.height = (_res_height - (_panel_yMarg * 2));
			_panel.x = round((_res_width / 2) - (_panel.width / 2));
			_panel.y = round((_res_height / 2) - (_panel.height / 2) + (_panel.title.height / 2));
			_panel.title.label.text = $"menu_config_main_option_{l - 1}";
			
			// Options
			var _opt = lvl[l].option;
			if (l == LVL_VIDEO)
			{
				_opt[0].text = global.config.video.resolution_name;
				_opt[0].value.text = $"{round(global.config.video.resolution[global.config.video.resolution_curr].width)}x{round(global.config.video.resolution[global.config.video.resolution_curr].height)}";
				_opt[1].text = global.config.video.fullscreen.name;
				_opt[1].value.text = $"menu_config_all_option_value_{global.config.video.fullscreen.active}";
				_opt[2].text = global.config.video.vsync.name;
				_opt[2].value.text = $"menu_config_all_option_value_{global.config.video.vsync.active}";
				_opt[3].text = global.config.video.hideCursor.name;
				_opt[3].value.text = $"menu_config_all_option_value_{global.config.video.hideCursor.active}";
				_opt[4].text = global.config.video.showVer.name;
				_opt[4].value.text = $"menu_config_all_option_value_{global.config.video.showVer.active}";
				_opt[5].text = global.config.video.showBdr.name;
				_opt[5].value.text = $"menu_config_all_option_value_{global.config.video.showBdr.active}";
				_opt[6].text = global.config.video.showFps.name;
				_opt[6].value.text = $"menu_config_all_option_value_{global.config.video.showFps.active}";
			}
			else if (l == LVL_AUDIO)
			{
				for (var o = 0; o < array_length(global.config.audio.emitter); o++)
				{
					var _emitter_vol = global.config.audio.emitter[o].volume;
					_opt[o].text = global.config.audio.emitter[o].name;
					_opt[o].value.text = $"{round(_emitter_vol * 100)}%";
					_opt[o].value.arrow[0].active = ((_emitter_vol > 0) ? true : false);
					_opt[o].value.arrow[1].active = ((_emitter_vol < 1) ? true : false);
				}
			}
			else if (l == LVL_ACCESS)
			{
				_opt[0].text = global.config.access.reduceMotion.name;
				_opt[0].value.text = $"menu_config_all_option_value_{global.config.access.reduceMotion.active}";
			}
			var _opt_yGap = 16;
			var _opt_value_xGap = (32 + 32);
			var _opt_widthAll = (fn_menu_lvl_option_getWidthMax(l) + _opt_value_xGap + (fn_text_width("Salenis") / 2) + _opt[0].value.arrow[0].xGap);
			var _opt_heightAll = ((_opt_yGap * (array_length(_opt) - 1)) + fn_text_height("Salenis"));
			for (var o = 0; o < array_length(_opt); o++)
			{
				_opt[o].x = round(_panel.x + (_panel.width / 2) - (_opt_widthAll / 2));
				_opt[o].y = round(_panel.y + (_panel.height / 2) - (_opt_heightAll / 2) + (_opt_yGap * o));
				if (_opt[o].value != undefined)
					_opt[o].value.x = round(_opt[o].x + fn_menu_lvl_option_getWidthMax(l) + _opt_value_xGap);
			}
		}
	}
}


event_inherited();
