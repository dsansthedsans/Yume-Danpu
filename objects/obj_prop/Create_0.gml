fn_object_imageSetup( , , , , , image_xscale, image_yscale, image_angle);
fn_object_depth();
solid = true;

TYPE_PROP = 0;
TYPE_ACTOR = 1;
type = ((object_get_parent(object_index) == obj_prop) ? TYPE_PROP : TYPE_ACTOR);

/* Self-drawing */
MYSELF_TYPE_DEFAULT = 0;
MYSELF_TYPE_CUSTOM = 1;
myself =
{
	active : true,
	type : MYSELF_TYPE_DEFAULT,
	sprite : sprite_index,
	image : 0,
	imageSpeed : 0,
	x : x,
	y : y,
	offsetX : 0,
	offsetY : 0,
	color : image_blend,
	alpha : image_alpha,
	scaleX : image_xscale,
	scaleY : image_yscale,
	angle : image_angle,
	// Shake animation
	shake :
	{
		active : true,
		time : 0,
		distance : 0,
		offsetX : 0,
		offsetY : 0,
	}
}

/* Interaction sequence */
TALK_RIDE_MODE_PASSENGER = 0; // This object will be the another object's passenger
TALK_RIDE_MODE_DRIVER = 1; // The other object will be this object's passenger
talk =
{
	active : false,
	stage : -1,
	trigger_id : undefined, // ID of the object that started this object's interaction sequence
	
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
		timeLimit : 30,
		audio_assets : [snd_hulapoca, snd_penyplocde, snd_ponkawonka],
		audio_assetsRarity : [1, 1, 1], // must be higher than 0
		audio_emitter : CONFIG_AUDIO_EMITTER.PROP,
		audio_index : 0,
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
	// CARRYCARRYCARRYCARRYCARRYCARRYCARRYCARRYCARRY
	ride :
	{
		active : false,
		mode : TALK_RIDE_MODE_PASSENGER,
	},
}

/* Plays an audio the player can only hear if they're close */
call =
{
	active : false,
	stage : -1,
	distance : 320, // Distance the actor needs to be near the player for the current audio volume be higher than 0
	// Audio playlist
	audio : undefined,
	audio_autoplay : true,
	audio_curr : 0,
	audio_currOld : undefined,
	audio_lengthMax : 2,
}
for (var a = 0; a < call.audio_lengthMax; a++)
{
	call.audio[a] =
	{
		id : undefined,
		asset : undefined,
		emitter : CONFIG_AUDIO_EMITTER.PROP,
		volume : 0,
		pitch : 1,
		loops : true,
		delay_active : false,
		delay_time : 0,
	}
}

/* CARRYCARRYCARRYCARRYCARRYCARRYCARRYCARRYCARRY */
passengers_lengthMax = 4;
for (var p = 0; p < passengers_lengthMax; p++)
{
	passengers[p] =
	{
		id : undefined,
		exit_active : true,
		exit_key : CONFIG_KEY.CANCEL,
	}
}

if (type == TYPE_PROP)
	event_user(0);
