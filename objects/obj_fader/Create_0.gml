
fn_obj_img( , , , , 0);
fn_obj_depth( , -11000);

stage = -1; // ID number of the current stage of the transition

// Target, data about the transition's target)
target =
{
	rm : undefined,
	user :
	{
		ready : false,
		x : undefined,
		y : undefined,
		dir : undefined,
	}
}
// Types
type =
{
	// Fade type
	fade :
	{
		act : false,
		colors : [c_black, c_black, c_black, c_black],
		alpha : 0,
		alphaSpd : 0.15, // Alpha speed (speed at which the alpha changes during the fade transition) (1 == instantaneous)
		alphaJump : 0.05, // Alpha jump (if the difference between the current alpha and the target alpha reaches this value, the current alpha will jump to the target alpha)
		
		// Iris
		iris :
		{
			act : false,
			surface : -1,
			x : (source.objId.x + (source.objId.sprite_width / 2)),
			y : (source.objId.y - (source.objId.sprite_height / 4)),
			xOffset : 0,
			yOffset : 0,
			siner : 0,
			radius : 180,
			radiusTgt : 48,
			radiusSpd : 0.015,
			precision : 32,
			color : c_gray,
			alpha : 0,
			alphaSpd : 0.025,
			alphaJump : 0.05,
			snd_asset : snd_fader_portal,
			snd_emitter : CONFIG_AUD_EMITTER.PROP,
			snd_id : undefined,
		},
		// Wait (Delay)
		wait :
		{
			dur : 0,
			durTgt : 30,
		}
	}
}

fn_fader_evCreate();



// Hello, David. I expect a video call. Do what I want and I'll show you my feet.
