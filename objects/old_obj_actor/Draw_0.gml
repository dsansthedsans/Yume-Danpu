
event_inherited();




if (global.config_dbg.active == true) || (room == room_debugworld)
{
	draw_set_alpha(0.5);
			
	draw_set_color(c_red);
	draw_rectangle((x - 16), (y - 32), (x + 32), (y + 16), true);
			
	draw_set_color(c_blue);
	draw_rectangle((myself.x - 16), (myself.y - 32), (myself.x + 32), (myself.y + 16), true);
		
	draw_set_color(c_yellow);
	draw_rectangle(fn_actor_xAhead(id, x, dir_curr, 16), fn_actor_yAhead(id, y, dir_curr, 16), (fn_actor_xAhead(id, x, dir_curr, 16) + 16), (fn_actor_yAhead(id, y, dir_curr, 16) - 16), 1);
}
