
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
function fn_obj_img(_asset = id, _spd = 0, _idx = 0, _color = c_white, _alpha = 1, _scaleX = 1, _scaleY = 1, _angle = 0)
{
	with (_asset)
	{
		image_speed = _spd;
		image_index = _idx;
		image_blend = _color;
		image_alpha = _alpha;
		image_xscale = _scaleX;
		image_yscale = _scaleY;
		image_angle = _angle;
	}
}
function fn_obj_depth(_asset = id, _val = -_asset.y)
{
	_asset.depth = _val;
}

// Drawing
	// Text
function fn_draw_text(_text, _x, _y, _colors, _alpha = 1, _scaleX = 1, _scaleY = 1, _xAlign = fa_left, _yAlign = fa_top, _shadow_colors = undefined, _shadow_alpha = 1)
{
	var _fnt = global.config.lang[global.config.lang_curr].fnt;
	if (font_exists(_fnt) == true)
	{
		draw_set_font(_fnt);
		draw_set_halign(_xAlign);
		draw_set_valign(_yAlign);
		if (_shadow_colors != undefined && _shadow_alpha > 0)
			draw_text_ext_transformed_color((_x + 1), (_y + 1), _text, -1, 640, _scaleX, _scaleY, 0, _shadow_colors[0], _shadow_colors[0], _shadow_colors[1], _shadow_colors[1], (_shadow_alpha * _alpha));
		draw_text_ext_transformed_color(_x, _y, _text, -1, 640, _scaleX, _scaleY, 0, _colors[0], _colors[0], _colors[1], _colors[1], _alpha);
	}
}
	// Rectangles
function fn_draw_rect(_x, _y, _width, _height, _colors, _alpha)
{
	draw_sprite_general(spr_px, 0, 0, 0, 1, 1, _x, _y, _width, _height, 0, _colors[0], _colors[1], _colors[2], _colors[3], _alpha);
}
	// Circles
function fn_draw_circle(_x, _y, _radius, _precision, _colors = [c_white, c_white], _alpha = 1)
{
	draw_set_alpha(_alpha);
	draw_set_circle_precision(_precision);
	draw_circle_color(_x, _y, _radius, _colors[0], _colors[1], false);
}
	// Sprites
function fn_draw_spr(_spr, _img, _x, _y, _color = c_white, _alpha = 1, _scaleX = 1, _scaleY = _scaleX, _angle = 0, _shadow_color = undefined, _shadow_alpha = 0)
{
	if (_spr != -1)
	{
		if (_shadow_color != undefined && _shadow_alpha > 0)
			draw_sprite_ext(_spr, _img, (_x + 1), (_y + 1), _scaleX, _scaleY, _angle, _shadow_color, (_shadow_alpha * _alpha));
		draw_sprite_ext(_spr, _img, _x, _y, _scaleX, _scaleY, _angle, _color, _alpha);
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
function fn_draw_spr_part(_spr, _img, _x, _y, _lt, _top, _width, _height, _color = c_white, _alpha = 1, _scaleX = 1, _scaleY = _scaleX)
{
	if (_spr != -1)
		draw_sprite_part_ext(_spr, _img, _lt, _top, _width, _height, _x, _y, _scaleX, _scaleY, _color, _alpha);
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


/* Audio */
function fn_audio_play(_asset, _emitter, _vol = 1, _pitch = 1, _offset = 0, _loops = false)
{
	var _id = audio_play_sound(_asset, 0, false);
	fn_audio_volume(_asset, _id, _emitter, _vol);
	fn_audio_pitch(_asset, _id, _pitch);
	fn_audio_offset(_asset, _id, _offset);
	audio_sound_loop(_id, _loops);
	return _id;
}
function fn_audio_stop(_id)
{
	audio_stop_sound(_id);
}
// Volume
function fn_audio_volume(_asset, _id, _emitter, _vol = 1)
{
	_vol = fn_audio_volumeData(_asset, _vol);
	_vol *= global.config.audio.emitter[_emitter].volume;
	_vol *= global.config.audio.emitter[CONFIG_AUDIO_EMITTER.MASTER].volume;
	audio_sound_gain(_id, _vol, 0);
}
function fn_audio_volumeData(_asset, _vol)
{
	// _vol MUST ONLY BE MULTIPLIED, NOT ADDED or SUBTRACTED
	
	switch (_asset)
	{
		// Player
		case snd_user_step:
			_vol *= 0.75;
			break;
		
			// Themes
				// Default theme
		case snd_user_theme_move_dflt: // The sound that should be used as reference for all others
			_vol = 1;
			break;
		case snd_user_theme_confirm_dflt:
			_vol *= 1.35;
			break;
		case snd_user_theme_cancel_dflt:
			_vol *= 0.9;
			break;
		case snd_user_theme_unlock_0_dflt:
		case snd_user_theme_unlock_1_dflt:
		case snd_user_theme_unlock_2_dflt:
			_vol *= 0.45;
			break;
		case snd_user_theme_equip_dflt:
		case snd_user_theme_unequip_dflt:
			_vol *= 0.65;
			break;
				// Madotsuki theme
		case snd_user_theme_move_madot:
			_vol *= 0.4;
			break;
		case snd_user_theme_confirm_madot:
			_vol *= 0.2;
			break;
		case snd_user_theme_cancel_madot:
			_vol *= 0.2;
			break;
		case snd_user_theme_error_madot:
			_vol *= 0.4;
			break;
		
			// Items
		case snd_user_func_kart:
			_vol *= 0.5;
			break;
		case snd_user_func_kart_turn:
			_vol *= 0.35;
			break;
		case snd_user_func_kart_hit:
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
// Pitch
function fn_audio_pitch(_asset, _id, _pitch = 1)
{
	_pitch = fn_audio_pitchData(_asset, _pitch);
	audio_sound_pitch(_id, _pitch);
}
function fn_audio_pitchData(_asset, _pitch)
{
	// _pitch MUST ONLY BE ADDED or SUBTRACTED, NOT MULTIPLIED
	
	//switch (_asset)
	//{
		
	//}
	
	return _pitch;
	// one of the WORST fucking FUNCTIONS i've EVER made in my LIFE Part III: The Final Chapter.  Jesus       !!!!!
}
// Offset
function fn_audio_offset(_asset, _id, _offset = 0)
{
	_ofs = fn_audio_offsetData(_asset, _offset);
	audio_sound_set_track_position(_id, _offset);
}
function fn_audio_offsetData(_asset, _ofs)
{
	// _ofs MUST ONLY BE ADDED, NOT SUBTRACTED or MULTIPLIED
	
	switch (_asset)
	{
		// Player
			// Themes
				// Default theme
		case snd_user_theme_start_dflt:
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
function fn_lerp(_valCur, _valTarget, _spd)
{
	return lerp(_valCur, _valTarget, _spd);
}
function fn_lerp_col(_colCur, _colTarget, _spd)
{
	var _colCur_hue = color_get_hue(_colCur);
	var _colCur_sat = color_get_saturation(_colCur);
	var _colCur_vAl = color_get_value(_colCur);
	
	var _colTarget_hue = color_get_hue(_colTarget);
	var _colTarget_sat = color_get_saturation(_colTarget);
	var _colTarget_vAl = color_get_value(_colTarget);
	
	var _col_hue = fn_lerp(_colCur_hue, _colTarget_hue, _spd);
	var _col_sat = fn_lerp(_colCur_sat, _colTarget_sat, _spd);
	var _col_vAl = fn_lerp(_colCur_vAl, _colTarget_vAl, _spd);
	
	return make_color_hsv(_col_hue, _col_sat, _col_vAl);
}

// Other functions
function fn_log(_msg) // Sends a message to the log
{
	show_debug_message($"[{current_time}]  [{object_get_name(object_index)}]  {_msg}");
}




//  MISERABLE.  I AM MISERABLE.  THAT'S WHAT I AM. MISERABLE.  BUT. DON'T CALL ME THAT. DON'T CALL ME MISERABLE.  BECAUSE.  THAT WILL MAKE ME.  EVEN MORE.  MISERABLE.
