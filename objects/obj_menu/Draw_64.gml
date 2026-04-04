
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
			// Rectangles
			if (is_array(lvl[l].rect) == true)
			{
				for (var r = 0; r < array_length(lvl[l].rect); r++)
				{
					var _rect = lvl[l].rect[r];
					if (_rect.x != undefined && _rect.y != undefined && _rect.weight != undefined && _rect.height != undefined)
						fn_draw_rect(_rect.x, _rect.y, _rect.weight, _rect.height, _rect.color, _rect.color, _rect.color, _rect.color, (_rect.alpha * lvl[l].alpha));
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
						var _panel_x = round(_panel.x);
						var _panel_y = round(_panel.y);
						var _panel_img = 0;
						
							// Title
						if (is_struct(_panel.title) == true && _panel.title.spr != undefined)
						{
							_panel_img = 1;
							var _title = _panel.title;
							var _title_y = round(_panel_y - _title.height);
							fn_draw_spr_stretch(_title.spr, 0, _panel_x, _title_y, _panel.width, _title.height, , (_panel.alpha * lvl[l].alpha));
							
								// Label
							if (_title.label.text != undefined)
							{
								var _label = _title.label;
								var _label_x = round(_panel_x + _title.label.xMarg);
								var _label_y = round(_panel_y - (_panel.title.height / 2) - (fn_text_height("Salenis") / 2) + 1);
								fn_draw_text(textdata(_title.label.text), _label_x, _label_y, _label.color[0], _label.color[1], (_label.alpha * _panel.alpha * lvl[l].alpha), , , , , , _label.shadow_alpha);
							}
						}
						
						// Panel
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
					{
						var _label_x = round(_label.x);
						var _label_y = round(_label.y);
						
							// Icon
						if (is_struct(_label.icon) == true && _label.icon.spr != -1)
						{
							var _icon = _label.icon;
							var _icon_xGap = ((_icon.xGap != undefined) ? _icon.xGap : fn_menu_lvl_label_icon_xGap_getDflt(l, a));
							var _icon_x = round((_icon.x != undefined) ? _icon.x : (_label_x - _icon_xGap));
							var _icon_y = round((_icon.y != undefined) ? _icon.y : (_label_y + round(fn_textdata_height(_label.text) / 2) - round(fn_spr_height(_icon.spr) / 2) + 1));
							fn_draw_spr(_icon.spr, _icon.img, _icon_x, _icon_y, _icon.color, (_icon.alpha * lvl[l].alpha), , , , true);
						}
						
						// Label
						fn_draw_text(textdata(_label.text), _label_x, _label_y, _label.color[0], _label.color[1], lvl[l].alpha, , , _label.xAlign, _label.yAlign);
					}
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
						var _opt_x = round(_opt.x);
						var _opt_y = round(_opt.y);
						var _opt_shadow_col = ((o == lvl[l].option_curr) ? global.user.thm[global.user.thm_curr].color.blackLight : global.user.thm[global.user.thm_curr].color.blackDark);
						
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
							var _select = _opt.select;
							_select.alpha = fn_lerp(_select.alpha, _select.alphaTgt[(o == lvl[l].option_curr)], ((global.config.access.rdcdMot.act == false) ? _select.alphaSpd : 1));
							if (_select.alpha > 0)
							{
								var _select_x = round((_select.x != 0) ? _select.x : (_opt_x - _select.xDist));
								var _select_y = round((_select.y != 0) ? _select.y : (_opt_y - _select.yDist + 1));
								var _select_width = round((_select.width != 0) ? _select.width : ((_select.xDist * 2) + fn_textdata_width(_opt.text)));
								var _select_height = round((_select.height != 0) ? _select.height : ((_select.yDist * 2) + fn_textdata_height(_opt.text)));
								if (is_struct(_opt.icon) == true && _opt.icon.spr != -1)
								{
									var _icon_xGap = round((_opt.icon.xGap != 0) ? _opt.icon.xGap : fn_menu_lvl_option_icon_xGap_getDflt(l, o));
									_select_x -= _icon_xGap;
									_select_width += _icon_xGap;
								}
								fn_draw_spr_stretch(_select.spr, _select.img, _select_x, _select_y, _select_width, _select_height, , (_select.alpha * lvl[l].alpha));
							}
						}
						
							// Icon
						if (is_struct(_opt.icon) == true && _opt.icon.spr != -1)
						{
							var _icon = _opt.icon;
							var _icon_xGap = round((_icon.xGap != 0) ? _icon.xGap : fn_menu_lvl_option_icon_xGap_getDflt(l, o));
							var _icon_x = round((_icon.x != 0) ? _icon.x : (_opt_x - _icon_xGap));
							var _icon_y = round((_icon.y != 0) ? _icon.y : (_opt_y + round(fn_textdata_height(_opt.text) / 2) - round(fn_spr_height(_icon.spr) / 2) + 1));
							fn_draw_spr(_icon.spr, _icon.img, _icon_x, _icon_y, _icon.color[(o == lvl[l].option_curr)], (_icon.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha), , , , true, _opt_shadow_col);
						}
						
							// Checkbox
						if (is_struct(_opt.check) == true && _opt.check.spr != undefined)
						{
							var _check = _opt.check;
							var _check_x = round((_check.x != 0) ? _check.x : (_opt_x - _check.xPad - fn_spr_width(_check.spr)));
							var _check_y = round((_check.y != 0) ? _check.y : (_opt_y + round(fn_textdata_height(_opt.text) / 2) - round(fn_spr_height(_check.spr) / 2) + 1));
							fn_draw_spr(_opt.check.spr, 0, _check_x, _check_y, _check.color, (_check.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha));
							
							// Mark
							if (_opt.check.mark.act == true)
							{
								var _mark = _opt.check.mark;
								var _mark_x = round((_mark.x != 0) ? _mark.x : _check_x);
								var _mark_y = round((_mark.y != 0) ? _mark.y : _check_y);
								fn_draw_spr(_mark.spr, 0, _mark_x, _mark_y, , (_mark.alpha[(o == lvl[l].option_curr)] * lvl[l].alpha));
							}
						}
						
						// Option
						fn_draw_text(textdata(_opt.text), _opt_x, _opt_y, _opt.color[(o == lvl[l].option_curr), 0], _opt.color[(o == lvl[l].option_curr), 1], lvl[l].alpha, , , _opt.xAlign, _opt.yAlign, _opt_shadow_col);
						
							// Value (the text beside the options in the settings menu, like "Yes", "No" and "100%")
						if (is_struct(_opt.value) == true && _opt.value.text != "")
						{
							var _val = _opt.value;
							var _val_x = round((_val.x != 0) ? _val.x : (_opt_x + fn_textdata_width(_opt.text) + _opt.value.xGap + (fn_textdata_width(_val.text) / 2)));
							var _val_y = round((_val.y != 0) ? _val.y : (_opt_y + ceil(fn_textdata_height("Salenis") / 2)));
							var _val_col = [-1];
							_val.colorVal = fn_lerp(_val.colorVal, _val.colorValTgt[false], _val.colorValSpd);
							for (var c = 0; c < 2; c++)
								_val_col[c] = make_colour_hsv(colour_get_hue(_val.color[c]), colour_get_saturation(_val.color[c]), (colour_get_value(_val.color[c]) + _val.colorVal));
							_val.scale = fn_lerp(_val.scale, _val.scaleTgt[false], _val.scaleSpd);
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
										var _arrow_y = (_val_y /*+ (fn_text_height(_arrow[a].text) / 2)*/)
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
