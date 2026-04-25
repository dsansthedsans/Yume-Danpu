
fn_obj_img( , , , , 0);
fn_obj_depth( , -14000);

global.config_dbg =
{
	act : true, // Determines if Debug Mode is enabled
	pwd : "hunter2", // Password to enter to toggle Debug Mode (type it with your keyboard anywhere at anytime)
	
	// Commands
	cmd :
	{
		key : vk_alt, // Modifier key
		// Zoom, changes the size of the user's camera
		zoom_key : [ord("O"), ord("I")],
		zoom_xDist : 8,
		zoom_yDist : 6,
		// Fader, starts a room transition to the specified room
		fader_key : ord("F"),
		fader_rm : [rm_menu_dbg, rm_menu_home, rm_nexus],
		// Reset, restarts the game
		reset_key : [ord("R"), vk_shift, vk_control]
	},
	
	textdataCorruption : false, // Determines if the function "textdata()" will always return with ÂÂÂÂÂÂ
	logOverdose : false, // Determines if log messages will show excessively and unnecesarily (affects performance)
}
if (global.config_dbg.act == true)
	fn_user_setup(0);
