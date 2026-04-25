
fn_actor_evStep();
event_inherited();

// Movement
if (move.act == true)
{
	// WHAT THE FUCK IS GOING ON
	// This must be one of the most painful pieces of code I have ever written.
	// May God have mercy on my soul.
	// i'll try to make this better. eventually. eventually. eventually.
	
	if (move.type.roll.act == true && move.type.roll.snd_asset != -1 && move.type.roll.snd_emitter != -1)
	{
		if (move.type.roll.snd_id == -1)
			move.type.roll.snd_id = fn_audio_play(move.type.roll.snd_asset, move.type.roll.snd_emitter, , , , true);
		
		var _distMax = move.type.roll.distMax;
		var _aud_pitchDiff = (move.type.roll.snd_pitchMax - move.type.roll.snd_pitchMin);
		var _aud_pitch = (move.type.roll.snd_pitchMin + (_aud_pitchDiff * (( _distMax * (move.type.roll.dist / _distMax)) / _distMax)));
		fn_audio_pitch(move.type.roll.snd_asset, move.type.roll.snd_id, _aud_pitch);
		fn_audio_vol(move.type.roll.snd_asset, move.type.roll.snd_id, move.type.roll.snd_emitter);
	}
	else if (move.type.roll.snd_id != -1)
	{
		fn_audio_stop(move.type.roll.snd_id);
		move.type.roll.snd_id = -1;
	}
	
	// Idle (movement sequence is inactive, waiting/preparing for movement)
	if (move.stg == -1 && ((move.wait.act == false) || (move.wait.act == true && move.wait.durCurr <= 0)))
	{
		move.wait.durCurr = irandom_range(move.wait.durMin, move.wait.durMax);
		var _dir_old = dir_curr;
		var _dir_new = -1;
		
		// Manual mode
		if (move.mode.manual.act == true)
		{
			for (var d = 0; d < 4; d++)
			{
				move.mode.manual.held = fn_config_key_held(dir[d].key);
				if (move.mode.manual.held == true)
				{
					_dir_new = d;
					break;
				}
				else
					continue;
			}
			if (_dir_new == -1 && move.mode.manual.held == false && move.type.roll.act == true && move.type.roll.dist > move.type.roll.distMin)
				_dir_new = dir_curr;
		}
		
		// Automatic mode
		else if (move.mode.auto.act == true)
		{
			_dir_new = irandom(3);
			if (move.mode.auto.chase_act == true)
			{
				var _chase_tgt = instance_nearest(x, y, move.mode.auto.chase_tgt);
				if (_chase_tgt != noone && _chase_tgt != id)
				{
					var _chase_tgtProp = collision_line((x + (sprite_width / 2)), (y - (sprite_height / 4)), (_chase_tgt.x + (_chase_tgt.sprite_width / 2)), (_chase_tgt.y - (_chase_tgt.sprite_height / 4)), obj_prop, false, true);
					if (_chase_tgtProp == id) || (_chase_tgtProp == _chase_tgt)
						_chase_tgtProp = noone;
					if (_chase_tgtProp == noone) || (_chase_tgtProp.solid == false)
					{
						var d = point_direction(x, y, _chase_tgt.x, _chase_tgt.y);
						if (d >= 0 && d < 45) || (d >= 315 && d < 360)
							_dir_new = DIR_RT;
						else if (d >= 45 && d < 135)
							_dir_new = DIR_UP;
						else if (d >= 135 && d < 225)
							_dir_new = DIR_LT;
						else if (d >= 225 && d < 315)
							_dir_new = DIR_DN;
					}
				}
			}
		}
		
		if (_dir_new != -1)
		{
			dir_curr = _dir_new;
			var _move_dist = 0;
			var _move_precise = false;
			
			
			// Walk type
			if (move.type.walk.act == true)
			{
				_move_dist = move.type.walk.dist;
				_move_precise = move.type.walk.precise;
			}
			
			// Roll type
			else if (move.type.roll.act == true)
			{
				if (move.type.roll.dist == 0) || (_dir_new != _dir_old) || (move.amt <= 0)
				{
					if (move.mode.manual.act == true)
						move.type.roll.dist = move.type.roll.distMin;
					else if (move.mode.auto.act == true)
						move.type.roll.dist = move.type.roll.distMax;
				}
				_move_dist = move.type.roll.dist;
				_move_precise = move.type.roll.precise;
				
				
				if (dir_curr != _dir_old)
				{
					if (move.type.roll.turn.snd_asset != -1 && move.type.roll.turn.snd_emitter != -1)
						fn_audio_play(move.type.roll.turn.snd_asset, move.type.roll.turn.snd_emitter);
						
					if (move.type.roll.turn.shake_act == true && myself.shake.act == true)
					{
						myself.shake.durCurr = move.type.roll.turn.shake_dur;
						myself.shake.dist = move.type.roll.turn.shake_dist;
					}
				}
			}
			
			
			while (_move_dist > 0)
			{
				var _move_xTgt = fn_actor_xAhead(id, x, dir_curr, _move_dist);
				var _move_yTgt = fn_actor_yAhead(id, y, dir_curr, _move_dist);
				var _move_tgtObj = instance_place(_move_xTgt, _move_yTgt, obj_prop);
				
				if ((_move_tgtObj == noone) || (_move_tgtObj != noone && _move_tgtObj.solid == false)) && ((move.chain.act == false) || (move.chain.act == true && abs(xstart - _move_xTgt) < move.chain.dist && abs(ystart - _move_yTgt) < move.chain.dist))
				{
					move.stg = 0;
					move.amt = (clamp(move.amt, 0, infinity) + 1);
					move.xTgt = _move_xTgt;
					move.yTgt = _move_yTgt;
					move.xStart = x;
					move.yStart = y;
					
					x = move.xTgt;
					y = move.yTgt;
					
					if (global.config_dbg.act == true && global.config_dbg.logOverdose == true)
						fn_log($"x = {x} | y = {y} | self_x = {myself.x} | self_y = {myself.y} | depth = {depth}");
					break;
				}
				else
				{
					if (move.mode.auto.chase_act == true && distance_to_object(move.mode.auto.chase_tgt) <= 16 && move.mode.auto.chase_tgt.move.stg == -1 && room == rm_dbgwrld)
					{
						var _chase_tgt = move.mode.auto.chase_tgt;
						_chase_tgt.x = 112;
						_chase_tgt.y = 432;
						_chase_tgt.myself.x = _chase_tgt.x;
						_chase_tgt.myself.y = _chase_tgt.y;
						fn_obj_depth(_chase_tgt);
						fn_audio_play(snd_actor_macaco_monkey_0, CONFIG_AUDIO_EMITTER.ACTOR, , 0.5);
					}
					
					
					if (_move_precise == false)
					{
						move.amt = -1;
						break;
					}
					else
					{
						_move_dist -= 0.5;
						if (_move_dist > 0)
						{
							continue;
						}
						else
						{
							if (move.type.roll.act == true && move.amt > 0) // Roll type
							{
								if (move.type.roll.hit.snd_asset != -1 && move.type.roll.hit.snd_emitter != -1)
									fn_audio_play(move.type.roll.hit.snd_asset, move.type.roll.hit.snd_emitter);
									
								if (move.type.roll.hit.shake_act == true)
								{
									var _spdMax = move.type.roll.distMax;
									var _spdCurr = move.type.roll.dist;
									myself.shake.dist = move.type.roll.hit.shake_dist;
									myself.shake.durCurr = (move.type.roll.hit.shake_dur * (( _spdMax * (_spdCurr / _spdMax)) / _spdMax));
								}
							}
							
							move.amt = -1;
							break;
						}
					}
				}
			}
		}
	}
	else if (move.stg == -1 && move.wait.act == true && move.wait.durCurr > 0)
		move.wait.durCurr -= 1;
	
	// Moving (movement sequence is active)
	if (move.stg == 0)
	{
		// Walk type
		if (move.type.walk.act == true)
		{
			myself.x += ((move.xTgt - move.xStart) / move.type.walk.dur);
			myself.y += ((move.yTgt - move.yStart) / move.type.walk.dur);
			
			// Walking animation
			if (move.type.walk.fstep.act == true)
			{
				var _fstep_amt = clamp( (round(16 / move.type.walk.dur) + 1), 2, infinity );
				if (move.type.walk.fstep.amtCurr < _fstep_amt)
				{
					if (move.type.walk.fstep.wait_durCurr <= 0)
					{
						image_index += 1;
						if (image_index % 2 == 1 && move.type.walk.fstep.snd_asset != -1 && move.type.walk.fstep.snd_emitter != -1)
							fn_audio_play(move.type.walk.fstep.snd_asset, move.type.walk.fstep.snd_emitter);
						move.type.walk.fstep.amtCurr += 1;
						move.type.walk.fstep.wait_durCurr = floor(move.type.walk.dur / _fstep_amt);
					}
					else
						move.type.walk.fstep.wait_durCurr -= 1;
				}
			}
			
			move.type.walk.durCurr += 1;
			if (move.type.walk.durCurr >= move.type.walk.dur)
			{
				myself.x = x;
				myself.y = y;
				
				move.stg = -1;
				move.type.walk.durCurr = 0;
				
				
				// Walking animation
				if (move.type.walk.fstep.act == true)
				{
					if (image_index % 2 == 1)
						image_index += 1;
					move.type.walk.fstep.amtCurr = 0;
					move.type.walk.fstep.wait_durCurr = 0;
				}
			}
		}
		
		// Roll type
		else if (move.type.roll.act == true)
		{
			myself.x = move.xTgt;
			myself.y = move.yTgt;
			move.stg = -1;
			if (move.mode.manual.act == true)
			{
				if (move.mode.manual.held == true)
					move.type.roll.dist += move.type.roll.distAccel;
				else
					move.type.roll.dist -= move.type.roll.distDecel;
				move.type.roll.dist = clamp(move.type.roll.dist, move.type.roll.distMin, move.type.roll.distMax);
			}
		}
		
		fn_actor_stage_loop();
		depth = -myself.y;
	}
}

sprite_index = dir[dir_curr].spr;
