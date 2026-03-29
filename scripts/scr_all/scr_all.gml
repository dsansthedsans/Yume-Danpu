
//////// Functions that are basic for the game to work

// Window
function fn_wnd_name(_text)
{
	if (_text == global.config.name)
	{
		if (irandom_range(1, 100) <= 5)
			_text = choose("Danpu Nikki", "Yume Nikki", "Yume Dapnu", "Yume Danpy", "Yume Dangu", "Yume Fanpu", "Dume Yanpu", "Yume Champu", "Yummy Danpu", "Yummy Nicky", "Yum Dnampy", "Yume Dhanpy");
	}
	window_set_caption(_text);
}

// Objects
function fn_obj_create(_asset = id, _x = 0, _y = 0, _varStruct = {})
{
	obj_id = instance_create_layer(_x, _y, "Instances", _asset, _varStruct);
	return obj_id;
}
function fn_obj_destroy(_asset = id)
{
	instance_destroy(_asset);
}
function fn_obj_exists(_asset)
{
	return instance_exists(_asset);
}
function fn_obj_img(_asset = id, _spd = 0, _idx = 0, _color = c_white, _alpha = 1, _xScale = 1, _yScale = 1, _angle = 0)
{
	with (_asset)
	{
		image_speed = _spd;
		image_index = _idx;
		image_blend = _color;
		image_alpha = _alpha;
		image_xscale = _xScale;
		image_yscale = _yScale;
		image_angle = _angle;
	}
}
function fn_obj_depth(_asset = id, _val = -_asset.y)
{
	_asset.depth = _val;
}

// Drawing
	// Text
function fn_draw_text(_text, _x, _y, _color_0, _color_1, _alpha = 1, _xScale = 1, _yScale = 1, _xAlign = fa_left, _yAlign = fa_top, _shadow_color = global.user.thm[global.user.thm_curr].color.blackDark, _shadow_alpha = 1)
{
	var _fnt = global.config.lang[global.config.lang_curr].fnt;
	if (font_exists(_fnt) == true)
	{
		draw_set_font(_fnt);
		draw_set_halign(_xAlign);
		draw_set_valign(_yAlign);
		
		_shadow_alpha = (_alpha * _shadow_alpha * global.user.thm[global.user.thm_curr].alpha.shadow);
		draw_text_ext_transformed_color((_x + 1), (_y + 1), _text, -1, 640, _xScale, _yScale, 0, _shadow_color, _shadow_color, _shadow_color, _shadow_color, _shadow_alpha);
		
		draw_text_ext_transformed_color(_x, _y, _text, -1, 640, _xScale, _yScale, 0, _color_0, _color_0, _color_1, _color_1, _alpha);
	}
}
	// Rectangles
function fn_draw_rect(_x, _y, _weight, _height, _color_0, _color_1, _color_2, _color_3, _alpha)
{
	draw_sprite_general(spr_px, 0, 0, 0, 1, 1, _x, _y, _weight, _height, 0, _color_0, _color_1, _color_2, _color_3, _alpha);
}
	// Circles
function fn_draw_circle(_x, _y, _radius, _precision)
{
	draw_set_circle_precision(_precision);
	draw_circle(_x, _y, _radius, false);
}
	// Sprites
function fn_draw_spr(_spr, _img, _x, _y, _color = c_white, _alpha = 1, _xScale = 1, _yScale = _xScale, _angle = 0, _shadow_act = false, _shadow_color = global.user.thm[global.user.thm_curr].color.blackDark)
{
	if (_spr != -1)
	{
		if (_shadow_act == true)
		{
			var _shadow_alpha = (global.user.thm[global.user.thm_curr].alpha.shadow * _alpha);
			draw_sprite_ext(_spr, _img, (_x + 1), (_y + 1), _xScale, _yScale, _angle, _shadow_color, _shadow_alpha);
		}
		draw_sprite_ext(_spr, _img, _x, _y, _xScale, _yScale, _angle, _color, _alpha);
	}
	else
		fn_log("The function fn_draw_spr() was called with an invalid sprite ID");
}
function fn_draw_spr_stretch(_spr, _img, _x, _y, _width, _height, _color = c_white, _alpha = 1)
{
	if (_spr != -1)
	{
		draw_sprite_stretched_ext(_spr, _img, _x, _y, _width, _height, _color, _alpha);
	}
	else
		fn_log("The function fn_draw_spr_stretch() was called with an invalid sprite ID");
}
function fn_draw_spr_part(_spr, _img, _x, _y, _lt, _top, _width, _height, _color = c_white, _alpha = 1, _xScale = 1, _yScale = _xScale)
{
	if (_spr != -1)
		draw_sprite_part_ext(_spr, _img, _lt, _top, _width, _height, _x, _y, _xScale, _yScale, _color, _alpha);
	else
		fn_log("The function fn_draw_spr_part() was called with an invalid sprite ID");
}
	// Lines
function fn_draw_line(_x1, _y1, _x2, _y2, _color = c_white, _alpha = 1, _thickness = 1)
{
	draw_set_color(_color);
	draw_set_alpha(_alpha);
	draw_line_width(_x1, _y1, _x2, _y2, _thickness);
}

// Audio
function fn_aud_play(_asset, _emtr, _vol = 1, _ofs = 0, _pch = 1, _loops = false) // Plays the specified audio
{
	var _id = audio_play_sound(_asset, 0, false);
	fn_aud_vol(_asset, _id, _emtr, _vol);
	fn_aud_ofs(_asset, _id, _ofs);
	fn_aud_pch(_asset, _id, _pch);
	audio_sound_loop(_id, _loops);
	
	return _id;
}
function fn_aud_stop(_id) // Stops the audio with the specified ID (or asset)
{
	audio_stop_sound(_id);
}

	// Volume
function fn_aud_vol(_asset, _id, _emtr, _vol = 1)
{
	_vol = fn_aud_volData(_asset, _vol);
	_vol *= global.config.aud.emtr[_emtr].vol;
	_vol *= global.config.aud.emtr[CONFIG_AUD_EMTR.MASTER].vol;
	audio_sound_gain(_id, _vol, 0);
}
function fn_aud_volData(_asset, _vol)
{
	// _vol MUST ONLY BE MULTIPLIED, NOT ADDED or SUBTRACTED
	
	switch (_asset)
	{
		// Player
		case snd_user_fstep:
			_vol *= 0.75;
			break;
		
			// Themes
				// Default theme
		case snd_user_thm_move_dflt: // The sound that should be used as reference for all others
			_vol = 1;
			break;
		case snd_user_thm_confirm_dflt:
			_vol *= 1.35;
			break;
		case snd_user_thm_cancel_dflt:
			_vol *= 0.9;
			break;
		case snd_user_thm_unlock_0_dflt:
		case snd_user_thm_unlock_1_dflt:
		case snd_user_thm_unlock_2_dflt:
			_vol *= 0.45;
			break;
		case snd_user_thm_equip_0_dflt:
		case snd_user_thm_equip_1_dflt:
			_vol *= 0.65;
			break;
				// Madotsuki theme
		case snd_user_thm_move_madot:
			_vol *= 0.4;
			break;
		case snd_user_thm_confirm_madot:
			_vol *= 0.2;
			break;
		case snd_user_thm_cancel_madot:
			_vol *= 0.2;
			break;
		case snd_user_thm_error_madot:
			_vol *= 0.4;
			break;
		
			// Items
		case snd_user_fcn_kart:
			_vol *= 0.5;
			break;
		case snd_user_fcn_kart_turn:
			_vol *= 0.35;
			break;
		case snd_user_fcn_kart_hit:
			_vol *= 0.65;
			break;
		
		
		// Props
		case snd_hulapoca:
			_vol *= 1.25;
			break;
		case snd_penyplocde:
			_vol *= 1.25;
			break;
		case snd_ponkawonka:
			_vol *= 1.25;
			break;
		case snd_prop_noise_weird:
			_vol *= 1.5;
			break;
		
		
		// Main menu
		case mus_menu_home:
			_vol *= 0.45;
			break;
		
		
		// Nexus
		case mus_nexus:
			_vol *= 0.35;
			break;
		
		
		// Macacolandia
		case mus_macaco:
			_vol *= 0.25;
			break;
		case snd_actor_macaco_monkey_0:
			_vol *= 0.5;
			break;
		case snd_actor_macaco_monkey_2:
			_vol *= 0.3;
			break;
		case snd_actor_macaco_monkey_3:
			_vol *= 0.85;
			break;
		case snd_actor_macaco_monkey_4:
			_vol *= 0.65;
			break;
		case snd_actor_macaco_monkey_5:
			_vol *= 0.5;
			break;
		case snd_actor_macaco_monkey_6:
			_vol *= 0.35;
			break;
		
		
		// Debug World
		case mus_dbgwrld:
			_vol *= 0.75;
			break;
	}
	
	return _vol;
	// one of the WORST fucking FUNCTIONS i've EVER made in my LIFE.  Jesus       !!!!!
}

	// Offset
function fn_aud_ofs(_asset, _id, _ofs = 0)
{
	_ofs = fn_aud_ofsData(_asset, _ofs);
	audio_sound_set_track_position(_id, _ofs);
}
function fn_aud_ofsData(_asset, _ofs)
{
	// _ofs MUST ONLY BE ADDED, NOT SUBTRACTED or MULTIPLIED
	
	switch (_asset)
	{
		// Player
			// Themes
				// Default theme
		case snd_user_thm_start_dflt:
			_ofs += 0.15;
			break;
		
		
		// Macacolandia citizens
		case snd_actor_macaco_monkey_0:
			_ofs += 0.25;
			break;
		case snd_actor_macaco_monkey_1:
			_ofs += 0.25;
			break;
		case snd_actor_macaco_monkey_3:
			_ofs += 0.25;
			break;
		case snd_actor_macaco_monkey_6:
			_ofs += 0.25;
			break;
	}
	
	return _ofs;
	// one of the WORST fucking FUNCTIONS i've EVER made in my LIFE Part II: The Hype Never Dies.  Jesus       !!!!!
}

	// Pitch
function fn_aud_pch(_asset, _id, _pch = 1)
{
	_pch = fn_aud_pchData(_asset, _pch);
	audio_sound_pitch(_id, _pch);
}
function fn_aud_pchData(_asset, _pch)
{
	// _pch MUST ONLY BE ADDED or SUBTRACTED, NOT MULTIPLIED
	
	//switch (_asset)
	//{
		
	//}
	
	return _pch;
	// one of the WORST fucking FUNCTIONS i've EVER made in my LIFE Part III: The Final Chapter.  Jesus       !!!!!
}


// Functions related to sprites
function fn_spr_width(_asset) // Returns the width of the specified sprite
{
	if (_asset != -1)
		return sprite_get_width(_asset);
	else
	{
		fn_log("The function fn_spr_width() was called with an invalid sprite asset");
		return 0;
	}
}
function fn_spr_height(_asset) // Returns the height of the specified sprite
{
	if (_asset != -1)
		return sprite_get_height(_asset);
	else
	{
		fn_log("The function fn_spr_height() was called with an invalid sprite asset");
		return 0;
	}
}


// Functions related to text
function fn_text_width(_text) // Returns the width of the specified text
{
	var _fnt = global.config.lang[global.config.lang_curr].fnt;
	if (font_exists(_fnt) == true)
	{
		draw_set_font(_fnt);
		return string_width(_text);
	}
	else
		return 0;
}
function fn_text_height(_text) // Returns the height of the specified text
{
	var _fnt = global.config.lang[global.config.lang_curr].fnt;
	if (font_exists(_fnt) == true)
	{
		draw_set_font(_fnt);
		return string_height(_text);
	}
	else
		return 0;
}

function fn_textdata_width(_text) // Returns the width of the specified textdata
{
	return fn_text_width(textdata(_text));
}
function fn_textdata_height(_text) // Returns the height of the specified textdata
{
	return fn_text_height(textdata(_text));
}


// Functions related to math
function fn_lerp(_valCur, _valTgt, _spd)
{
	return lerp(_valCur, _valTgt, _spd);
}
function fn_lerp_col(_colCur, _colTgt, _spd)
{
	var _colCur_hue = color_get_hue(_colCur);
	var _colCur_sat = color_get_saturation(_colCur);
	var _colCur_vAl = color_get_value(_colCur);
	
	var _colTgt_hue = color_get_hue(_colTgt);
	var _colTgt_sat = color_get_saturation(_colTgt);
	var _colTgt_vAl = color_get_value(_colTgt);
	
	var _col_hue = fn_lerp(_colCur_hue, _colTgt_hue, _spd);
	var _col_sat = fn_lerp(_colCur_sat, _colTgt_sat, _spd);
	var _col_vAl = fn_lerp(_colCur_vAl, _colTgt_vAl, _spd);
	
	return make_color_hsv(_col_hue, _col_sat, _col_vAl);
}


// Other functions
function fn_log(_msg) // Sends a message to the log
{
	show_debug_message($"[{current_time}]  [{object_get_name(object_index)}]  {_msg}");
}




//  MISERABLE.  I AM MISERABLE.  THAT'S WHAT I AM. MISERABLE.  BUT DON'T CALL ME THAT. DON'T CALL ME MISERABLE.  BECAUSE.  THAT WILL MAKE ME.  EVEN MORE.  MISERABLE.
