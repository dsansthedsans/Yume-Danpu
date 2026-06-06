
for (var m = 0; m < music_lengthMax; m++) 
{
	musicOld[m] =
	{
		asset : music[m].asset,
		id : music[m].id,
	}
}

fn_stage_event_stepBegin();

for (var m = 0; m < music_lengthMax; m++)
{
	if (music[m].asset != musicOld[m].asset && music[m].id == musicOld[m].id)
	{
		// Stops playing the music
		if (music[m].id != undefined)
		{
			fn_log($"Stopped playing music [{audio_get_name(musicOld[m].id)}]");
			fn_audio_stop(music[m].id);
			music[m].id = undefined;
		}
		// Starts playing the music
		if (music[m].asset != undefined && music[m].id == undefined)
		{
			music[m].id = fn_audio_play(music[m].asset, music[m].emitter, , music[m].pitch, , true);
			fn_log($"Started playing the music [{audio_get_name(music[m].id)}]");
		}
	}
	else
	{
		// Updates the currently playing music
		if (music[m].id != undefined)
		{
			fn_audio_volume(music[m].asset, music[m].id, music[m].emitter);
			fn_audio_pitch(music[m].asset, music[m].id, music[m].pitch);
		}
	}
}
