
if (is_array(lvl) == true)
{
	// Main level
	if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN)
	{	
		var l = LVL_MAIN;
		
		// Label box
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
	}
}
event_inherited();

