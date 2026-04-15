
event_inherited();

// Main level
LVL_MAIN = 1;
var l = LVL_MAIN;
fn_menu_lvl_add(l);
fn_menu_lvl_fader_start(l);
fn_menu_lvl_panel_add(l, 0); // Panel
fn_menu_lvl_panel_title_add(l, 0); // Panel's title
for (var o = 0; o < 4; o++) // Options
{
	fn_menu_lvl_option_add(l, o, $"menu_config_main_option_{o}");
	fn_menu_lvl_option_icon_add(l, o); // Option's icon
}
fn_menu_lvl_option_value_add(l, 0); // Language option's value

// Graphics, Music & Sounds and Accessibility level
LVL_VIDEO = 2;
LVL_AUD = 3;
LVL_ACCESS = 4;
for (var l = LVL_VIDEO; l <= LVL_ACCESS; l++)
{
	fn_menu_lvl_add(l);
		// Panel
	fn_menu_lvl_panel_add(l, 0);
			// Panel's title
	fn_menu_lvl_panel_title_add(l, 0);
		// Options
	if (l == LVL_VIDEO) || (l == LVL_AUD)
		var _opt_len = 7;
	else if (l == LVL_ACCESS)
		var _opt_len = 1;
	for (var o = 0; o < _opt_len; o++)
	{
		fn_menu_lvl_option_add(l, o);
		fn_menu_lvl_option_value_add(l, o);
	}
}
