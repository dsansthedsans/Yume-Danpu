

function fn_prop_evCreate()
{
	// Main data (presets)
	switch (object_index)
	{
		// Bells
		case obj_prop_dbgwrld_horn: // Debug World horn
			talk.act = true;
			talk.type.bell.act = true;
		break;
		
		
		// Doors
		case obj_prop_condo_apt_bed: // Bed in Eleanor's Apartment
		case obj_prop_macaco_door: // Door of Macacolandia
		case obj_prop_dbgwrld_door: // Door of Debug World
			talk.act = true;
			talk.type.door.act = true;
			talk.type.door.open.snd_asset = snd_prop_talk_door_open;
			talk.type.door.open.snd_emtr = CONFIG_AUD_EMTR.PROP;
			talk.type.door.close.snd_asset = snd_prop_talk_door_close;
			talk.type.door.close.snd_emtr = CONFIG_AUD_EMTR.PROP;
		break;
		
		
		// Grasses
		case obj_prop_dbgwrld_grass: // Debug World grass
			solid = false;
		break;
		
		
		// Gifts
		case obj_prop_gift:
			talk.act = true;
			talk.type.gift.act = true;
		break;
	}
	
	
	// Other data (object-specific personalization)
	switch (object_index)
	{
		// Bells
		case obj_prop_dbgwrld_horn: // Debug World horn
			talk.type.bell.aud_asset[0] = snd_hulapoca;
			talk.type.bell.aud_asset[1] = snd_penyplocde;
			talk.type.bell.aud_asset[2] = snd_ponkawonka;
		break;
		
		
		// Gifts
		case obj_prop_gift:
			if (room == rm_nexus)
				talk.type.gift.content[0] = global.user.fcn[USER_FCN.KART];
		break;
		
		
		// Doors
		case obj_prop_condo_apt_bed: // Bed in Eleanor's Apartment
			talk.type.door.open.imgSpd = 0;
			talk.type.door.open.snd_asset = -1;
			talk.type.door.close.snd_asset = -1;
		break;
		
		case obj_prop_dbgwrld_door: // Door of Debug World
			if (room == rm_nexus)
				image_alpha = 0;
		break;
		
		
		// Wall
		case obj_prop_wall:
			image_alpha = 0;
		break;
	}
	
	
	if (talk.type.gift.act == true && talk.type.gift.content[0].unlocked == true)
		image_index = 1;
}
function fn_prop_evStep()
{
	switch (object_index)
	{
		// Bells
		case obj_prop_dbgwrld_horn: // Debug World horn
			if (talk.stg < 0)
				image_index = 0;
			else
				image_index = 1;
		break;
		
		
		// Doors
		case obj_prop_dbgwrld_door: // Door of Debug World
			if (room == rm_nexus)
			{
				var _alp = clamp((abs(distance_to_object(obj_actor_user)) / 32), 0, 1);
				image_alpha = fn_lerp(image_alpha, (1 - _alp), 0.05);
			}
		break;
	}
}
