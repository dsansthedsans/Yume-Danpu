
// Transition of type Fade
if (type.fade.active == true)
{
	// Starts fade-out transition
	if (stage == -1 && type.fade.iris.active == false)
		stage = 0;
	else if (stage >= -1 && type.fade.iris.active == true)
	{
		var _iris = type.fade.iris;
		_iris.siner += 0.1;
		_iris.xOffset += (cos(_iris.siner) / 2);
		_iris.yOffset += (sin(_iris.siner) / 2);
		_iris.radius = fn_lerp(_iris.radius, 0, _iris.radiusSpeed);
		_iris.alpha = fn_lerp(_iris.alpha, 1, _iris.alphaSpeed);
		if (_iris.snd_asset != undefined && _iris.snd_emitter != undefined && _iris.snd_id == undefined)
			_iris.snd_id = fn_audio_play(_iris.snd_asset, _iris.snd_emitter);
		if (stage == -1 && _iris.radius <= _iris.radiusTarget && _iris.snd_id != undefined)
			stage = 0;
	}
	// Fades out of the source room
	if (stage == 0)
	{
		type.fade.alpha = fn_lerp(type.fade.alpha, 1, type.fade.alphaSpeed);
		if (type.fade.alpha >= (1 - type.fade.alphaJump))
		{
			stage = 1;
			if (target.rm != undefined)
				room_goto(target.rm);
			type.fade.alpha = 1;
			type.fade.wait.dur = type.fade.wait.durTarget;
		}
	}
	// Fades in to the target room
	else if (stage == 1)
	{
		if (target.user.ready == false && fn_obj_exists(obj_actor_user) == true)
		{
			var _user = obj_actor_user;
			_user.x = ((target.user.x != undefined) ? target.user.x : _user.x);
			_user.myself.x = _user.x;
			_user.y = ((target.user.y != undefined) ? target.user.y : _user.y);
			_user.myself.y = _user.y;
			_user.dir_curr = ((target.user.dir != undefined) ? target.user.dir : _user.dir_curr);
			_user.move.stage = -2;
			fn_obj_depth(_user);
			target.user.ready = true;
		}
		if (type.fade.wait.dur > 0)
			type.fade.wait.dur -= 1;
		else
		{
			type.fade.alpha = fn_lerp(type.fade.alpha, 0, type.fade.alphaSpeed);
			if (type.fade.alpha <= type.fade.alphaJump)
			{
				fn_obj_destroy();
				if (fn_obj_exists(obj_actor_user) == true)
					obj_actor_user.move.stage = -1;
			}
		}
	}
}




// Holy Mighty this is sooooo EXCITING! Might as well end it all, put an end to it. But I'm not doing that.  I    n e v e r    w i l l                                                 . . . ?
