
// Talk (interaction sequence)
if (talk.act == true && talk.type.door.act == true && talk.stg == 1)
{
	var _door = talk.type.door;
	if (_door.close.snd_asset != -1 && _door.close.snd_emitter != -1)
		fn_audio_play(_door.close.snd_asset, _door.close.snd_emitter);
}


// Noise (audio that can only be heard if the user is near the object)
if (audio_is_playing(noise.audio.id) == true)
	fn_audio_stop(noise.audio.id);
