
event_inherited();
myself.type = "actor";

// Directions
DIR_LT = 0;
DIR_RT = 1;
DIR_UP = 2;
DIR_DN = 3;
DIR_AXIS_HOR = 0;
DIR_AXIS_VER = 1;
	// Left
dir[DIR_LT] =
{
	spr : -1,
	key : CONFIG_KEY.LT,
	axis : DIR_AXIS_HOR,
	sign : -1
}
	// Right
dir[DIR_RT] =
{
	spr : -1,
	key : CONFIG_KEY.RT,
	axis : DIR_AXIS_HOR,
	sign : 1
}
	// Up
dir[DIR_UP] =
{
	spr : -1,
	key : CONFIG_KEY.UP,
	axis : DIR_AXIS_VER,
	sign : -1
}
	// Down
dir[DIR_DN] =
{
	spr : -1,
	key : CONFIG_KEY.DN,
	axis : DIR_AXIS_VER,
	sign : 1
}
fn_actor_dir_spr(id, sprite_index);
dir_curr = DIR_DN; // Current direction the actor is facing

// Movement
move =
{
	active : true,
	stage : -1, // ID number of the current stage of the movement sequence
	amt : 0, // Amount of consecutive movement sequences in any direction, mode and type
	xTarget : 0,
	yTarget : 0,
	xStart : 0,
	yStart : 0,
	
	// Wait (delays the start of the movement sequence)
	wait :
	{
		active : false,
		durMin : 30,
		durMax : 240,
		durCurr : 0
	},
	
	// Modes
	mode :
	{
		// Manual mode
		manual :
		{
			active : false,
			held : false
		},
		
		// Automatic mode
		auto :
		{
			active : false,
			chase_act : false,
			chase_tgt : -1
		}
	},
	
	// Types
	type :
	{
		// Walk type
		walk :
		{
			active : false,
			dur : 16, // Duration in frames of the walking sequence
			durCurr : 0,
			dist : 16, // Distance in pixels the actor will walk
			precise : false, // Whether movement checks for collisions in distances smaller than {move.type.walk.dist}
			
			// Walking animation
			fstep :
			{
				active : false,
				amtCurr : 0,
				wait_durCurr : 0,
				snd_asset : -1,
				snd_emitter : -1,
			}
		},
		
		// Roll type
		roll :
		{
			active : false,
			
			dist : 0, // Distance in pixels the actor will walk
			distMin : 0.5, // Minimum allowed distance for {move.type.roll.dist}
			distMax : 3, // Maximum allowed distance for {move.type.roll.dist}
			distAccel : 0.1,
			distDecel : 0.1,
			precise : true, // Whether movement checks for collisions in distances smaller than {move.type.roll.dist}
			
			snd_asset : -1,
			snd_emitter : -1,
			snd_pitchMin : 0.5,
			snd_pitchMax : 1.5,
			snd_id : -1,
			
			start :
			{
				snd_asset : -1,
				snd_emitter : -1
			},
			
			turn :
			{
				shake_act : true,
				shake_dist : 1,
				shake_dur : 8,
				
				snd_asset : -1,
				snd_emitter : -1,
				snd_pitchMin : 0.25,
				snd_pitchMax : 0.45,
			},
			
			hit :
			{
				shake_act : true,
				shake_dist : 1,
				shake_dur : 6,
				
				snd_asset : -1,
				snd_emitter : -1
			}
		}
	},
	
	// Chain (stops the actor from moving too far from their original position)
	chain :
	{
		active : false,
		dist : 48
	}
}

fn_actor_evCreate();


// HUA-LATUCA-PAYA!!!! HO-POPAPO-TUYA!!!!!!! AAAAAAAAAAAAAARRRRRRRGHHHHHHH!!!!!!!!!!!
