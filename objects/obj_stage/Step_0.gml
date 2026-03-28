
// Music (#0)
for (var m = 0; m < mus_lenMax; m++) 
{
	musOld[m] =
	{
		asset : mus[m].asset,
		
		id : mus[m].id
	}
}

fn_stage_evStep();

// Music (#1)
for (var m = 0; m < mus_lenMax; m++)
{
	if (mus[m].asset != musOld[m].asset && mus[m].id == musOld[m].id)
	{
		// Stops playing the music
		if (mus[m].id != -1)
		{
			fn_aud_stop(mus[m].id);
			mus[m].id = -1;
			fn_log($"Stopped playing music [{audio_get_name(musOld[m].asset)}]");
		}
		// Starts playing the music
		if (mus[m].asset != -1 && mus[m].id == -1)
		{
			mus[m].id = fn_aud_play(mus[m].asset, mus[m].emtr, , , mus[m].pch, true);
			fn_log($"Started playing the music [{audio_get_name(mus[m].id)}]");
		}
	}
	else
	{
		// Updates the currently playing music
		if (mus[m].id != -1)
		{
			fn_aud_vol(mus[m].asset, mus[m].id, mus[m].emtr, );
			fn_aud_pch(mus[m].asset, mus[m].id, mus[m].pch);
		}
	}
}
