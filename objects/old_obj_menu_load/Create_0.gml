
if (global.user.file_curr == -1)
{
	fn_user_setup(0);
	room_goto(room_condo_apartment);
}
else
{
	fn_user_setup(-1);
	room_goto(room_menu_home);
}
