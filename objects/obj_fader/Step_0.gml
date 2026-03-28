
// Fade type
if (type.fade.act == true)
{
	var _iris = type.fade.iris;
	if (_iris.act == false && stg == -1)
		stg = 0;
	else if (_iris.act == true)
	{
		if (_iris.snd_asset != -1 && _iris.snd_emtr != -1 && _iris.snd_id == -1)
			_iris.snd_id = fn_aud_play(_iris.snd_asset, _iris.snd_emtr);
		
		_iris.sineVal += 0.1;
		_iris.xOfs += (cos(_iris.sineVal) / 2);
		_iris.yOfs += (sin(_iris.sineVal) / 2);
		
		_iris.rad = fn_lerp(_iris.rad, 0, _iris.radSpd);
		_iris.alp = fn_lerp(_iris.alp, 1, _iris.alpSpd);
		if (_iris.rad <= _iris.radTgt && stg == -1)
			stg = 0;
	}
	
	// Fades out of the source room
	if (stg == 0)
	{
		type.fade.alp = fn_lerp(type.fade.alp, 1, type.fade.alpSpd);
		if (type.fade.alp >= (1 - type.fade.alpJump))
		{
			stg = 1;
			if (tgt.rm != -1)
				room_goto(tgt.rm);
			type.fade.alp = 1;
			type.fade.wait.dur = type.fade.wait.durTgt;
		}
	}
	
	// Fades in to the target room
	else if (stg == 1 && type.fade.wait.dur > 0)
	{
		type.fade.wait.dur -= 1;
		if (fn_obj_exists(obj_actor_user) == true)
		{
			with (obj_actor_user)
			{
				if (other.tgt.user.x != 0)
				{
					x = other.tgt.user.x;
					myself.x = x;
				}
				if (other.tgt.user.y != 0)
				{
					y = other.tgt.user.y;
					myself.y = y;
				}
				fn_obj_depth();
				if (other.tgt.user.dir != -1)
					dir_curr = other.tgt.user.dir;
				move.stg = -2;
			}
		}
	}
	else if (stg == 1 && type.fade.wait.dur <= 0)
	{
		type.fade.alp = fn_lerp(type.fade.alp, 0, type.fade.alpSpd);
		if (type.fade.alp <= type.fade.alpJump)
		{
			stg = 2;
			type.fade.alp = 0;
			fn_obj_destroy();
			if (fn_obj_exists(obj_actor_user) == true)
				obj_actor_user.move.stg = -1;
		}
	}
}




// Holy Mighty this is sooooo EXCITING! Might as well end it all, put an end to it. But I'm not doing that.  I    n e v e r    w i l l                                                 . . . ?
