event_inherited();
myself.type = MYSELF_TYPE_ACTOR;

/*  */
FACING_WEST = 0;
FACING_EAST = 1;
FACING_NORTH = 2;
FACING_SOUTH = 3;
FACING_AXIS_HORIZ = 0;
FACING_AXIS_VERT = 1;
facing[FACING_WEST] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.WEST,
	axis : FACING_AXIS_HORIZ,
	sign : -1,
}
facing[FACING_EAST] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.EAST,
	axis : FACING_AXIS_HORIZ,
	sign : 1,
}
facing[FACING_NORTH] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.NORTH,
	axis : FACING_AXIS_VERT,
	sign : -1,
}
facing[FACING_SOUTH] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.SOUTH,
	axis : FACING_AXIS_VERT,
	sign : 1,
}
facing_curr = FACING_SOUTH;

/* Movement sequence */
WALK_MODE_AUTO = 0;
WALK_MODE_MANUAL = 1;
walk =
{
	active : true,
	stage : -1,
	mode : WALK_MODE_AUTO,
	distance : 16,
	time : 0,
	timeMax : 32,
	// Delays the movement sequence
	delay :
	{
		active : true,
		time : 0,
		timeMin : 30,
		timeMax : 240,
	},
	// Prevents actor from moving too far from starting position
	chain :
	{
		active : true,
		distance : 48,
	},
	// Walking animation and sound
	step :
	{
		active : false,
		time : 0,
		audio_asset : undefined,
		audio_emitter : CONFIG_AUDIO_EMITTER.ACTOR,
	},
	
	startX : 0,
	startY : 0,
}
SLIDE_MODE_MANUAL = 0;
slide =
{
	active : false,
	mode : SLIDE_MODE_MANUAL,
	speed : 0,
	speedMax : 6,
	acceleration : 0.1,
	deceleration : 0.02,
	// 
	shake :
	{
		active : true,
		timeMin : 6,
		timeMax : 9,
		distanceMin : 2,
		distanceMax : 3,
	},
}

/* */
carry =
{
	active : false,
	object : undefined,
}

fn_actor_evCreate();


// HUA-LATUCA-PAYA!!!! HO-POPAPO-TUYA!!!!!!! AAAAAAAAAAAAAARRRRRRRGHHHHHHH!!!!!!!!!!!
