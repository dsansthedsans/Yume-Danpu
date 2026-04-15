
event_inherited();

// All levels
LVL_MAIN = 1;
LVL_USER_EFF = 2;
LVL_USER_FCN = 3;
LVL_USER_THM = 4;
fn_menu_lvl_add(LVL_MAIN);
fn_menu_lvl_add(LVL_USER_EFF);
fn_menu_lvl_add(LVL_USER_FCN);
fn_menu_lvl_add(LVL_USER_THM);
for (var l = 0; l < array_length(lvl); l++)
	fn_menu_lvl_rect_add(l, 0, 0, 0, global.config.video.res[0].width, global.config.video.res[0].height, , (l == LVL_MAIN ? 0.5 : 0.75));

// Main level
var l = LVL_MAIN;
lvl[l].option_cancel.key[1] = CONFIG_KEY.MENU_USER;
fn_menu_lvl_fader_start(l, , , , , global.user.thm[global.user.thm_curr].snd.confirm);
for (var o = 0; o < 3; o++)
{
	fn_menu_lvl_option_add(l, o);
	fn_menu_lvl_option_icon_add(l, o);
}
for (var p = 0; p < 2; p++)
	fn_menu_lvl_panel_add(l, p);
fn_menu_lvl_decor_add(l, 0);
fn_menu_lvl_decor_add(l, 1, (irandom_range(1, 100) > 5 ? (fn_obj_exists(obj_actor_user) == true ? obj_actor_user.dir[obj_actor_user.DIR_DN].spr : spr_user_dir_dn) : spr_actor_macaco_monkey));
for (var a = 0; a < 3; a++)
	fn_menu_lvl_label_add(l, a);
fn_menu_lvl_label_icon_add(l, 1);

// User levels
for (var l = LVL_USER_EFF; l <= LVL_USER_THM; l++)
{
	lvl[l].data[0] = (l == LVL_USER_EFF ? global.user.eff : (l == LVL_USER_FCN ? global.user.fcn : global.user.thm));
	fn_menu_lvl_panel_add(l, 0);
	fn_menu_lvl_panel_title_add(l, 0);
	for (var o = 0; o < 10; o++)
		fn_menu_lvl_option_add(l, o);
	fn_menu_lvl_label_add(l, 0);
	lvl[l].option_move.list.act = false;
	lvl[l].option_move.table.act = true;
}
