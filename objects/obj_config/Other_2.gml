
randomize();

fn_config_setup();
window_set_caption(global.config.name);
window_set_color(c_black);
window_set_size((global.config.video.res_width * global.config.video.res_mult), (global.config.video.res_height * global.config.video.res_mult));
window_center();

fn_user_setup();

fn_obj_create(obj_config_dbg);
room_goto(temp_rm_menu_home);
