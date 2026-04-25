
/* Template for child objects:
if (is_array(lvl) == true)
{
	// ??? level
	if (lvl_curr == 0) || (lvl_fader.next.lvl == 0)
	{	
		var l = 0;
	}
}
*/

if (is_array(lvl) == true)
{
	for (var l = 1; l < array_length(lvl); l++)
	{
		if (is_struct(lvl[l]) == true && lvl[l].alpha > 0)
		{
			var _shdw_cols = [global.user.theme[global.user.theme_curr].color.blackLight, global.user.theme[global.user.theme_curr].color.blackDark];
			var _shdw_alp = global.user.theme[global.user.theme_curr].alpha.shadow;
			
			// Rectangles
			if (is_array(lvl[l].rect) == true)
			{
				for (var r = 0; r < array_length(lvl[l].rect); r++)
				{
					var _rect = lvl[l].rect[r];
					if (_rect.x != undefined && _rect.y != undefined && _rect.width != undefined && _rect.height != undefined)
						fn_draw_rect(_rect.x, _rect.y, _rect.width, _rect.height, _rect.colors, (_rect.alpha * lvl[l].alpha));
				}
			}
			// Triangle trains
			if (is_array(lvl[l].train) == true)
			{
				for (var t = 0; t < array_length(lvl[l].train); t++)
				{
					var _train = lvl[l].train[t];
					if (_train.x != undefined && _train.x != undefined)
					{
						var _train_spr = ((_train.spr != undefined) ? _train.spr : global.user.theme[global.user.theme_curr].spr.train)
						var _train_xGap = lengthdir_x(fn_spr_width(_train_spr), _train.angle);
						var _train_yGap = lengthdir_y(fn_spr_height(_train_spr), _train.angle);
						_train.xOffset += _train.xSpd;
						_train.yOffset += _train.ySpd;
						if (abs(_train.xOffset) >= abs(_train_xGap)) || (global.config.access.reduceMotion.act == true)
							_train.xOffset = 0;
						if (abs(_train.yOffset) >= abs(_train_yGap)) || (global.config.access.reduceMotion.act == true)
							_train.yOffset = 0;
						var _train_color = ((_train.color != undefined) ? _train.color : global.user.theme[global.user.theme_curr].color.grayDark);
						for (var c = 0; c < 21; c++)
							fn_draw_spr(_train_spr, 0, (_train.x + _train.xOffset + (_train_xGap * c)), (_train.y + _train.yOffset + (_train_yGap * c)), _train_color, (_train.alpha * lvl[l].alpha), , , _train.angle);
					}
				}
			}
			// Panels
			if (is_array(lvl[l].panel) == true)
			{
				for (var p = 0; p < array_length(lvl[l].panel); p++)
				{
					var _panel = lvl[l].panel[p];
					if (_panel.x != undefined && _panel.y != undefined && _panel.width != undefined && _panel.height != undefined)
					{
						var _panel_spr = ((_panel.spr != undefined) ? _panel.spr : global.user.theme[global.user.theme_curr].spr.panel);
						var _panel_x = round(_panel.x);
						var _panel_y = round(_panel.y);
						var _panel_img = 0;
							// Title
						if (is_struct(_panel.title) == true)
						{
							_panel_img = 1;
							var _title = _panel.title;
							var _title_spr = ((_title.spr != undefined) ? _title.spr : global.user.theme[global.user.theme_curr].spr.panel_title);
							var _title_y = round(_panel_y - _title.height);
							fn_draw_spr_stretch(_title_spr, 0, _panel_x, _title_y, _panel.width, _title.height, , (_panel.alpha * lvl[l].alpha));	
								// Label
							if (_title.label.text != undefined)
							{
								var _lbl = _title.label;
								var _lbl_x = round(_panel_x + _title.label.xMarg);
								var _lbl_y = round(_panel_y - (_panel.title.height / 2) - (fn_text_height("Salenis") / 2) + 1);
								var _lbl_cols = ((_lbl.color != undefined) ? _lbl.color : [global.user.theme[global.user.theme_curr].color.whiteLight, global.user.theme[global.user.theme_curr].color.whiteDark]);
								var _lbl_alp = ((_lbl.alpha != undefined) ? _lbl.alpha : global.user.theme[global.user.theme_curr].alpha.panel_title_label);
								fn_draw_text(textdata(_title.label.text), _lbl_x, _lbl_y, _lbl_cols, (_lbl_alp * _panel.alpha * lvl[l].alpha), , , , , _shdw_cols, _shdw_alp);
							}
						}
						// Panel
						fn_draw_spr_stretch(_panel_spr, _panel_img, round(_panel.x), round(_panel.y), _panel.width, _panel.height, , (_panel.alpha * lvl[l].alpha));
					}
				}
			}
			// Cards
			if (is_array(lvl[l].card) == true)
			{
				for (var c = 0; c < array_length(lvl[l].card); c++)
				{
					var _card = lvl[l].card[c];
					if (_card.x != undefined && _card.y != undefined && _card.width != undefined && _card.height != undefined)
					{
						var _card_spr = ((_card.spr != undefined) ? _card.spr : global.user.theme[global.user.theme_curr].spr.card);
						fn_draw_spr_stretch(_card_spr, _card.img, round(_card.x), round(_card.y), _card.width, _card.height, , lvl[l].alpha);
					}
				}
			}
			// Labels
			if (is_array(lvl[l].label) == true)
			{
				for (var a = 0; a < array_length(lvl[l].label); a++)
				{
					var _lbl = lvl[l].label[a];
					if (_lbl.text != undefined && _lbl.x != undefined && _lbl.y != undefined)
					{
						var _lbl_x = round(_lbl.x);
						var _lbl_y = round(_lbl.y);
						var _lbl_cols = ((_lbl.colors != undefined) ? _lbl.colors : [global.user.theme[global.user.theme_curr].color.whiteLight, global.user.theme[global.user.theme_curr].color.whiteDark]);
						// Icon
						if (is_struct(_lbl.icon) == true && _lbl.icon.spr != undefined)
						{
							var _ico = _lbl.icon;
							var _ico_xGap = ((_ico.xGap != undefined) ? _ico.xGap : fn_menu_lvl_label_icon_xGap_getDflt(l, a));
							var _ico_x = round((_ico.x != undefined) ? _ico.x : (_lbl_x - _ico_xGap));
							var _ico_y = round((_ico.y != undefined) ? _ico.y : (_lbl_y + round(fn_textdata_height(_lbl.text) / 2) - round(fn_spr_height(_ico.spr) / 2) + 1));
							var _ico_col = ((_ico.color != undefined) ? _ico.color : _lbl_cols[0]);
							fn_draw_spr(_ico.spr, _ico.img, _ico_x, _ico_y, _ico_col, (_ico.alpha * lvl[l].alpha), , , , _shdw_cols[0], _shdw_alp);
						}
						// Label
						fn_draw_text(textdata(_lbl.text), _lbl_x, _lbl_y, _lbl_cols, lvl[l].alpha, , , _lbl.xAlign, _lbl.yAlign, _shdw_cols, _shdw_alp);
					}
				}
			}
			// Decorations
			if (is_array(lvl[l].decor) == true)
			{
				for (var d = 0; d < array_length(lvl[l].decor); d++)
				{
					var _decor = lvl[l].decor[d];
					if (_decor.x != undefined && _decor.y != undefined)
					{
						var _decor_spr = ((_decor.spr != undefined) ? _decor.spr : global.user.theme[global.user.theme_curr].spr.decor);
						fn_draw_spr(_decor_spr, _decor.img, round(_decor.x), round(_decor.y), _decor.color, (_decor.alpha * lvl[l].alpha), , , , _shdw_cols[0], _shdw_alp);
					}
				}
			}
			// Options
			if (is_array(lvl[l].option) == true)
			{
				for (var o = 0; o < array_length(lvl[l].option); o++)
				{
					var _opt = lvl[l].option[o];
					if (_opt.text != undefined && _opt.x != undefined && _opt.y != undefined)
					{
						var _opt_x = round(_opt.x);
						var _opt_y = round(_opt.y);
						var _opt_colors = ((_opt.colors != undefined) ? _opt.colors : [[global.user.theme[global.user.theme_curr].color.grayLight, global.user.theme[global.user.theme_curr].color.grayDark], [global.user.theme[global.user.theme_curr].color.whiteLight, global.user.theme[global.user.theme_curr].color.whiteDark]]);
						
							// Button
						if (is_struct(_opt.button) == true)
						{
							var _button = _opt.button;
							var _button_x = round((_button.x != 0) ? _button.x : (_opt.x - _button.xPad));
							var _button_y = round((_button.y != 0) ? _button.y : (_opt.y - _button.yPad));
							var _button_width = round((_button.width != 0) ? _button.width : ((_button.xPad * 2) + fn_textdata_width(_opt.text)));
							var _button_height = round((_button.height != 0) ? _button.height : ((_button.yPad * 2) + fn_textdata_height(_opt.text) + 2));
							fn_draw_spr_stretch(_button.spr, ((o != lvl[l].option_curr) ? _button.img_inact : _button.img_act), _button_x, _button_y, _button_width, _button_height, , lvl[l].alpha);
						}
							// Selection indicator
						if (_opt.select.act == true)
						{
							var _slct = _opt.select;
							_slct.alpha = fn_lerp(_slct.alpha, _slct.alphaTgt[(o == lvl[l].option_curr)], ((global.config.access.reduceMotion.act == false) ? _slct.alphaSpd : 1));
							if (_slct.alpha > 0)
							{
								var _slct_spr = ((_slct.spr != undefined) ? _slct.spr : global.user.theme[global.user.theme_curr].spr.option_select);
								var _slct_x = round((_slct.x != 0) ? _slct.x : (_opt_x - _slct.xDist));
								var _slct_y = round((_slct.y != 0) ? _slct.y : (_opt_y - _slct.yDist + 1));
								var _slct_width = round((_slct.width != 0) ? _slct.width : ((_slct.xDist * 2) + fn_textdata_width(_opt.text)));
								var _slct_height = round((_slct.height != 0) ? _slct.height : ((_slct.yDist * 2) + fn_textdata_height(_opt.text)));
								if (is_struct(_opt.icon) == true && _opt.icon.spr != undefined)
								{
									var _ico_xGap = round((_opt.icon.xGap != 0) ? _opt.icon.xGap : fn_menu_lvl_option_icon_xGap_getDflt(l, o));
									_slct_x -= _ico_xGap;
									_slct_width += _ico_xGap;
								}
								fn_draw_spr_stretch(_slct_spr, _slct.img, _slct_x, _slct_y, _slct_width, _slct_height, , (_slct.alpha * lvl[l].alpha));
							}
						}
							// Icon
						if (is_struct(_opt.icon) == true && _opt.icon.spr != undefined)
						{
							var _ico = _opt.icon;
							var _ico_xGap = round((_ico.xGap != 0) ? _ico.xGap : fn_menu_lvl_option_icon_xGap_getDflt(l, o));
							var _ico_x = round((_ico.x != 0) ? _ico.x : (_opt_x - _ico_xGap));
							var _ico_y = round((_ico.y != 0) ? _ico.y : (_opt_y + round(fn_textdata_height(_opt.text) / 2) - round(fn_spr_height(_ico.spr) / 2) + 1));
							var _ico_cols = ((_ico.colors != undefined) ? _ico.colors : [global.user.theme[global.user.theme_curr].color.grayLight, global.user.theme[global.user.theme_curr].color.whiteLight]);
							fn_draw_spr(_ico.spr, _ico.img, _ico_x, _ico_y, _ico_cols[(o == lvl[l].option_curr)], (_ico.alphas[(o == lvl[l].option_curr)] * lvl[l].alpha), , , , _shdw_cols[0], _shdw_alp);
						}
							// Checkbox
						if (is_struct(_opt.check) == true && _opt.check.spr != undefined)
						{
							var _check = _opt.check;
							var _check_x = round((_check.x != 0) ? _check.x : (_opt_x - _check.xPad - fn_spr_width(_check.spr)));
							var _check_y = round((_check.y != 0) ? _check.y : (_opt_y + round(fn_textdata_height(_opt.text) / 2) - round(fn_spr_height(_check.spr) / 2) + 1));
							fn_draw_spr(_opt.check.spr, 0, _check_x, _check_y, _check.color, (_check.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha), , , , _shdw_cols[0], _shdw_alp);
								// Mark
							if (_opt.check.mark.act == true)
							{
								var _mark = _opt.check.mark;
								var _mark_x = round((_mark.x != 0) ? _mark.x : _check_x);
								var _mark_y = round((_mark.y != 0) ? _mark.y : _check_y);
								fn_draw_spr(_mark.spr, 0, _mark_x, _mark_y, , (_mark.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha), , , , _shdw_cols[0], _shdw_alp);
							}
						}
						
						// Option
						fn_draw_text(textdata(_opt.text), _opt_x, _opt_y, _opt_colors[(o == lvl[l].option_curr)], lvl[l].alpha, , , _opt.xAlign, _opt.yAlign, _shdw_cols, _shdw_alp);
							
							// Value (the text beside the options in the settings menu, like "Yes", "No" and "100%")
						if (is_struct(_opt.value) == true && _opt.value.text != "")
						{
							var _val = _opt.value;
							var _val_x = round((_val.x != 0) ? _val.x : (_opt_x + fn_textdata_width(_opt.text) + _opt.value.xGap + (fn_textdata_width(_val.text) / 2)));
							var _val_y = round((_val.y != 0) ? _val.y : (_opt_y + ceil(fn_textdata_height("Salenis") / 2)));
							var _val_cols = ((_val.colors != undefined) ? _val.colors : [global.user.theme[global.user.theme_curr].color.grayLight, global.user.theme[global.user.theme_curr].color.grayDark]);
							_val.colorVal = fn_lerp(_val.colorVal, _val.colorValTgts[false], _val.colorValSpd);
							for (var c = 0; c < 2; c++)
								_val_cols[c] = make_colour_hsv(colour_get_hue(_val_cols[c]), colour_get_saturation(_val_cols[c]), (colour_get_value(_val_cols[c]) + _val.colorVal));
							_val.scale = fn_lerp(_val.scale, _val.scaleTgts[false], _val.scaleSpd);
							fn_draw_text(textdata(_val.text), _val_x, _val_y, _val_cols, (_val.alphas[(o == lvl[l].option_curr)] * lvl[l].alpha), _val.scale, _val.scale, _val.xAlign, _val.yAlign, _shdw_cols, _shdw_alp);
								
								// Value's arrows
							if (o == lvl[l].option_curr && (_val.arrow[0].act == true || _val.arrow[1].act == true))
							{
								var _arrow = _val.arrow;
								for (var a = 0; a < 2; a++)
								{
									_arrow[a].alpha = fn_lerp(_arrow[a].alpha, _arrow[a].alphaTgts[false], _arrow[a].alphaSpd);
									_arrow[a].scale = fn_lerp(_arrow[a].scale, _arrow[a].scaleTgts[false], _arrow[a].scaleSpd);
									if (_arrow[a].move.act == true && global.config.access.reduceMotion.act == false)
									{
										if (_arrow[a].move.wait >= _arrow[a].move.waitMax)
										{
											if (_arrow[a].move.xOffset < _arrow[a].move.xOffsetMax)
												_arrow[a].move.xOffset += _arrow[a].move.xSpd;
											else
												_arrow[a].move.xOffset = 0;
											_arrow[a].move.wait = 0;
										}
										else
											lvl[l].option[o].value.arrow[a].move.wait += 1;
									}
									else
										_arrow[a].move.xOffset = 0;
									if (_arrow[a].act == true)
									{
										var _arrow_x = round(_val_x + (((fn_textdata_width(_val.text) / 2) + _arrow[a].xGap + (_arrow[a].move.xOffset * _arrow[a].move.act)) * _arrow[a].xSign));
										var _arrow_y = _val_y;
										var _arrow_cols = [global.user.theme[global.user.theme_curr].color.whiteLight, global.user.theme[global.user.theme_curr].color.whiteLight];
										fn_draw_text(_arrow[a].text, _arrow_x, _arrow_y, _arrow_cols, (_arrow[a].alpha * lvl[l].alpha), _arrow[a].scale, _arrow[a].scale, fa_center, fa_middle, _shdw_cols, _shdw_alp);
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
