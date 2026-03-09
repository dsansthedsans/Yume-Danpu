
if (global.player.file_curr == -1)
{
	fn_player_setup(0);
	room_goto(rm_condo_apt);
}
else
{
	fn_player_setup(-1);
	room_goto(temp_rm_menu_home);
}
