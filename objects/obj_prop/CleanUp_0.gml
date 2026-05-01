/* Interaction sequence */
if (talk.active == true && talk.door.active == true && talk.stage == 1 && talk.door.close.audio_asset != undefined && talk.door.close.audio_emitter != undefined)
	fn_audio_play(talk.door.close.audio_asset, talk.door.close.audio_emitter);

/* Stops playing the audio the player can only hear if they're close */
if (noise.active == true && audio.noise.id != undefined && audio_is_playing(noise.audio.id) == true)
	fn_audio_stop(noise.audio.id);
