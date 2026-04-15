
if (is_array(lvl) == true)
{
	// Language level
	if (lvl_curr == LVL_LANG) || (lvl_fader.next.lvl == LVL_LANG)
	{	
		var l = LVL_LANG;
	
		// Options
		var _opt_len = array_length(lvl[l].option);
		for (var o = 0; o < _opt_len; o++)
		{
			lvl[l].option[o].text = "";
			lvl[l].option[o].x = 0;
			lvl[l].option[o].y = 0;
			lvl[l].option[o].select.act = false;
		}
	
		// Panel
		var _panel_xMargin = 16;
		var _panel_yMargin = 16;
		
		// Options' icon
		var _flag_spr = spr_menu_home_flag;
		var _flag_width = fn_spr_width(_flag_spr);
		var _flag_height = fn_spr_height(_flag_spr);
		var _flag_xGap = (_flag_width + 16); // Horizontal distance between each flag
		var _flag_widthAll = ((_flag_xGap * (_opt_len - 1)) + _flag_width);
		
		// Panel
		var _panel_width = (_panel_xMargin + _flag_widthAll + _panel_xMargin);
		var _panel_height = (_panel_yMargin + _flag_height + _panel_yMargin);
		var _panel_x = (160 - round(_panel_width / 2));
		var _panel_y = (120 - round(_panel_height / 2));
		lvl[l].panel[0].x = _panel_x;
		lvl[l].panel[0].y = _panel_y;
		lvl[l].panel[0].width = _panel_width;
		lvl[l].panel[0].height = _panel_height;
		lvl[l].panel[0].title.label.text = "menu_config_main_option_0";
		
		// Options' icon and decorations
		for (var o = 0; o < _opt_len; o++)
		{
			// Option's icon
			var __flag_x = (_panel_x + round(_panel_width / 2) - round(_flag_widthAll / 2) + (_flag_xGap * o));
			var __flag_y = (_panel_y + _panel_yMargin);
			lvl[l].option[o].icon.spr = _flag_spr;
			lvl[l].option[o].icon.img = o;
			lvl[l].option[o].icon.x = __flag_x;
			lvl[l].option[o].icon.y = __flag_y;
		
			// Decoration
			lvl[l].decor[o].spr = spr_menu_home_flag_select
			lvl[l].decor[o].x = (__flag_x + round(_flag_width / 2));
			lvl[l].decor[o].y = (__flag_y + _flag_height + 5);
			lvl[l].decor[o].color = global.user.thm[global.user.thm_curr].color.whiteLight;
			lvl[l].decor[o].alpha = (o == lvl[l].option_curr);
		}
	}
	
	// Main level
	if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN)
	{	
		var l = LVL_MAIN;
		
		// Panel (task bar)
		var _panel = lvl[l].panel[0];
		var _panel_outDist = 8;
		var _panel_x = -_panel_outDist;
		var _panel_y = (global.config.video.height - 16);
		var _panel_width = (global.config.video.width + (_panel_outDist * 2));
		var _panel_height = ((global.config.video.height - _panel_y) + _panel_outDist);
		_panel.x = _panel_x;
		_panel.y = _panel_y;
		_panel.width = _panel_width;
		_panel.height = _panel_height;
		_panel.alpha = 0.75;
		
		// Triangle train
		lvl[l].train[0].x = 0;
		lvl[l].train[0].y = (_panel_y - fn_spr_height(lvl[l].train[0].spr));
		lvl[l].train[0].xSpd = -0.25;
		lvl[l].train[0].alpha = 0.75;
		
		// Panel (start menu)
		var _panel_outDist = 8;
		var _panel_x = -_panel_outDist;
		var _panel_y = round(global.config.video.height / 1.75);
		var _panel_width = (abs(_panel_x) + (16 * 7));
		var _panel_height = ((global.config.video.height - _panel_y) + _panel_outDist);
		lvl[l].panel[1].x = _panel_x;
		lvl[l].panel[1].y = _panel_y;
		lvl[l].panel[1].width = _panel_width;
		lvl[l].panel[1].height = _panel_height;
		
		// Card
		var _card_xMargLT = (_panel_outDist + 8);
		var _card_xMargRT = ((_panel_outDist / 2) + 8);
		var _card_yMargUP = ((_panel_outDist / 2) + 8);
		var _card_yMargDN = (_panel_outDist + 8);
		var _card_x = (_panel_x + _card_xMargLT);
		var _card_y = (_panel_y + _card_yMargUP);
		var _card_width = (-_card_xMargLT + _panel_width - _card_xMargRT);
		var _card_height = (-_card_yMargUP + _panel_height - _card_yMargDN);
		/*
		lvl[l].card[0].x = _card_x;
		lvl[l].card[0].y = _card_y;
		lvl[l].card[0].width = _card_width;
		lvl[l].card[0].height = _card_height;
		*/
		
		// Options
		var _opt_len = array_length(lvl[l].option);
		var _opt_yGap = (fn_text_height("Salenis") + 9);
		var _opt_heightAll = ((_opt_yGap * (_opt_len - 1)) + fn_text_height("Salenis"));
		for (var o = 0; o < _opt_len; o++)
		{
			lvl[l].option[o].text = $"menu_home_main_option_{o}";
			lvl[l].option[o].icon.spr = spr_menu_home_main_option_icon;
			lvl[l].option[o].icon.img = o;
			lvl[l].option[o].x = round(_card_x + (_card_width / 2) - (fn_menu_lvl_option_getWidthMax(l) / 2) + (fn_menu_lvl_option_icon_xGap_getDflt(l, o) / 2));
			lvl[l].option[o].y = round((_card_y + (_card_height / 2)) - (_opt_heightAll / 2) + (_opt_yGap * o));
			//lvl[l].option[o].icon.color = [global.user.thm[global.user.thm_curr].color.grayDark /* Inactive (Unselected) */, global.user.thm[global.user.thm_curr].color.whiteLight /* Active (Selected) */];
		}
		
		// Logo decoration
		var _logo_spr = spr_menu_home_logo;
		var _logo_width = fn_spr_width(_logo_spr);
		var _logo_height = fn_spr_height(_logo_spr);
		lvl[l].decor[0].spr = _logo_spr;
		lvl[l].decor[0].x = round(_panel_x + _panel_width + ((global.config.video.width - (_panel_x + _panel_width)) / 2) - (_logo_width / 2));
		lvl[l].decor[0].y = round((global.config.video.height * 0.35) - (_logo_height / 2));
	}
}


event_inherited();
