
ds_grid_destroy(global.config.lang_data)
for (var e = 0; e < array_length(global.config.aud.emitter); e++)
	audio_emitter_free(global.config.aud.emitter[e].id);
