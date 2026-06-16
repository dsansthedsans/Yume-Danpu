/// @descr Draw GUI Begin Event
var _res_width = global.config.video.resolution[0].width;
var _res_height = global.config.video.resolution[0].height;
switch (object_index)
{
	/* Main menu */
	case obj_menu_home:
	{
		if (lvl_curr == LVL_LANG) || (lvl_fader.next.lvl == LVL_LANG) // Language level
		{	
			var l = LVL_LANG;
			// Options
			var _opt_len = array_length(lvl[l].option);
			for (var o = 0; o < _opt_len; o++)
			{
				lvl[l].option[o].text = "";
				lvl[l].option[o].x = 0;
				lvl[l].option[o].y = 0;
				lvl[l].option[o].select.active = false;
			}
			// Panel
			var _panel_xMargin = 16;
			var _panel_yMargin = 16;
			// Options' icon
			var _flag_spr = spr_menu_home_flag;
			var _flag_width = fn_sprite_width(_flag_spr);
			var _flag_height = fn_sprite_height(_flag_spr);
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
				lvl[l].decor[o].color = global.user.theme[global.user.theme_curr].color.whiteLight;
				lvl[l].decor[o].alpha = (o == lvl[l].option_curr);
			}
		}
		if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN) // Main level
		{
			var l = LVL_MAIN;
			// Panel (task bar)
			var _panel = lvl[l].panel[0];
			var _panel_outDist = 8;
			var _panel_x = -_panel_outDist;
			var _panel_y = (_res_height - 16);
			var _panel_width = (_res_width + (_panel_outDist * 2));
			var _panel_height = ((_res_height - _panel_y) + _panel_outDist);
			_panel.x = _panel_x;
			_panel.y = _panel_y;
			_panel.width = _panel_width;
			_panel.height = _panel_height;
			_panel.alpha = 0.75;
			// Triangle train
			var _train = lvl[l].train[0];
			_train.spr = global.user.theme[global.user.theme_curr].spr.train;
			_train.x = 0;
			_train.y = (_panel_y - fn_sprite_height(_train.spr));
			_train.xSpeed = -0.25;
			_train.alpha = 0.75;
			// Panel (start menu)
			var _panel_outDist = 8;
			var _panel_x = -_panel_outDist;
			var _panel_y = round(_res_height / 1.75);
			var _panel_width = (abs(_panel_x) + (16 * 7));
			var _panel_height = ((_res_height - _panel_y) + _panel_outDist);
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
			var _logo_width = fn_sprite_width(_logo_spr);
			var _logo_height = fn_sprite_height(_logo_spr);
			lvl[l].decor[0].spr = _logo_spr;
			lvl[l].decor[0].x = round(_panel_x + _panel_width + ((_res_width - (_panel_x + _panel_width)) / 2) - (_logo_width / 2));
			lvl[l].decor[0].y = round((_res_height * 0.35) - (_logo_height / 2));
		}
		break;
	}
	
	/* Settings menu */
	case obj_menu_config:
	{
		fn_log("fuck you");
		if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN) // Main level
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
		for (var l = LVL_VIDEO; l <= LVL_ACCESS; l++) // Graphics, Music & Sounds and Accessibility levels
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
		break;
	}
	
	/* Inventory menu */
	case obj_menu_user:
	{
		if (lvl_curr == LVL_MAIN) || (lvl_fader.next.lvl == LVL_MAIN) // Main level
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
		if (lvl_curr >= LVL_USER_EFFECT && lvl_curr <= LVL_USER_THEME) || (lvl_fader.next.lvl >= LVL_USER_EFFECT && lvl_fader.next.lvl <= LVL_USER_THEME) // User levels
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
		break;
	}
}