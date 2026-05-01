
//////// Functions related to the pause menu, also known as "Pois-É menu"


// Functions related to setting up the menu
function fn_menu_pse_evCreate_0()
{
	// Main level
	LVL_MAIN = 0;
	var l = LVL_MAIN;
	
		// Title
	fn_menu_ttl_add(l, fn_config_lang_data_getText("menu_pse_main_ttl"));
	
		// Options [#0]
	fn_menu_opt_add_ext(l, "menu_pse_main_opt_");
	opt_slct_snd[l, 2] = global.user.theme[global.user.theme_curr].opt_error_snd;
	opt_cncl_key[l, 1] = CONFIG_KEY.MENU_PAUSE;
	var _opt_yDist = draw_dist;
	var _opt_hAll = (_opt_yDist * (opt_len[l] - 1) + fn_);
	
		// Box
	var _box_wDist = round(draw_dist * 1.5);
	var _box_hDist = draw_dist;
	var _box_w = (_box_wDist + opt_wMax[l] + _box_wDist);
	var _box_h = (_box_hDist + _opt_hAll + _box_hDist);
	
	var _box_yDist = draw_dist;
	var _box_x = (160 - round(_box_w / 2));
	var _box_y = (120 + _box_yDist - round(_box_h / 2));
	
	fn_menu_box_add(l, 0, _box_x, _box_y, _box_w, _box_h);
	
		// Options [#1]
	for (var o = 0; o < opt_len[l]; o++)
	{
		opt_x[l, o] = (box_x[l, 0] + round(box_w[l, 0] / 2) - round(opt_w[l, o] / 2));
		opt_y[l, o] = (box_y[l, 0] + round(box_h[l, 0] / 2) - round(_opt_hAll / 2) + (_opt_yDist * o));
		fn_menu_opt_slctr_add(l, o);
	}
	
	
	
	
	// All levels
	for (var l = 0; l < lvl_lengthMax; l++)
	{
		// Dark translucent background
		fn_menu_rect_add(l, 0, 0, 0, 320, 240, global.user.theme[global.user.theme_curr].col.blur, 0.75);
	}
}
function fn_menu_pse_evCreate_1()
{
	fn_obj_depth( , (depth + 1));
	
	
	// Main level
	lvl = LVL_MAIN;
	lvl_alp[lvl] = 0.1;
	
	
	// Takes a screenshot of the game to use as the background, since all objects will temporarily deactivate and disappear
	sshot_spr = -1;
	if (global.config_lowGfx == false) // Checks if the low graphics setting is disabled, since taking a screenshot can freeze the game for half a second
	{
		sshot_name = "menu_pse_sshot.png"; 
		surface_save(application_surface, $"{working_directory}{sshot_name}");
		
		sshot_spr = sprite_add(sshot_name, 1, false, false, 0, 0);
		sshot_xSc = 0.5;
		sshot_ySc = 0.5;
	}
	
	
	// Deactivates/Pauses everything in the room, excluding the ones that should persist
	instance_deactivate_all(true);
	instance_activate_object(obj_game);
	instance_activate_object(obj_stage);
	instance_activate_object(obj_dbg);
	audio_pause_all();
	fn_audio_play(global.user.theme[global.user.theme_curr].opt_slct_snd, CONFIG_AUDIO_EMITTER.MENU);
}
function fn_menu_pse_evDrawGUI_0(l)
{
	// Draws the screenshot
	if (sshot_spr != -1 && lvl_alpTarget_selfDstr[LVL_EMPTY] == false)
		draw_sprite_ext(sshot_spr, 0, 0, 0, sshot_xSc, sshot_ySc, 0, c_white, 1);
}


// Functions related to the options
function fn_menu_pse_opt_slct()
{
	// Main level
	if (lvl == LVL_MAIN)
	{
		// "Resume"
		if (opt_move_pos[lvl] == 0)
			fn_menu_pse_resume();
		
		// "Options"
		else if (opt_move_pos[lvl] == 1)
		{
			fn_menu_lvlNew(LVL_EMPTY);
			fn_menu_obj_create("config");
		}
		
		// "Quit to Menu"
		else if (opt_move_pos[lvl] == 3)
		{
			fn_menu_lvlNew(LVL_EMPTY);
			fn_fader_obj_create();
			
			fn_menu_pse_sshot_destroy();
		}
	}
}
function fn_menu_pse_opt_cncl()
{
	// Main level
	if (lvl == LVL_MAIN)
		fn_menu_pse_resume();
}


// Functions unrelated to the core menu system
function fn_menu_pse_resume() // Resumes the game
{
	fn_menu_lvlNew(LVL_EMPTY, , true);
	
	fn_menu_pse_sshot_destroy();
	
	instance_activate_all();
	audio_resume_all();
	
	if (fn_obj_exists(obj_actor_user) == true && obj_actor_user.move.stage == -2)
	{
		obj_actor_user.move.stage = -1;
		obj_actor_user.MENUDELAY = 5;
	}
}
function fn_menu_pse_sshot_destroy()
{
	// Deletes the image file of the screenshot
	if (sshot_spr != -1)
	{
		if (file_exists(sshot_name) == true)
			file_delete(sshot_name);
		if (sprite_exists(sshot_spr) == true)
			sprite_delete(sshot_spr);
		sshot_spr = -1;
	}
}