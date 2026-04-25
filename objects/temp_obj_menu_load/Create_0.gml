
if (global.user.file_curr == -1)
{
	fn_user_setup(0);
	room_goto(rm_condo_apt);
}
else
{
	fn_user_setup(-1);
	room_goto(rm_menu_home);
}
