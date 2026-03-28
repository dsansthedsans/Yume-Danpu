
//////// Functions related to setting up the stage in the room

function fn_stage_evCreate()
{
	if (room == rm_condo_apt) // Eleanor's Apartment
	{
		global.user.awake = true;
	}
	else if (room == rm_nexus) // Nexus
	{
		global.user.awake = false;
		
		cam.lock.x = 0;
		cam.lock.y = 0;
		fn_stage_bg_sky_add(0, temp_spr_stage_bg_sky_nexus, make_color_hsv(color_get_hue(#07070E), color_get_saturation(#07070E), 50), , 30);
		loop.xAct = true;
		loop.yAct = true;
	}
	else if (room == rm_macaco) // Macacolandia
	{
		global.user.awake = false;
		
		fn_stage_bg_sky_add(0, temp_spr_rmCtrl_bg_sky_macaco, , 0.25, 270, 270);
		fn_stage_bg_clouds_add(1, temp_spr_rmCtrl_bg_clouds_macaco, 0.65, 0.75, 0.35, , , 90, 90); 
		loop.xAct = true;
		loop.yAct = true;
	}
	else if (room == rm_dbgwrld) // Debug World
	{
		global.user.awake = false;
		
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
		fn_stage_bg_sky_add(0, _sky_spr, , 0.25);
		bg[0].sky.img = (sprite_get_number(bg[0].sky.spr) - 1);
		fn_stage_bg_clouds_add(1, _clouds_spr, , , 0.5, 160, 120);
		bg[1].clouds.img = (sprite_get_number(bg[1].clouds.spr) - 1);
		loop.xAct = true;
		loop.yAct = true;
	}
}
function fn_stage_evStep()
{
	if (room == temp_rm_menu_home) // Main Menu
	{
		if (global.config.lang_hasChosen == true && fn_obj_exists(obj_menu) == true && obj_menu.lvl_fader.next.wait_dur <= 0 && obj_menu.lvl_fader.next.endgame == false)
			fn_stage_mus_add(0, mus_menu_home);
	}
	else if (room == rm_nexus) // Nexus
	{
		fn_stage_mus_add(0, mus_nexus);
	}
	else if (room == rm_macaco) // Macacolandia
	{
		fn_stage_mus_add(0, mus_macaco);
	}
	else if (room == rm_dbgwrld) // Debug World
	{
		fn_stage_mus_add(0, mus_dbgwrld);
	}
	
	// Resets all music if the transition is active
	if (fn_obj_exists(obj_fader) == true)
	{
		for (var i = 0; i < mus_lenMax; i++)
			fn_stage_mus_add(i, -1);
	}
}

	// Music
function fn_stage_mus_add(_idx, _asset, _emtr = CONFIG_AUD_EMTR.MUS, _pch = 1)
{
	var m = _idx;
	
	mus[m].asset = _asset;
	mus[m].emtr = _emtr;
	mus[m].pch = _pch;
}

	// Background
function fn_stage_bg_clouds_add(_idx, _spr, _xSc = 1, _ySc = 1, _alp = 1, _loop_xDist = 640, _loop_yDist = 480, _move_xDurInSeconds = 60, _move_yDurInSeconds = _move_xDurInSeconds)
{
	bg[_idx] = fn_obj_create(obj_stage_bg_clouds);
	with (bg[_idx])
	{
		fn_obj_img( , , , , 0)
		fn_obj_depth( , (layer_get_depth("Background") - 1 - _idx));
		
		
		// Cloud background
		clouds =
		{
			spr : _spr,
			imgSpd : 0,
			img : 0,
			
			x : 0,
			y : 0,
			xOfs : 0,
			yOfs : 0,
			xSc : _xSc,
			ySc : _ySc,
			
			col : c_white,
			alp : _alp,
			ang : 0,
			
			
			// Loop
			loop :
			{
				xDist : _loop_xDist,
				xLenOUT : 0, // (outside the room's limits)
				xLen : 0,
				
				yDist : _loop_yDist,
				yLenOUT : 0, // (outside the room's limits)
				yLen : 0,
				
				
				// Movement
				move :
				{
					xSign : choose(-1, 1),
					xDur : (_move_xDurInSeconds * 60),
					
					ySign : choose(-1, 1),
					yDur : (_move_yDurInSeconds * 60)
				}
			},
		}
		
			// Loop
		clouds.loop.xLenOUT = (ceil(320 / clouds.loop.xDist) * 2);
		clouds.loop.xLen = (clouds.loop.xLenOUT + ceil(room_width / clouds.loop.xDist) + clouds.loop.xLenOUT);
		
		clouds.loop.yLenOUT = (ceil(320 / clouds.loop.yDist) * 2);
		clouds.loop.yLen = (clouds.loop.yLenOUT + ceil(room_width / clouds.loop.yDist) + clouds.loop.yLenOUT);
	}
}
function fn_stage_bg_sky_add(_idx, _spr, _col = c_white, _alp = 1, _move_xDurInSeconds = 60, _move_yDurInSeconds = _move_xDurInSeconds)
{
	bg[_idx] = fn_obj_create(obj_stage_bg_sky);
	with (bg[_idx])
	{
		fn_obj_img( , , , , 0)
		fn_obj_depth( , (layer_get_depth("Background") - 1 - _idx));
		
		var _sprOrig = _spr;
		var _wOrig = fn_spr_width(_sprOrig);
		var _hOrig = fn_spr_height(_sprOrig);
		_spr = sprite_duplicate(_spr);
		var _slice = sprite_nineslice_create();
		_slice.enabled = true;
		_slice.tilemode[nineslice_centre] = nineslice_repeat;
		sprite_set_nineslice(_spr, _slice);
		
		sky =
		{
			spr : _spr,
			imgSpd : 0,
			img : 0,
			x : 0,
			y : 0,
			xOfs : 0,
			yOfs : 0,
			w : (_wOrig * ceil(room_width / _wOrig)),
			h : (_hOrig * ceil(room_height / _hOrig)),
			col : _col,
			alp : _alp,
			ang : 0,
			
			// Loop
			loop :
			{
				xLenOUT : 0, // (outside the room's limits)
				xLen : 0,
				yLenOUT : 0, // (outside the room's limits)
				yLen : 0,
				
				// Movement
				move :
				{
					xSign : choose(-1, 1),
					xDur : (_move_xDurInSeconds * 60),
					ySign : choose(-1, 1),
					yDur : (_move_yDurInSeconds * 60)
				}
			}
		}
		
			// Loop
		sky.loop.xDist = sky.w;
		sky.loop.xLenOUT = (ceil(320 / sky.loop.xDist) * 2);
		sky.loop.xLen = (sky.loop.xLenOUT + ceil(room_width / sky.loop.xDist) + sky.loop.xLenOUT);
		sky.loop.yDist = sky.h;
		sky.loop.yLenOUT = (ceil(320 / sky.loop.yDist) * 2);
		sky.loop.yLen = (sky.loop.yLenOUT + ceil(room_width / sky.loop.yDist) + sky.loop.yLenOUT);
	}
}
