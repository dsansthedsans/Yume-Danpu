
if (fcn_old != global.user.fcn_curr) || (eff_old != global.user.eff_curr)
{
	fn_actor_evCreate();
	fcn_old = global.user.fcn_curr;
	eff_old = global.user.eff_curr;
}




// the actual code is at {obj_prop} and {obj_actor}, you silly
event_inherited();


fn_log(move.stg)

/*
if (move.stg == -1)
{
	if (MENUDELAY <= 0 && (fn_key_pressed(CONFIG_KEY.INV) == true || fn_key_pressed(CONFIG_KEY.PSE) == true))
	{
		move.stg = -2;
		
		if (fn_key_pressed(CONFIG_KEY.INV) == true)
		{
			fn_menu_obj_create("inv");
		}
		else if (fn_key_pressed(CONFIG_KEY.PSE) == true)
		{
			fn_menu_obj_create("pse");
		}
	}
	else if (MENUDELAY > 0)
		MENUDELAY -= 1;
}
*/




// The messages that have been erased remain in our hearts and minds.
