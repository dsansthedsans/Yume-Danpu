
if (func_old != global.user.func_curr) || (effect_old != global.user.effect_curr)
{
	fn_actor_evCreate();
	func_old = global.user.func_curr;
	effect_old = global.user.effect_curr;
}
event_inherited();

if (fn_config_key_pressed(CONFIG_KEY.MENU_USER) == true && fn_obj_exists(obj_menu_user) == false && move.active == true && move.stage == -1)
{
	fn_obj_create(obj_menu_user);
	move.active = false;
}


// The messages that have been erased remain in our hearts and minds.
