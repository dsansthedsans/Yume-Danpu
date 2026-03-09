
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
			// Triangle trains
			if (is_array(lvl[l].train) == true)
			{
				for (var t = 0; t < array_length(lvl[l].train); t++)
				{
					var _train = lvl[l].train[t];
					if (_train.x != undefined && _train.x != undefined)
					{
						var _train_xGap = lengthdir_x(fn_spr_width(_train.spr), _train.angle);
						var _train_yGap = lengthdir_y(fn_spr_height(_train.spr), _train.angle);
						_train.xOfs += _train.xSpd;
						_train.yOfs += _train.ySpd;
						if (abs(_train.xOfs) >= abs(_train_xGap)) || (global.config.access.rdcdMot.act == true)
							_train.xOfs = 0;
						if (abs(_train.yOfs) >= abs(_train_yGap)) || (global.config.access.rdcdMot.act == true)
							_train.yOfs = 0;
						for (var c = 0; c < 21; c++)
							fn_draw_spr(_train.spr, 0, (_train.x + _train.xOfs + (_train_xGap * c)), (_train.y + _train.yOfs + (_train_yGap * c)), _train.color, (_train.alpha * lvl[l].alpha), , , _train.angle);
					}
				}
			}
			
			// Panels
			if (is_array(lvl[l].panel) == true)
			{
				for (var p = 0; p < array_length(lvl[l].panel); p++)
				{
					var _panel = lvl[l].panel[p];
					if (_panel.spr != undefined && _panel.x != undefined && _panel.y != undefined && _panel.width != undefined && _panel.height != undefined)
					{
						var _panel_img = 0;
						if (is_struct(_panel.title) == true && _panel.title.spr != undefined && _panel.title.label.text != undefined)
						{
							_panel_img = 1;
							var _title = _panel.title;
							var _title_label_x = round(_panel.x + _title.label.xMarg);
							var _title_label_y = round(_panel.y - (_panel.title.height / 2) - (fn_text_height("Salenis") / 2) + 1);
							fn_draw_spr_stretch(_title.spr, 0, round(_panel.x), round(_panel.y - _panel.title.height), _panel.width, _panel.title.height, , (_panel.alpha * lvl[l].alpha));
							fn_draw_text(textdata(_title.label.text), _title_label_x, _title_label_y, _panel.title.label.color[0], _panel.title.label.color[1], (_title.label.alpha * _panel.alpha * lvl[l].alpha), , , , , , _title.label.shadow_alpha);
						}
						fn_draw_spr_stretch(_panel.spr, _panel_img, round(_panel.x), round(_panel.y), _panel.width, _panel.height, , (_panel.alpha * lvl[l].alpha));
					}
				}
			}
			
			// Cards
			if (is_array(lvl[l].card) == true)
			{
				for (var c = 0; c < array_length(lvl[l].card); c++)
				{
					var _card = lvl[l].card[c];
					if (_card.spr != undefined && _card.x != undefined && _card.y != undefined && _card.width != undefined && _card.height != undefined)
						fn_draw_spr_stretch(_card.spr, _card.img, round(_card.x), round(_card.y), _card.width, _card.height, , lvl[l].alpha);
				}
			}
			
			// Labels
			if (is_array(lvl[l].label) == true)
			{
				for (var a = 0; a < array_length(lvl[l].label); a++)
				{
					var _label = lvl[l].label[a];
					if (_label.text != undefined && _label.x != undefined && _label.y != undefined)
						fn_draw_text(textdata(_label.text), round(_label.x), round(_label.y), _label.color[0], _label.color[1], lvl[l].alpha, , , _label.xAlign, _label.yAlign);
				}
			}
			
			// Decorations
			if (is_array(lvl[l].decor) == true)
			{
				for (var d = 0; d < array_length(lvl[l].decor); d++)
				{
					var _decor = lvl[l].decor[d];
					if (_decor.spr != undefined && _decor.x != undefined && _decor.y != undefined)
						fn_draw_spr(_decor.spr, _decor.img, round(_decor.x), round(_decor.y), _decor.color, (_decor.alpha * lvl[l].alpha));
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
						var _opt_shadow_col = ((o == lvl[l].option_curr) ? global.player.thm[global.player.thm_curr].color.blackLight : global.player.thm[global.player.thm_curr].color.blackDark);
						
							// Button
						if (is_struct(_opt.button) == true)
						{
							var _button_x = round((_opt.button.x != 0) ? _opt.button.x : (_opt.x - _opt.button.xPad));
							var _button_y = round((_opt.button.y != 0) ? _opt.button.y : (_opt.y - _opt.button.yPad));
							var _button_width = round((_opt.button.width != 0) ? _opt.button.width : ((_opt.button.xPad * 2) + fn_textdata_width(_opt.text)));
							var _button_height = round((_opt.button.height != 0) ? _opt.button.height : ((_opt.button.yPad * 2) + fn_textdata_height(_opt.text) + 2));
							fn_draw_spr_stretch(_opt.button.spr, ((o != lvl[l].option_curr) ? _opt.button.img_inact : _opt.button.img_act), _button_x, _button_y, _button_width, _button_height, , lvl[l].alpha);
						}
						
							// Selection indicator
						if (_opt.select.act == true && o == lvl[l].option_curr)
						{
							var _select_x = round((_opt.select.x != 0) ? _opt.select.x : (_opt.x - _opt.select.xDist));
							var _select_y = round((_opt.select.y != 0) ? _opt.select.y : (_opt.y - _opt.select.yDist + 1));
							var _select_width = round((_opt.select.width != 0) ? _opt.select.width : ((_opt.select.xDist * 2) + fn_textdata_width(_opt.text)));
							var _select_height = round((_opt.select.height != 0) ? _opt.select.height : ((_opt.select.yDist * 2) + fn_textdata_height(_opt.text)));
							if (is_struct(_opt.icon) == true && _opt.icon.spr != -1)
							{
								var _icon_xGap = round((_opt.icon.xGap != 0) ? _opt.icon.xGap : fn_menu_lvl_option_icon_xGap_getDflt(l, o));
								_select_x -= _icon_xGap;
								_select_width += _icon_xGap;
							}
							fn_draw_spr_stretch(_opt.select.spr, _opt.select.img, _select_x, _select_y, _select_width, _select_height, , lvl[l].alpha);
						}
						
							// Icon
						if (is_struct(_opt.icon) == true && _opt.icon.spr != -1)
						{
							var _icon_xGap = round((_opt.icon.xGap != 0) ? _opt.icon.xGap : fn_menu_lvl_option_icon_xGap_getDflt(l, o));
							var _icon_x = round((_opt.icon.x != 0) ? _opt.icon.x : (_opt.x - _icon_xGap));
							var _icon_y = round((_opt.icon.y != 0) ? _opt.icon.y : (_opt.y + round(fn_textdata_height(_opt.text) / 2) - round(fn_spr_height(_opt.icon.spr) / 2) + 1));
							var _icon_color = _opt.icon.color[(o == lvl[l].option_curr)];
							var _icon_alpha = (_opt.icon.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha);
							fn_draw_spr(_opt.icon.spr, _opt.icon.img, _icon_x, _icon_y, _icon_color, _icon_alpha, , , , true, _opt_shadow_col);
						}
						
							// Checkbox
						if (is_struct(_opt.check) == true && _opt.check.spr != undefined)
						{
							var _check_x = round((_opt.check.x != 0) ? _opt.check.x : (_opt.x - _opt.check.xPad - fn_spr_width(_opt.check.spr)));
							var _check_y = round((_opt.check.y != 0) ? _opt.check.y : (_opt.y + round(fn_textdata_height(_opt.text) / 2) - round(fn_spr_height(_opt.check.spr) / 2) + 1));
							fn_draw_spr(_opt.check.spr, 0, _check_x, _check_y, _opt.check.color, (_opt.check.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha));
							
							// Mark
							if (_opt.check.mark.act == true)
							{
								var _mark = _opt.check.mark;
								var _mark_x = round((_mark.x != 0) ? _mark.x : (_check_x));
								var _mark_y = round((_mark.y != 0) ? _mark.y : (_check_y));
								fn_draw_spr(_opt.check.mark.spr, 0, _mark_x, _mark_y, , (_opt.check.mark.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha));
							}
						}
						
						// Option
						var _opt_x = round(_opt.x);
						var _opt_y = round(_opt.y);
						fn_draw_text(textdata(_opt.text), _opt_x, _opt_y, _opt.color[(o == lvl[l].option_curr), 0], _opt.color[(o == lvl[l].option_curr), 1], lvl[l].alpha, , , _opt.xAlign, _opt.yAlign, _opt_shadow_col);
						
							// Value (the text beside the options in the settings menu, like "Yes", "No" and "100%")
						if (is_struct(_opt.value) == true && _opt.value.text != "")
						{
							var _val = _opt.value;
							var _val_x = round((_val.x != 0) ? _val.x : (_opt_x + fn_textdata_width(_opt.text) + _opt.value.xGap + (fn_textdata_width(_val.text) / 2)));
							var _val_y = round((_val.y != 0) ? _val.y : _opt_y);
							var _val_col = [-1];
							_val.colorVal = fn_lerp(_val.colorVal, _val.colorValTGT[false], _val.colorValSPD);
							for (var c = 0; c < 2; c++)
								_val_col[c] = make_colour_hsv(colour_get_hue(_val.color[c]), colour_get_saturation(_val.color[c]), (colour_get_value(_val.color[c]) + _val.colorVal));
							_val.scale = fn_lerp(_val.scale, _val.scaleTgt[(o == lvl[l].option_curr)], _val.scaleSpd);
							fn_draw_text(textdata(_val.text), _val_x, _val_y, _val_col[0], _val_col[1], (_val.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha), _val.scale, _val.scale, _val.xAlign, _val.yAlign);
							
								// Value's arrows
							if (o == lvl[l].option_curr && (_val.arrow[0].act == true || _val.arrow[1].act == true))
							{
								var _arrow = _val.arrow;
								for (var a = 0; a < 2; a++)
								{
									// Animates arrow
									_arrow[a].alpha = fn_lerp(_arrow[a].alpha, _arrow[a].alphaTgt[false], _arrow[a].alphaSpd);
									_arrow[a].scale = fn_lerp(_arrow[a].scale, _arrow[a].scaleTgt[false], _arrow[a].scaleSpd);
									if (_arrow[a].move.act == true && global.config.access.rdcdMot.act == false)
									{
										if (_arrow[a].move.wait >= _arrow[a].move.waitMax)
										{
											if (_arrow[a].move.xOfs < _arrow[a].move.xOfsMAX)
												_arrow[a].move.xOfs += _arrow[a].move.xSpd;
											else
												_arrow[a].move.xOfs = 0;
											_arrow[a].move.wait = 0;
										}
										else
											lvl[l].option[o].value.arrow[a].move.wait += 1;
									}
									else
										_arrow[a].move.xOfs = 0;
									
									// Draws arrow
									if (_arrow[a].act == true)
									{
										var _arrow_x = (_val_x + (((fn_textdata_width(_val.text) / 2) + _arrow[a].xGap + (_arrow[a].move.xOfs * _arrow[a].move.act)) * _arrow[a].xSign));
										var _arrow_y = (_val_y + (fn_text_height(_arrow[a].text) / 2))
										fn_draw_text(_arrow[a].text, _arrow_x, _arrow_y, _arrow[a].color[0], _arrow[a].color[1], (_arrow[a].alpha * lvl[l].alpha), _arrow[a].scale, _arrow[a].scale, fa_center, fa_middle);
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
