
event_inherited();

/* Main level */
LVL_MAIN = 1;
var l = LVL_MAIN;
fn_menu_lvl_add(l);
fn_menu_lvl_fader_start(l);
fn_menu_lvl_panel_add(l, 0);
fn_menu_lvl_panel_title_add(l, 0);
for (var o = 0; o < 4; o++)
{
	fn_menu_lvl_option_add(l, o);
	fn_menu_lvl_option_icon_add(l, o);
}
fn_menu_lvl_option_value_add(l, 0);

/* Graphics, Music & Sounds and Accessibility levels */
LVL_VIDEO = 2;
LVL_AUDIO = 3;
LVL_ACCESS = 4;
for (var l = LVL_VIDEO; l <= LVL_ACCESS; l++)
{
	fn_menu_lvl_add(l);
	fn_menu_lvl_panel_add(l, 0);
	fn_menu_lvl_panel_title_add(l, 0);
	if (l == LVL_VIDEO) || (l == LVL_AUDIO)
	{
		for (var o = 0; o < 7; o++)
		{
			fn_menu_lvl_option_add(l, o);
			fn_menu_lvl_option_value_add(l, o);
		}
	}
}
fn_menu_lvl_option_add(LVL_ACCESS, 0);
fn_menu_lvl_option_value_add(LVL_ACCESS, 0)
