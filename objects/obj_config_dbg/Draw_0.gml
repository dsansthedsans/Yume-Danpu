
if (global.config_dbg.active == true) || (room == rm_dbgwrld)
{
	// Room limits
	draw_set_color(c_red);
	draw_set_alpha(0.5);
	draw_line(0, 0, room_width, 0);
	draw_line(room_width, 0, room_width, room_height);
	draw_line(room_width, room_height, 0, room_height);
	draw_line(0, room_height, 0, 0);
}
