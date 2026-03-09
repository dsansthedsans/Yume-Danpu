
//////// Functions related to the room transition sequence


function fn_fader_evCreate()
{
	type.fade.iris.x = (src.obj.x + (src.obj_id.sprite_width / 2));
	type.fade.iris.y = (src.obj.y - (src.obj_id.sprite_height / 4));
	type.fade.iris.snd_asset = snd_fader_portal;
	type.fade.iris.snd_style = CONFIG_AUD_EMTR.PROP;
	
	switch (src.obj)
	{
		// Menus
		case obj_menu_home:
			tgt.rm = rm_condo_apt;
			type.fade.act = true;
		break;
		
		// Doors
		case obj_prop_condo_apt_bed: // Bed in Eleanor's Apartment
			tgt.rm = rm_nexus;
			type.fade.act = true;
		break;
		
		case obj_prop_macaco_door: // Door of Macacolandia
			type.fade.act = true;
			if (src.rm == rm_nexus)
			{
				tgt.rm = rm_macaco;
				type.fade.iris.act = true;
			}
			else if (src.rm == rm_macaco)
			{
				tgt.rm = rm_nexus;
				tgt.player.x = 160;
				tgt.player.y = 112;
			}
		break;
		
		case obj_prop_dbgwrld_door: // Door of Debug World
			type.fade.act = true;
			if (src.rm == rm_nexus)
			{
				tgt.rm = rm_dbgwrld;
				type.fade.iris.act = true;
			}
			else if (src.rm == rm_dbgwrld)
			{
				tgt.rm = rm_nexus;
				tgt.player.x = 272;
				tgt.player.y = 224;
			}
		break;
	}
}

function fn_fader_obj_create(_tgt_rm = -1)
{
	fader = fn_obj_create(obj_fader);
	fader.src.rm = room;
	fader.src.obj = object_index;
	fader.src.obj_id = id;
	if (_tgt_rm != -1)
	{
		fader.type.fade.act = true;
		fader.tgt.rm = _tgt_rm;
	}
	with (fader)
		fn_fader_evCreate();
}
