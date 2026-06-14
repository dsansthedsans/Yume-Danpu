/// @descr Step Begin Event
switch (object_index)
{
	// Bells
	case obj_prop_dbgwrld_horn: // Debug World's horn
		myself.image = ((talk.stage >= -1) ? 0 : 1);
		break;
	// Doors
	case obj_prop_dbgwrld_door: // Door to Debug World
		if (room == rm_nexus)
			myself.alpha = lerp(myself.alpha, (1 - clamp((abs(distance_to_object(obj_actor_user)) / 32), 0, 1)), 0.05);
		break;
}