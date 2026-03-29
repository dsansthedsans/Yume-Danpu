
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
LVL_VID = 2;
LVL_AUD = 3;
LVL_ACCESS = 4;
for (var l = LVL_VID; l <= LVL_ACCESS; l++)
{
	fn_menu_lvl_add(l);
	fn_menu_lvl_panel_add(l, 0); // Panel
	fn_menu_lvl_panel_title_add(l, 0); // Panel's title

		// Options
	var _opt_len;
	switch (l)
	{
		// Graphics
		case LVL_VID:
			_opt_len = 6;
			break;
		
		// Music & Sounds
		case LVL_AUD:
			_opt_len = 7;
			break;
		
		// Accessibility
		case LVL_ACCESS:
			_opt_len = 1;
			break;
	}
	for (var o = 0; o < _opt_len; o++)
	{
		fn_menu_lvl_option_add(l, o);
		fn_menu_lvl_option_value_add(l, o);
	}
}
