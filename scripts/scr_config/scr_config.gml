
//////// Functions related to the user's settings 

function fn_config_setup()
{
	/* Config */
	global.config =
	{
		name : "Yume Danpu",
		version : 0.05,
		
		// Languages
		lang : [-1],
		lang_fnt :
		{
			dflt : font_add_sprite_ext(spr_config_lang_fnt_dflt, "aáàâãbcçdeéèêfghiíìîjklmnoóòôõpqrstuúùûvwxyzAÁÀÂÃBCÇ₢DEÉÈÊFGHIÍÌÎJKLMNOÓÒÔÕPQRS$TUÚÙÛVWXYZ' ,.?!:;\"&1234567890%()[]/_-—<>←→↑↓", false, 1)
		},
		lang_data : -1,
		lang_curr : 0,
		lang_hasChosen : false,
		// Keybinds
		key : [-1],
		// Graphics
		video :
		{
			// Resolution
			resolution :  [-1],
			resolution_curr : 1,
			resolution_name : "config_video_resolution_name",
			// Fullscreen
			fullscreen :
			{
				active : false,
				name : "config_video_fullscreen_name"
			},
			// Vsync
			vsync :
			{
				active : false,
				name : "config_video_vsync_name"
			},
			// Show Version
			showVer :
			{
				active : true,
				name : "config_video_showVer_name"
			},
			// Show Cursor
			hideCursor :
			{
				active : true,
				name : "config_video_hideCursor_name"
			},
			// Show FPS
			showFps :
			{
				active : false,
				name : "config_video_showFps_name"
			},
			// Show Border
			showBdr :
			{
				active : true,
				name : "config_video_showBdr_name"
			},
		},
		// Music & Sounds
		audio :
		{
			emitter : [-1]
		},
		// Accessibility
		access :
		{
			// Reduced Motion
			reduceMotion :
			{
				active : false,
				name : "config_access_reduceMotion_name"
			}
		},	
	}
	
	// File (Creates the file directory if needed; Loads the previously selected language if there's already a file)
	global.config.file_name = string(global.config.version) + "/config.ini";
	global.config.file_msg = choose("There's an in-game options menu. I think you'll like it.", "Is this Notepad World?" /*Reference to Yume Nikki*/, "Are you by any chance on Linux?", "Looking for super-secret settings?" /*Reference to Minecraft*/, "You're probably looking for the other file.", "The Booleans!" /*Reference to Back to the Future (1985)*/, "Look how cool you are, changing your settings directly in the file.", "How about exploring in-game?");
	if (directory_exists(global.config.version) == false)
		directory_create(global.config.version);
	else if (file_exists(global.config.file_name) == true)
	{
		if (irandom_range(1, 100) <= 5)
			global.config.name = choose("Danpu Nikki", "Yume Nikki", "Yume Dapnu", "Yume Danpy", "Yume Dangu", "Yume-Danpu", "Yume Fanpu", "Dume Yanpu", "Yume Champu", "Yummy Danpu", "Yummy Nicky", "Yum Dnampy", "Yume Dhanpy", "Yum Djampp", "Danbu Yambu", "Dumpgame 2");		
		ini_open(global.config.file_name);
		global.config.lang_curr = ini_read_real("lang", "curr", CONFIG_LANG.enUS);
		ini_close();
	}	
	// Languages
	global.config.lang_data = load_csv("config_lang_data.csv");
	enum CONFIG_LANG
	{
		enUS,
		ptBR
	}
	fn_config_lang_add(CONFIG_LANG.enUS, "enUS");
	fn_config_lang_add(CONFIG_LANG.ptBR, "ptBR");
	// Keybinds
	enum CONFIG_KEY
	{
		WEST,			// Left
		EAST,			// Right
		NORTH,			// Up
		SOUTH,			// Down
		CONFIRM,		// Confirm
		CANCEL,			// Cancel
		USE,			// Effect/Item
		AUTOWALK,		// Autowalk
		FULLSCREEN,		// Fullscreen
		MENU_USER,		// Inventory and hotbar menus
		MENU_PAUSE,		// Pause menu
	}
	fn_config_key_add(CONFIG_KEY.WEST,			"west",			vk_left, ord("A"));
	fn_config_key_add(CONFIG_KEY.EAST,			"east",			vk_right, ord("D"));
	fn_config_key_add(CONFIG_KEY.NORTH,			"north",		vk_up, ord("W"));
	fn_config_key_add(CONFIG_KEY.SOUTH,			"south",		vk_down, ord("S"));
	fn_config_key_add(CONFIG_KEY.CONFIRM,		"confirm",		ord("Z"), vk_enter);
	fn_config_key_add(CONFIG_KEY.CANCEL,		"cancel",		ord("X"), vk_shift);
	fn_config_key_add(CONFIG_KEY.USE,			"use",			ord("F"));
	fn_config_key_add(CONFIG_KEY.AUTOWALK,		"autowalk",		ord("R"));
	fn_config_key_add(CONFIG_KEY.FULLSCREEN,	"fullscreen",	vk_f4, vk_f11);
	fn_config_key_add(CONFIG_KEY.MENU_USER,		"menu_user",	ord("C"), vk_control);
	fn_config_key_add(CONFIG_KEY.MENU_PAUSE,	"menu_pause",	vk_escape);
	// Graphics
	window_set_caption(global.config.name);
	window_set_color(c_black);
	var i = 0;
	fn_config_video_resolution_add(i++, 320, 240);
	fn_config_video_resolution_add(i++, 640, 480);
	fn_config_video_resolution_add(i++, 960, 720);
	fn_config_video_resolution_add(i++, 1280, 960);
	// Music & Sounds
	enum CONFIG_AUDIO_EMITTER
	{
		MASTER, // Master
		MUS, // Music
		AMB, // Ambience
		MENU, // Menu
		USER, // Player
		PROP, // Props
		ACTOR, // Entities
	}
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.MASTER,	"master");
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.MUS,		"mus");
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.AMB,		"amb");
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.MENU,		"menu");
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.USER,		"user");
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.PROP,		"prop");
	fn_config_audio_emitter_add(CONFIG_AUDIO_EMITTER.ACTOR,		"actor");
		// File
	if (file_exists(global.config.file_name) == false)
		fn_config_file_save();
	else
		fn_config_file_load();
}
	// File
function fn_config_file_save()
{
	ini_open(global.config.file_name);
	ini_write_string("about", "msg", global.config.file_msg);
	ini_write_real("lang", "curr", global.config.lang_curr);
	ini_write_real("lang", "hasChosen", global.config.lang_hasChosen);
	for (var k = 0; k < array_length(global.config.key); k++)
		ini_write_string("key", global.config.key[k].code, $"{global.config.key[k].main},{global.config.key[k].alt}");
	ini_write_real("video", "resolution_curr", global.config.video.resolution_curr);
	ini_write_real("video", "fullscreen_act", global.config.video.fullscreen.active);
	ini_write_real("video", "vsync_act", global.config.video.vsync.active);
	ini_write_real("video", "hideCursor_act", global.config.video.hideCursor.active);
	ini_write_real("video", "showVer_act", global.config.video.showVer.active);
	ini_write_real("video", "showFps_act", global.config.video.showFps.active);
	ini_write_real("video", "showBdr_act", global.config.video.showBdr.active);
	var _emitter_vol = "";
	for (var e = 0; e < array_length(global.config.audio.emitter); e++)
		_emitter_vol += $"{global.config.audio.emitter[e].volume}" + (e != (array_length(global.config.audio.emitter) - 1) ? "," : "");
	ini_write_string("audio", "emitter_vol", _emitter_vol);
	ini_write_real("access", "reduceMotion_act", global.config.access.reduceMotion.active);
	ini_close();
}
function fn_config_file_load()
{
	ini_open(global.config.file_name);
	global.config.lang_curr = ini_read_real("lang", "curr", CONFIG_LANG.enUS);
	global.config.lang_hasChosen = ini_read_real("lang", "hasChosen", false);
	for (var k = 0; k < array_length(global.config.key); k++)
	{
		var _key = string_split(ini_read_string("key", global.config.key[k].code, ","), ",");
		if (is_array(_key) == true && _key[0] != "" && _key[1] != "")
		{
			global.config.key[k].main = _key[0];
			global.config.key[k].alt = _key[1];
		}
	}
	global.config.video.resolution_curr = ini_read_real("video", "resolution_curr", 1);
	global.config.video.fullscreen.active = ini_read_real("video", "fullscreen_act", false);
	global.config.video.vsync.active = ini_read_real("video", "vsync_act", false);
	global.config.video.hideCursor.active = ini_read_real("video", "hideCursor_act", true);
	global.config.video.showVer.active = ini_read_real("video", "showVer_act", true);
	global.config.video.showFps.active = ini_read_real("video", "showFps_act", false);
	global.config.video.showBdr.active = ini_read_real("video", "showBdr_act", true);
	var _emitter_vol = string_split(ini_read_string("audio", "emitter_vol", ""), ",");
	if (is_array(_emitter_vol) == true && _emitter_vol != [""])
	{
		for (var e = 0; e < array_length(global.config.audio.emitter); e++)
			global.config.audio.emitter[e].volume = real(string_digits(_emitter_vol[e]));
	}
	global.config.access.reduceMotion.active = ini_read_real("access", "reduceMotion_act", false);
	ini_close();
}
function fn_config_file_erase()
{
	file_delete(global.config.file_name)
}
	// Languages
function fn_config_lang_add(_index, _code)
{
	global.config.lang[_index] =
	{
		name : $"config_lang_{_code}",
		code : _code,
		fnt : global.config.lang_fnt.dflt
	}
}
function fn_config_lang_mod(_new)
{
	global.config.lang_curr = _new;
	fn_config_file_save();
}
function textdata(_key)
{
	var _grid = global.config.lang_data;
	var _text = undefined;
	if (ds_exists(_grid, ds_type_grid) == true && ds_grid_value_exists(_grid, 0, 0, ds_grid_width(_grid), ds_grid_height(_grid), _key) == true)
		_text = global.config.lang_data[# (1 + global.config.lang_curr), ds_grid_value_y(_grid, 0, 0, ds_grid_width(_grid), ds_grid_height(_grid), _key)];
	if (_text == undefined)
	{
		if (global.config_dbg.logOverdose == true) 
			fn_log($"The function lang_data() was called and unable to retrieve the desired text. The provided key was \"{_key}\".");
		_text = _key;
	}
	
	if (global.config_dbg.textdataCorruption == true)
	{
		var _text_old = _text;
		_text = "";
		for (var i = 0; i < string_length(_text_old); i++)
			_text = $"{_text}Â"
	}
	
	return _text;
}
	// Keybinds
function fn_config_key_add(_index, _code, _main, _alt = -1)
{
	global.config.key[_index] =
	{
		name : $"config_key_{_code}",
		code : _code,
		
		main : _main,
		alt : _alt,
	}
}
function fn_config_key_held(_index)
{
	return (keyboard_check(global.config.key[_index].main) == true) ? true : keyboard_check(global.config.key[_index].alt)
}
function fn_config_key_pressed(_index)
{
	return (keyboard_check_pressed(global.config.key[_index].main) == true) ? true : keyboard_check_pressed(global.config.key[_index].alt)
}
function fn_config_key_lazy()
{
	for (var k = 0; k < array_length(global.config.key); k++)
	{
		held[k] = fn_config_key_held(k);
		pressed[k] = fn_config_key_pressed(k);
	}
}
	// Graphics
function fn_config_video_resolution_add(_index, _width, _height)
{
	global.config.video.resolution[_index] =
	{
		width : _width,
		height : _height,
	}
}
	// Music & Sounds
function fn_config_audio_emitter_add(_index, _code, _volume = 1, _pitch = 1)
{
	global.config.audio.emitter[_index] =
	{
		name : $"config_audio_emitter_{_code}",
		code : _code,
		id : audio_emitter_create(),
		bus : audio_bus_create(),
		volume : _volume,
		pitch : _pitch
	}
	audio_emitter_bus(global.config.audio.emitter[_index].id, global.config.audio.emitter[_index].bus);
}
