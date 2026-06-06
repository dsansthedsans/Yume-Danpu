
// Toggle Debug Mode
if (string_ends_with(keyboard_string, global.config_dbg.pwd) == true)
{
	global.config_dbg.active = !global.config_dbg.active;
	keyboard_string = "";
}
// Debug Mode commands
if (global.config_dbg.active == true && keyboard_check(global.config_dbg.cmd.key) == true)
{
	var _cmd = global.config_dbg.cmd;
	
	// Zoom, changes the size of the user's camera
	if ((keyboard_check(_cmd.zoom_key[0]) == true || keyboard_check(_cmd.zoom_key[1]) == true) && fn_obj_exists(obj_stage) == true)
	{
		obj_stage.cam.width += (_cmd.zoom_xDist * (-1 * keyboard_check(_cmd.zoom_key[1]) == true));
		obj_stage.cam.height += (_cmd.zoom_yDist * (-1 * keyboard_check(_cmd.zoom_key[1]) == true));
	}
	// Fader, starts a room transition to the specified room
	if (keyboard_check(_cmd.fader_key) == true && is_array(_cmd.fader_rm) == true)
	{
		for (var r = 0; r < array_length(_cmd.fader_rm); r++)
		{
			if (keyboard_check_pressed(ord(r)) == true)
			{
				fn_fader_obj_create(_cmd.fader_rm[r]);
				break;
			}
		}
	}
	// Reset, restarts the game
	if (keyboard_check_pressed(_cmd.reset_key[0]) == true)
	{
		if (keyboard_check(_cmd.reset_key[1]) == true && global.user.file_curr != -1)
			fn_user_file_erase(global.user.file_curr);
		if (keyboard_check(_cmd.reset_key[2]) == true)
			fn_config_file_erase();
		game_restart();
	}
}
