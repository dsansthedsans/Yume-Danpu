
if (is_array(lvl) == true)
{
	var _res_width = global.config.video.resolution[0].width;
	var _res_height = global.config.video.resolution[0].height;
	
	// Main level
	if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN)
	{	
		var l = LVL_MAIN;
		lvl[l].rect[0].alpha = global.user.theme[global.user.theme_curr].alpha.blurLight;
		
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
		var _picFrame_spr = global.user.theme[global.user.theme_curr].spr.picFrame;
		var _picFrame_width = fn_sprite_width(_picFrame_spr);
		var _picFrame_height = fn_sprite_height(_picFrame_spr);
		var _picFrame_x = (_panel_x + round(_panel_width / 2) - round(_picFrame_width / 2));
		var _picFrame_y = (_panel_y + 16);
		lvl[l].decor[0].spr = _picFrame_spr;
		lvl[l].decor[0].x = _picFrame_x;
		lvl[l].decor[0].y = _picFrame_y;
			// User's picture
		var _pic_spr = lvl[l].decor[1].spr;
		lvl[l].decor[1].x = (_picFrame_x + round(_picFrame_width / 2) - round(fn_sprite_width(_pic_spr) / 2));
		lvl[l].decor[1].y = (_picFrame_y + round(_picFrame_height / 2) + round(fn_sprite_height(_pic_spr) / 2));
			// User's name
		var _name = lvl[l].label[0];
		_name.text = global.user.name;
		_name.x = (_picFrame_x + round(_picFrame_width / 2) - round(fn_text_width(_name.text) / 2));
		_name.y = (_picFrame_y + _picFrame_height + 2);
			// User's money
		var _money_ccy = lvl[l].label[1];
		var _money_amt = lvl[l].label[2];
		_money_ccy.text = global.user.money.ccy[global.user.asleep];
		_money_amt.text = global.user.money.amt[global.user.asleep];
		_money_ccy.x = (_picFrame_x + round(_picFrame_width / 2) - round(fn_text_width(_money_amt.text) / 2));
		_money_ccy.y = (_name.y + fn_text_height(_name.text) + round(((_panel_y + _panel_height - 16 - 4) - (_name.y + fn_text_height(_name.text))) / 2));
		_money_ccy.colors = [global.user.theme[global.user.theme_curr].color.grayLight, global.user.theme[global.user.theme_curr].color.grayDark];
		_money_ccy.icon.spr = spr_menu_user_main_label_icon;
		_money_ccy.icon.color = global.user.theme[global.user.theme_curr].color.whiteLight;
		_money_amt.x = (_money_ccy.x + fn_text_width(_money_ccy.text));
		_money_amt.y = _money_ccy.y;
		
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
	if (lvl_curr >= LVL_USER_EFFECT && lvl_curr <= LVL_USER_THEME) || (lvl_fader.next.lvl >= LVL_USER_EFFECT && lvl_fader.next.lvl <= LVL_USER_THEME)
	{
		var l;
		if (lvl_curr >= LVL_USER_EFFECT && lvl_curr <= LVL_USER_THEME)
			l = lvl_curr;
		else if (lvl_fader.next.lvl >= LVL_USER_EFFECT && lvl_fader.next.lvl <= LVL_USER_THEME)
			l = lvl_fader.next.lvl;
		var _item = lvl[l].data[0];
		lvl[l].rect[0].alpha = global.user.theme[global.user.theme_curr].alpha.blurHeavy;
		
		// Panel
		var _panel = lvl[l].panel[0];
		var _panel_xMarg = 32;
		var _panel_yMarg = 32;
		_panel.width = round(_res_width - (_panel_xMarg * 2));
		_panel.height = round(_res_height - (_panel_yMarg * 2));
		_panel.x = round((_res_width / 2) - (_panel.width / 2));
		_panel.y = round((_res_height / 2) - (_panel.height / 2) + (_panel.title.height / 2));
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
		_label.colors = [merge_color(global.user.theme[global.user.theme_curr].color.whiteLight, global.user.theme[global.user.theme_curr].color.grayLight, 0.65), merge_color(global.user.theme[global.user.theme_curr].color.whiteDark, global.user.theme[global.user.theme_curr].color.grayDark, 0.65)];
	}
}
event_inherited();

