
fn_obj_img( , , , , 0);
fn_obj_depth( , -11000);

stg = -1; // ID number of the current stage of the transition

// Source, data about the transition's origin
src =
{
	rm : -1,
	obj : -1,
	obj_id : -1
}

// Target, data about the transition's target)
tgt =
{
	rm : -1,
	
	user :
	{
		x : 0,
		y : 0,
		dir : -1
	}
}

// Types
type =
{
	// Fade type
	fade :
	{
		act : false,
		
		col : c_black,
		alp : 0,
		alpSpd : 0.15, // Alpha speed (speed at which the alpha changes during the fade transition) (1 == instantaneous)
		alpJump : 0.05, // Alpha jump (if the difference between the current alpha and the target alpha reaches this value, the current alpha will jump to the target alpha)
		
		iris :
		{
			act : false,
			
			x : (320 / 2),
			y : (240 / 2),
			xOfs : 0,
			yOfs : 0,
			sineVal : 0,
			
			col : c_black,
			alp : 0,
			alpSpd : 0.025,
			alpJump : 0.05,
			
			rad : 180,
			radTgt : 48,
			radSpd : 0.02,
			prec : 32,
			surf : -1,
			
			snd_asset : -1,
			snd_emtr : -1,
			snd_id : -1
		},
		
		wait :
		{
			dur : 0,
			durTgt : 30
		}
	}
}




// Hello, David. I expect a video call. Do what I want and I'll show you my feet.
