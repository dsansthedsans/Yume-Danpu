fn_obj_img( , , , , , image_xscale, image_yscale, image_angle);
fn_obj_depth();
solid = true;

/* Self-drawing */
MYSELF_TYPE_PROP = 0;
MYSELF_TYPE_ACTOR = 1;
myself =
{
	active : true,
	type : MYSELF_TYPE_PROP,
	image : 0,
	imageSpeed : 0,
	x : x,
	y : y,
	xOffset : 0,
	yOffset : 0,
	xScale : image_xscale,
	yScale : image_yscale,
	angle : image_angle,
	// Shaking
	shake :
	{
		active : true,
		time : 0,
		distance : 0,
		xOffset : 0,
		yOffset : 0,
	}
}

/* Interaction sequence */
talk =
{
	active : false,
	stage : -1,
	
	/* Types */
	// Starts another object's interaction sequence
	trigger :
	{
		active : false,
		key : CONFIG_KEY.CONFIRM,
		distance : 16,
		target : undefined,
	},
	// Plays an audio
	bell :
	{
		active : false,
		time : 0,
		timeTarget : 30,
		audio_assets : [snd_hulapoca, snd_penyplocde, snd_ponkawonka],
		audio_emitter : CONFIG_AUDIO_EMITTER.PROP,
		audio_index : undefined,
	},
	// Starts a room transition
	door :
	{
		active : false,
		open :
		{	
			imageSpeed : 0.5,
			audio_asset : snd_prop_talk_door_open,
			audio_emitter : CONFIG_AUDIO_EMITTER.PROP,
		},	
		close :
		{
			audio_asset : snd_prop_talk_door_close,
			audio_emitter : CONFIG_AUDIO_EMITTER.PROP,
		},
	},
	// Unlocks an Effect, a Function or a Theme
	gift :
	{
		active : false,
		contents : undefined,
		contents_index : 0,
	},
}

/* Plays an audio the player can only hear if they're close */
noise =
{
	active : false,
	stage : -1,
	distance : (160 * 1.25),
	
	// Audio
	audio :
	{
		asset : undefined,
		emitter : CONFIG_AUDIO_EMITTER.PROP,
		volume : 0,
		volumeSpeed : 0.5,
		pitch : 1,
		pitchOffset : 0,
		pitchOffsetMax : 0.1,
		pitchSpeed : 0.5,
		loops : true,
		id : undefined,
	},
	// Delay
	delay :
	{
		active : false,
		time : 0,
		timeMin : (60 * 5),
		timeMax : (60 * 10),
	},
}

fn_prop_evCreate();