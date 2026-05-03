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
	key : CONFIG_KEY.LT,
	axis : FACING_AXIS_HORIZ,
	sign : -1,
}
facing[FACING_EAST] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.RT,
	axis : FACING_AXIS_HORIZ,
	sign : 1,
}
facing[FACING_NORTH] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.UP,
	axis : FACING_AXIS_VERT,
	sign : -1,
}
facing[FACING_SOUTH] =
{
	sprite : sprite_index,
	key : CONFIG_KEY.DN,
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
	time : 16, // Duration of the movement sequence
	distance : 16, // Distance the actor will move
	audio_asset : undefined,
	audio_emitter : CONFIG_AUDIO_EMITTER.ACTOR,
	startX : 0,
	startY : 0,
	endX : 0,
	endY : 0,
	// Delays the movement sequence
	delay :
	{
		active : false,
		time : 0,
		timeMin : 30,
		timeMax : 240,
	},
	// Prevents actor from moving too far from starting position
	chain :
	{
		active : false,
		distance : 48,
	},
}