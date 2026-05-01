
//////// Functions related to the room transition sequence


function fn_fader_evCreate()
{
	switch (source.obj)
	{
		/* Config */
		// Debug
		case obj_config_dbg:
			type.fade.active = true;
			break;
		/* Menus */
		case obj_menu_home:
			target.rm = rm_nexus;
			type.fade.active = true;
			break;
		/* Props */
		// Bed in Eleanor's Apartment
		case obj_prop_condo_apt_bed:
			target.rm = rm_nexus;
			type.fade.active = true;
			break;
		// Door of Macacolandia
		case obj_prop_macaco_door:
			type.fade.active = true;
			if (source.rm == rm_nexus)
			{
				target.rm = rm_macaco;
				type.fade.iris.active = true;
			}
			else if (source.rm == rm_macaco)
			{
				target.rm = rm_nexus;
				target.user.x = 160;
				target.user.y = 112;
			}
			break;
		// Door of Debug World
		case obj_prop_dbgwrld_door:
			type.fade.active = true;
			if (source.rm == rm_nexus)
			{
				target.rm = rm_dbgwrld;
				type.fade.iris.active = true;
			}
			else if (source.rm == rm_dbgwrld)
			{
				target.rm = rm_nexus;
				target.user.x = 272;
				target.user.y = 224;
			}
			break;
	}
}

function fn_fader_obj_create(_target_rm = undefined)
{
	fader_obj = fn_obj_create(obj_fader, , , {source : {rm : room, obj : object_index, objId : id}});
	if (_target_rm != undefined)
		fader_obj.target.rm = _target_rm;
	
	//fader = fn_obj_create(obj_fader);
	//fader.source.rm = room;
	//fader.source.obj = object_index;
	//fader.source.obj_id = id;
	//if (_tgt_rm != -1)
	//{
	//	fader.type.fade.active = true;
	//	fader.target.rm = _tgt_rm;
	//}
	//with (fader)
	//	fn_fader_evCreate();
}
