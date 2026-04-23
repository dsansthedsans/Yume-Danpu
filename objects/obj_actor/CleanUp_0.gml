
event_inherited();

// Roll type
if (move.type.roll.act == true && move.type.roll.snd_id != -1)
	fn_audio_stop(move.type.roll.snd_id);
