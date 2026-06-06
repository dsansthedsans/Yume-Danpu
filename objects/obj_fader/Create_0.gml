
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
		facing : undefined,
	}
}
// Types
type =
{
	// Fade type
	fade :
	{
		active : false,
		colors : [c_black, c_black, c_black, c_black],
		alpha : 0,
		alphaSpeed : 0.15, // (1 == instantaneous)
		alphaJump : 0.05, // (if the difference between the current alpha and the target alpha reaches this value, the current alpha will jump to the target alpha)
		
		// Iris
		iris :
		{
			active : false,
			surface : -1,
			x : (source.objId.x + (source.objId.sprite_width / 2)),
			y : (source.objId.y - (source.objId.sprite_height / 4)),
			offsetX : 0,
			offsetY : 0,
			siner : 0,
			radius : 180,
			radiusTarget : 48,
			radiusSpeed : 0.015,
			precision : 32,
			color : c_black,
			alpha : 0,
			alphaSpeed : 0.025,
			alphaJump : 0.05,
			snd_asset : snd_fader_portal,
			snd_emitter : CONFIG_AUDIO_EMITTER.PROP,
			snd_id : undefined,
		},
		// Wait (Delay)
		wait :
		{
			dur : 0,
			durTarget : 30,
		}
		
	}
}

fn_fader_event_create();



// Hello, David. I expect a video call. Do what I want and I'll show you my feet.
