
if (fcn_old != global.user.fcn_curr) || (eff_old != global.user.eff_curr)
{
	fn_actor_evCreate();
	fcn_old = global.user.fcn_curr;
	eff_old = global.user.eff_curr;
}
event_inherited();

if (fn_config_key_pressed(CONFIG_KEY.MENU_USER) == true && fn_obj_exists(obj_menu_user) == false && move.act == true && move.stg == -1)
{
	fn_obj_create(obj_menu_user);
	move.act = false;
}


// The messages that have been erased remain in our hearts and minds.
