
if (is_array(lvl) == true)
{
	// Main level
	if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN)
	{	
		var l = LVL_MAIN;
		
		// Label panel
		var _panel_x = 16;
		var _panel_y = 8;
		var _panel_width = (16 * 6)
		var _panel_height = (16 * 7);
		lvl[l].panel[0].x = _panel_x;
		lvl[l].panel[0].y = _panel_y;
		lvl[l].panel[0].width = _panel_width;
		lvl[l].panel[0].height = _panel_height;
		
			// User's picture frame decor
		var _picFrame_spr = global.user.thm[global.user.thm_curr].spr.picFrame;
		var _picFrame_width = fn_spr_width(_picFrame_spr);
		var _picFrame_height = fn_spr_height(_picFrame_spr);
		var _picFrame_x = (_panel_x + round(_panel_width / 2) - round(_picFrame_width / 2));
		var _picFrame_y = (_panel_y + 16);
		lvl[l].decor[0].spr = _picFrame_spr;
		lvl[l].decor[0].x = _picFrame_x;
		lvl[l].decor[0].y = _picFrame_y;
		
			// User's picture
		var _pic_spr = lvl[l].decor[1].spr;
		lvl[l].decor[1].x = (_picFrame_x + round(_picFrame_width / 2) - round(fn_spr_width(_pic_spr) / 2));
		lvl[l].decor[1].y = (_picFrame_y + round(_picFrame_height / 2) + round(fn_spr_height(_pic_spr) / 2));
		
			// User's name
		var _name_text = global.user.name;
		var _name_x = (_picFrame_x + round(_picFrame_width / 2) - round(fn_text_width(_name_text) / 2));
		var _name_y = (_picFrame_y + _picFrame_height + 2);
		lvl[l].label[0].text = _name_text;
		lvl[l].label[0].x = _name_x;
		lvl[l].label[0].y = _name_y;
		lvl[l].label[0].color = [global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.whiteDark];
		
			// User's money
		var _money_ccy_text = global.user.money.ccy[global.user.asleep];
		var _money_amt_text = global.user.money.amt[global.user.asleep];
		lvl[l].label[1].text = _money_ccy_text;
		lvl[l].label[2].text = _money_amt_text;
		lvl[l].label[1].x = (_picFrame_x + round(_picFrame_width / 2) - round(fn_text_width(_money_amt_text) / 2));
		lvl[l].label[1].y = (_name_y + fn_text_height(_name_text) + round(((_panel_y + _panel_height - 16 - 4) - (_name_y + fn_text_height(_name_text))) / 2));
		lvl[l].label[1].color = [global.user.thm[global.user.thm_curr].color.grayLight, global.user.thm[global.user.thm_curr].color.grayDark];
		lvl[l].label[2].x = (lvl[l].label[1].x + fn_text_width(_money_ccy_text));
		lvl[l].label[2].y = lvl[l].label[1].y;
		lvl[l].label[1].icon.spr = spr_menu_user_main_label_icon;
		
		// Option panel
		var _panel_x = lvl[l].panel[0].x;
		var _panel_y = (lvl[l].panel[0].y + lvl[l].panel[0].height + lvl[l].panel[0].y);
		var _panel_width = lvl[l].panel[0].width;
		var _panel_height = 70;
		lvl[l].panel[1].x = _panel_x;
		lvl[l].panel[1].y = _panel_y;
		lvl[l].panel[1].width = _panel_width;
		lvl[l].panel[1].height = _panel_height;
		
			// Options
		var _opt_len = array_length(lvl[l].option);
		var _opt_yGap = round(fn_text_height("Salenis") * 1.25);
		var _opt_heightAll = ((_opt_yGap * (_opt_len - 1)) + fn_text_height("Salenis"));
		for (var o = 0; o < _opt_len; o++)
		{
			lvl[l].option[o].text = $"menu_user_main_option_{o}";
			lvl[l].option[o].icon.spr = spr_menu_user_main_option_icon;
			lvl[l].option[o].icon.img = o;
			lvl[l].option[o].x = round(_panel_x + (_panel_width / 2) - (fn_menu_lvl_option_getWidthMax(l) / 2) + (fn_menu_lvl_option_icon_xGap_getDflt(l, o) / 2));
			lvl[l].option[o].y = round((_panel_y + (_panel_height / 2)) - (_opt_heightAll / 2) + (_opt_yGap * o));
		}
	}
	// User levels
	if (lvl_curr >= LVL_USER_EFF && lvl_curr <= LVL_USER_THM) || (lvl_fader.next.lvl >= LVL_USER_EFF && lvl_fader.next.lvl <= LVL_USER_THM)
	{
		var l;
		if (lvl_curr >= LVL_USER_EFF && lvl_curr <= LVL_USER_THM)
			l = lvl_curr;
		else if (lvl_fader.next.lvl >= LVL_USER_EFF && lvl_fader.next.lvl <= LVL_USER_THM)
			l = lvl_fader.next.lvl;
		var _item = lvl[l].data[0];
		
		// Panel
		var _panel = lvl[l].panel[0];
		var _panel_xMarg = 32;
		var _panel_yMarg = 32;
		_panel.width = round(global.config.video.width - (_panel_xMarg * 2));
		_panel.height = round(global.config.video.height - (_panel_yMarg * 2));
		_panel.x = round((global.config.video.width / 2) - (_panel.width / 2));
		_panel.y = round((global.config.video.height / 2) - (_panel.height / 2) + (_panel.title.height / 2));
		_panel.title.label.text = $"menu_user_main_option_{(l - 2)}";
		
		// Options
		var _opt = lvl[l].option;
		var _opt_curr = lvl[l].option_curr;
		for (var o = 0; o < array_length(lvl[l].option); o++)
		{
			_opt[o].text = "----------";
			if (is_array(_item) == true && o < array_length(_item) && array_get(_item, o).unlocked == true)
				_opt[o].text = array_get(_item, o).name;
			_opt[o].x = round(_panel.x + (_panel.width / 2) - (fn_menu_lvl_option_getWidthMax(l) / 2) - ((_panel.width / 4) * (o % 2 == 0 ? 1 : -1)));
			_opt[o].y = round(_panel.y + 16 + (16 * floor(o / 2)));
		}
		
		// Label
		var _label = lvl[l].label[0];
		_label.text = "";
		if (is_array(_item) == true && _opt_curr < array_length(_item) && array_get(_item, _opt_curr).unlocked == true)
			_label.text = array_get(_item, _opt_curr).desc;
		_label.yAlign = fa_bottom;
		_label.x = (_panel.x + 16);
		_label.y = (_panel.y + _panel.height - 16);
		_label.color = [merge_color(global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.grayLight, 0.65), merge_color(global.user.thm[global.user.thm_curr].color.whiteDark, global.user.thm[global.user.thm_curr].color.grayDark, 0.65)];
	}
}
event_inherited();

