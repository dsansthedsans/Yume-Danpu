
//////// Functions related to setting up the stage in the room

function fn_stage_event_create()
{
	/* Not asleep */
	// Eleanor's Apartment
	if (room == room_condo_apartment)
		global.user.asleep = false;
	
	/* Asleep */
	// Nexus
	else if (room == room_nexus)
	{
		global.user.asleep = true;
		cam.lock.x = 0;
		cam.lock.y = 0;
		fn_stage_bg_sky_add(0, spr_stage_bg_sky_nexus, , make_color_hsv(color_get_hue(#07070E), color_get_saturation(#07070E), 50), , 30);
		loop.xAct = true;
		loop.yAct = true;
	}
	// Macacolandia
	else if (room == room_macacolandia)
	{
		global.user.asleep = true;
		fn_stage_bg_sky_add(0, spr_rmCtrl_bg_sky_macaco, , , 0.25, 270, 270);
		fn_stage_bg_clouds_add(1, spr_rmCtrl_bg_clouds_macaco, , 0.65, 0.75, 0.35, , , 90, 90); 
		loop.xAct = true;
		loop.yAct = true;
	}
	// Debug World
	else if (room == room_debugworld)
	{
		global.user.asleep = true;
		var _sky_spr = -1;
		var _clouds_spr = -1;
		for (var s = 0; s < 99; s++)
		{
			if (sprite_exists(s) == true)
				continue;
			else
			{
				_sky_spr = irandom_range(0, (s - 1));
				if (_sky_spr == spr_px)
					_sky_spr = -1;
				_clouds_spr = irandom_range(0, (s - 1));
				break;
			}
		}
		fn_stage_bg_sky_add(0, _sky_spr, (sprite_get_number(bg[0].sky.sprite) - 1), , 0.25);
		fn_stage_bg_clouds_add(1, _clouds_spr, (sprite_get_number(bg[1].clouds.sprite) - 1), , , 0.5, 160, 120);
		loop.xAct = true;
		loop.yAct = true;
	}
}
function fn_stage_event_stepBegin()
{
	/* Menus */
	// Main Menu
	if (room == room_menu_home)
	{
		if (global.config.lang_hasChosen == true && fn_object_exists(obj_menu) == true && obj_menu.lvl_fader.next.wait_dur <= 0 && obj_menu.lvl_fader.next.endgame == false)
			fn_stage_music_add(0, mus_menu_home);
	}
	
	/* Asleep */
	// Nexus
	else if (room == room_nexus)
		fn_stage_music_add(0, mus_nexus);
	// Macacolandia
	else if (room == room_macacolandia)
		fn_stage_music_add(0, mus_macaco);
	// Debug World
	else if (room == room_debugworld)
		fn_stage_music_add(0, mus_dbgwrld);
	
	// Resets all music if the transition is active
	if (fn_object_exists(obj_fader) == true)
	{
		for (var i = 0; i < music_lengthMax; i++)
			fn_stage_music_add(i, undefined);
	}
}

/* Music */
function fn_stage_music_add(_index, _asset, _emitter = CONFIG_AUDIO_EMITTER.MUS, _pitch = 1)
{
	music[_index].asset = _asset;
	music[_index].emitter = _emitter;
	music[_index].pitch = _pitch;
}

/* Background */
// Clouds
function fn_stage_bg_clouds_add(_index, _sprite, _image = 0, _scaleX = 1, _scaleY = 1, _alpha = 1, _loop_xDist = 640, _loop_yDist = 480, _move_xTime_inSeconds = 60, _move_yTime_inSeconds = _move_xTime_inSeconds)
{
	bg[_index] = fn_object_create(obj_stage_bg_clouds);
	with (bg[_index])
	{
		fn_object_imageSetup( , , , , 0)
		fn_object_depth( , (layer_get_depth("Background") - 1 - _index));
		
		clouds =
		{
			sprite : _sprite,
			image : _image,
			imageSpeed : 0,
			x : 0,
			y : 0,
			offsetX : 0,
			offsetY : 0,
			scaleX : _scaleX,
			scaleY : _scaleY,
			color : c_white,
			alpha : _alpha,
			angle : 0,
			
			/* Looping */
			loop :
			{
				// Horizontal looping
				xDist : _loop_xDist,
				xLength : undefined,
				xLength_outsideRoom : undefined,
				// Vertical looping
				yDist : _loop_yDist,
				yLength : undefined,
				yLength_outsideRoom : undefined,
				
				/* Movement */
				move :
				{
					// Horizontal movement
					xSign : choose(-1, 1),
					xTime : (_move_xTime_inSeconds * 60),
					// Vertical movement
					ySign : choose(-1, 1),
					yTime : (_move_yTime_inSeconds * 60),
				},
			},
		}
		
		/* Looping */
		// Horizontal looping
		clouds.loop.xLength_outsideRoom = (ceil(320 / clouds.loop.xDist) * 2);
		clouds.loop.xLength = (clouds.loop.xLength_outsideRoom + ceil(room_width / clouds.loop.xDist) + clouds.loop.xLength_outsideRoom);
		// Vertical looping
		clouds.loop.yLength_outsideRoom = (ceil(320 / clouds.loop.yDist) * 2);
		clouds.loop.yLength = (clouds.loop.yLength_outsideRoom + ceil(room_width / clouds.loop.yDist) + clouds.loop.yLength_outsideRoom);
	}
}
// Sky
function fn_stage_bg_sky_add(_index, _sprite, _image = 0, _color = c_white, _alpha = 1, _move_xTime_inSeconds = 60, _move_yTime_inSeconds = _move_xTime_inSeconds)
{
	bg[_index] = fn_object_create(obj_stage_bg_sky);
	with (bg[_index])
	{
		fn_object_imageSetup( , , , , 0)
		fn_object_depth( , (layer_get_depth("Background") - 1 - _index));
		
		var _spriteOrig = _sprite;
		var _widthOrig = fn_sprite_width(_spriteOrig);
		var _heightOrig = fn_sprite_height(_spriteOrig);
		_sprite = sprite_duplicate(_sprite);
		var _slice = sprite_nineslice_create();
		_slice.enabled = true;
		_slice.tilemode[nineslice_centre] = nineslice_repeat;
		sprite_set_nineslice(_sprite, _slice);
		
		sky =
		{
			sprite : _sprite,
			image : _image,
			imageSpeed : 0,
			x : 0,
			y : 0,
			offsetX : 0,
			offsetY : 0,
			width : (_widthOrig * ceil(room_width / _widthOrig)),
			height : (_heightOrig * ceil(room_height / _heightOrig)),
			color : _color,
			alpha : _alpha,
			angle : 0,
			
			/* Looping */
			loop :
			{
				// Horizontal looping
				xDist : undefined,
				xLength : undefined,
				xLength_outsideRoom : undefined,
				// Vertical looping
				xDist : undefined,
				yLength : undefined,
				yLength_outsideRoom : undefined,
				
				/* Movement */
				move :
				{
					// Horizontal movement
					xSign : choose(-1, 1),
					xTime : (_move_xTime_inSeconds * 60),
					// Vertical movement
					ySign : choose(-1, 1),
					yTime : (_move_yTime_inSeconds * 60)
				}
			}
		}
		
		/* Looping */
		// Horizontal looping
		sky.loop.xDist = sky.width;
		sky.loop.xLength_outsideRoom = (ceil(320 / sky.loop.xDist) * 2);
		sky.loop.xLength = (sky.loop.xLength_outsideRoom + ceil(room_width / sky.loop.xDist) + sky.loop.xLength_outsideRoom);
		// Vertical looping
		sky.loop.yDist = sky.height;
		sky.loop.yLength_outsideRoom = (ceil(320 / sky.loop.yDist) * 2);
		sky.loop.yLength = (sky.loop.yLength_outsideRoom + ceil(room_width / sky.loop.yDist) + sky.loop.yLength_outsideRoom);
	}
}
