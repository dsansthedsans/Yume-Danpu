function fn_prop_event_create()
{
	/* Presets */
	switch (object_index)
	{
		// Grasses
		case obj_prop_dbgwrld_grass: // Debug World's grass
			solid = false;
			break;
		// Bells
		case obj_prop_dbgwrld_horn: // Debug World's horn
			talk.active = true;
			talk.bell.active = true;
			break;
		// Doors
		case obj_prop_condo_apt_bed: // Bed in Eleanor's Apartment
		case obj_prop_macaco_door: // Door to Macacolandia
		case obj_prop_dbgwrld_door: // Door to Debug World
			talk.active = true;
			talk.door.active = true;
			break;
		// Gifts
		case obj_prop_gift:
			talk.active = true;
			talk.gift.active = true;
			break;
	}
	
	/* Custom */
	switch (object_index)
	{
		// Walls
		case obj_prop_wall:
			image_alpha = ((room == rm_dbgwrld) ? 1 : 0);
			break;
		// Doors
		case obj_prop_condo_apt_bed: // Bed in Eleanor's Apartment
			talk.door.open.imageSpeed = 0;
			talk.door.open.audio_asset = undefined;
			talk.door.close.audio_asset = undefined;
			break;
		case obj_prop_dbgwrld_door: // Door to Debug World
			if (room == rm_nexus)
				image_alpha = 0;
			break;
		// Gifts
		case obj_prop_gift:
			if (room == rm_nexus)
			{
				talk.gift.contents[0] = global.user.func[USER_FUNC.KART];
				if (talk.gift.contents[0].unlocked == true)
					myself.image = 1;
			}
			break;
	}
}
function fn_prop_event_stepBegin()
{
	switch (object_index)
	{
		// Bells
		case obj_prop_dbgwrld_horn: // Debug World's horn
			myself.image = ((talk.stage >= -1) ? 0 : 1);
			break;
		// Doors
		case obj_prop_dbgwrld_door: // Door to Debug World
			if (room == rm_nexus)
				image_alpha = fn_lerp(image_alpha, (1 - clamp((abs(distance_to_object(obj_actor_user)) / 32), 0, 1)), 0.05);
			break;
	}
}
