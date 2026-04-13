
//////// Functions related to the menu system


// Levels
function fn_menu_lvl_add(_idx)
{
	lvl[_idx] =
	{
		alpha : 0,
		// Rectangles
		rect : undefined, 
		// Triangle trains
		train : undefined,
		// Panels
		panel : undefined,
		// Cards
		card : undefined,
		// Labels
		label : undefined,
		// Decorations
		decor : undefined,
		// Options
		option : undefined,
		option_curr : 0,
			// Movement
		option_move :
		{
			act : true,
			snd : global.user.thm[global.user.thm_curr].snd.move,
			list : // List type
			{
				act : true,
				key : [CONFIG_KEY.UP, CONFIG_KEY.DN]
			},
			table : // Table type
			{
				act : false
			}
		},
			// Confirmation
		option_confirm :
		{
			act : true,
			key : CONFIG_KEY.CONFIRM,
			snd : global.user.thm[global.user.thm_curr].snd.confirm
		},
			// Cancellation
		option_cancel :
		{
			act : true,
			key : [CONFIG_KEY.CANCEL, undefined],
			snd : global.user.thm[global.user.thm_curr].snd.cancel
		}
	}
}

	// Fade transition
function fn_menu_lvl_fader_start(_next_lvl, _next_snd = undefined, _next_destroy = false, _next_endgame = false, _next_wait_dur = 0, _prev_snd = undefined)
{
	lvl_fader =
	{
		stg : 0, // ID number of the current stage of the fade transition
		alpTgt : 1, // Alpha target (the value that alpha will change to)
		alpSpd : 0.2, // Alpha speed (speed at which the alpha changes during the fade transition) (1 == instantaneous)
		alpJump : 0.05, // Alpha jump (if the difference between the current alpha and the target alpha reaches this value, the current alpha will jump to the target alpha)
		// Previous level
		prev :
		{
			snd : _prev_snd,
		},
		// Next level
		next :
		{
			lvl : _next_lvl,
			snd : _next_snd,
			destroy : _next_destroy,
			endgame : _next_endgame,
			wait_dur : _next_wait_dur,
		}
	}
}

	// Rectangles
function fn_menu_lvl_rect_add(_lvl, _idx, _x = undefined, _y = undefined, _weight = undefined, _height = undefined, _color = c_black, _alpha = 1)
{
	lvl[_lvl].rect[_idx] =
	{
		x : _x,
		y : _y,
		weight : _weight,
		height : _height,
		color : _color,
		alpha : _alpha,
	}
}

	// Triangle trains
function fn_menu_lvl_train_add(_lvl, _idx, _x = undefined, _y = undefined, _xSpd = 0, _ySpd = 0, _angle = 0, _alpha = 1)
{
	var l = _lvl;
	var t = _idx;
	
	lvl[l].train[t] =
	{
		spr : spr_menu_lvl_train,
		x : _x,
		y : _y,
		xSpd : _xSpd,
		ySpd : _ySpd,
		xOfs : 0,
		yOfs : 0,
		color : global.user.thm[global.user.thm_curr].color.grayDark,
		alpha : _alpha,
		angle : _angle
	}
}

	// Panels
function fn_menu_lvl_panel_add(_lvl, _idx, _x = undefined, _y = undefined, _width = undefined, _height = undefined, _alpha = 1)
{
	var l = _lvl;
	var p = _idx;
	
	lvl[l].panel[p] =
	{
		spr : global.user.thm[global.user.thm_curr].spr.panel,
		img : 0,
		x : _x,
		y : _y,
		width : _width,
		height : _height,
		alpha : _alpha,
		// Title
		title : undefined
	}
}
function fn_menu_lvl_panel_title_add(_lvl, _idx, _title_label_text = undefined)
{
	var l = _lvl;
	var p = _idx;
	lvl[l].panel[p].title =
	{
		spr : global.user.thm[global.user.thm_curr].spr.panel_title,
		height : (fn_text_height("Salenis") + 4),
		label :
		{
			text : _title_label_text,
			xMarg : 7,
			color : [global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.whiteDark],
			alpha : 0.5,
			shadow_alpha : 0,
		}
	}
}

	// Cards
function fn_menu_lvl_card_add(_lvl, _idx, _x = undefined, _y = undefined, _width = undefined, _height = undefined)
{
	var l = _lvl;
	var c = _idx;
	
	lvl[l].card[c] =
	{
		spr :  global.user.thm[global.user.thm_curr].spr.card,
		img : 0,
		
		x : _x,
		y : _y,
		width : _width,
		height : _height
	}
}

	// Labels
function fn_menu_lvl_label_add(_lvl, _idx, _text = undefined, _x = undefined, _y = undefined, _color = [global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.whiteLight], _xAlign = fa_left, _yAlign = fa_top)
{
	var l = _lvl;
	var a = _idx;
	
	lvl[l].label[a] =
	{
		text : _text,
		x : _x,
		y : _y,
		color : _color,
		xAlign : _xAlign,
		yAlign : _yAlign,
		// Icon
		icon : undefined,
	}
}
function fn_menu_lvl_label_icon_add(_lvl, _idx, _spr = undefined, _img = 0)
{
	var l = _lvl;
	var a = _idx;
	lvl[l].label[a].icon =
	{
		spr : _spr,
		img : _img,	
		x : undefined,
		y : undefined,
		xGap : undefined,
		color : c_white,
		alpha : 1,
	}
}
function fn_menu_lvl_label_icon_xGap_getDflt(_lvl, _idx)
{
	return (fn_spr_width(lvl[_lvl].label[_idx].icon.spr) + 5)
}

	// Decorations
function fn_menu_lvl_decor_add(_lvl, _idx, _spr = undefined, _img = 0, _x = undefined, _y = undefined, _color = c_white, _alpha = 1)
{
	var l = _lvl;
	var d = _idx;
	
	lvl[l].decor[d] =
	{
		spr : _spr,
		img : _img,
		
		x : _x,
		y : _y,
		
		color : _color,
		alpha : _alpha
	}
}

	// Options
function fn_menu_lvl_option_add(_lvl, _idx, _text = undefined, _x = undefined, _y = undefined, _select_act = true)
{	
	var l = _lvl;
	var o = _idx;
	lvl[l].option[o] =
	{
		text : _text,
		x : _x,
		y : _y,
		color :
		[
			[global.user.thm[global.user.thm_curr].color.grayLight, global.user.thm[global.user.thm_curr].color.grayDark], // Inactive (Unselected)
			[global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.whiteDark] // Active (Selected)
		],
		xAlign : fa_left,
		yAlign : fa_top,
		// Selection indicator
		select :
		{
			act : _select_act,
			spr : global.user.thm[global.user.thm_curr].spr.option_select,
			img : 0,
			x : 0,
			y : 0,
			xDist : 4,
			yDist : 2,
			width : 0,
			height : 0,
			alpha : 0,
			alphaTgt : [0 /* Inactive (Unselected) */, 1 /* Active (Selected) */],
			alphaSpd : 0.5,
		},
		// Checkbox
		check : undefined,
		// Value label (the text beside the options in the settings menu, like "Yes", "No" and "100%")
		value : undefined,
		// Icon
		icon : undefined,
		// Button
		button : undefined,
	}
}
function fn_menu_lvl_option_getWidthMax(_lvl)
{
	var l = _lvl;
	var _widthMax = 0;
	for (var o = 0; o < array_length(lvl[l].option); o++)
		_widthMax = max(_widthMax, fn_text_width(textdata(lvl[l].option[o].text)));
	return _widthMax;
}

		// Value (the text beside the options in the settings menu, like "Yes", "No" and "100%")
function fn_menu_lvl_option_value_add(_lvl, _idx, _xGap = 32)
{
	var l = _lvl;
	var o = _idx;
	lvl[l].option[o].value =
	{
		text : "Salenis",
		x : 0,
		y : 0,
		xGap : _xGap,
		color : [global.user.thm[global.user.thm_curr].color.grayLight, global.user.thm[global.user.thm_curr].color.grayDark],
		colorVal : 0,
		colorValTgt : [0 /* Inactive (Not cycling) */, 150 /* Active (Cycling) */],
		colorValSpd : 0.2,
		alpha : [0.5 /* Inactive (Unselected) */, 1 /* Active (Selected) */],
		scale : 1,
		scaleTgt : [1 /* Inactive (Not cycling) */, 1.2 /* Active (Cycling) */],
		scaleSpd : 0.2,
		xAlign : fa_center,
		yAlign : fa_middle,
		
		arrow : -1, // Arrows
	}
		// Arrows
	for (var a = 0; a < 2; a++)
	{
		lvl[l].option[o].value.arrow[a] =
		{
			act : true,
			key : ((a == 0) ? CONFIG_KEY.LT : CONFIG_KEY.RT),
			text : ((a == 0) ? "<" : ">"),
			xGap : 10,
			xSign : ((a == 0) ? -1 : 1),
			color : [global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.whiteLight],
			alpha : 0.5,
			alphaTgt : [0.5 /* Inactive (Not cycling) */, 1.5 /* Active (Cycling) */],
			alphaSpd : 0.1,
			scale : 1,
			scaleTgt : [1 /* Inactive (Not cycling) */, 2 /* Active (Cycling) */],
			scaleSpd : 0.2,
			
			// Movement
			move :
			{
				act : true,
				xSpd : 1,
				xOfs : 0,
				xOfsMAX : 2,
				wait : 0,
				waitMax : 12
			}
		}
	}
	
	
	event_user(3);
}
function fn_menu_lvl_option_value_getWidthMax(_lvl)
{
	var l = _lvl;
	var _widthMax = 0;
	for (var o = 0; o < array_length(lvl[l].option); o++)
	{
		var _opt = lvl[l].option[o];
		if (_opt.value != -1)
			_widthMax = max(_widthMax, fn_text_width(textdata(lvl[l].option[o].value.text)));
	}
	return _widthMax;
}

		// Icon
function fn_menu_lvl_option_icon_add(_lvl, _idx, _spr = undefined, _img = 0)
{
	var l = _lvl;
	var o = _idx;
	lvl[l].option[o].icon =
	{
		spr : _spr,
		img : _img,
		x : 0,
		y : 0,
		xGap : 0,
		color : [c_gray /* Inactive (Unselected) */, c_white /* Active (Selected) */],
		alpha : [1 /* Inactive (Unselected) */, 1 /* Active (Selected) */]
	}
}
function fn_menu_lvl_option_icon_xGap_getDflt(_lvl, _idx)
{
	return (fn_spr_width(lvl[_lvl].option[_idx].icon.spr) + 5)
}

		// Checkbox
function fn_menu_lvl_option_check_add(_lvl, _idx)
{
	var l = _lvl;
	var o = _idx;
	
	lvl[l].option[o].check =
	{
		spr : global.user.thm[global.user.thm_curr].spr.option_check,
			
		x : 0,
		y : 0,
		xPad : (16 / 2),
			
		color : c_white,
		alpha : [0.35 /* Inactive (Unselected) */, 1 /* Active (Selected) */],
		
		// Mark
		mark :
		{
			act : false,
			spr : global.user.thm[global.user.thm_curr].spr.option_check_mark,
			
			x : 0,
			y : 0,
			
			alpha : [0.5 /* Inactive (Unselected) */, 1 /* Active (Selected) */]
		}
	}
}

		// Button
function fn_menu_lvl_option_button_add(_lvl, _idx)
{
	var l = _lvl;
	var o = _idx;
	lvl[l].option[o].button =
	{
		spr : global.user.thm[global.user.thm_curr].spr.option_button,
		img_inact : 0, // image_index while inactive (unselected)
		img_act : 1, // image_index while active (selected)
		x : 0,
		y : 0,
		xPad : 6,
		yPad : 3,
		width : 0,
		height : 0,
	}
}
