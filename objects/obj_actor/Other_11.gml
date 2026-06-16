/// @descr Step Begin Event
switch (object_index)
{
	case obj_actor_user:
	if (fn_config_key_pressed(CONFIG_KEY.MENU_USER) == true && talk.active == true && talk.stage == -1 && walk.active == true && walk.stage == -1)
	{
		fn_object_create(obj_menu_user);
		talk.stage = -2;
		walk.stage = -2;
	}
	break;
}