/* Interaction sequence */
if (talk.active == true && talk.door.active == true && talk.stage == 1 && talk.door.close.audio_asset != undefined && talk.door.close.audio_emitter != undefined)
	fn_audio_play(talk.door.close.audio_asset, talk.door.close.audio_emitter);

/* Stops playing the audio the player can only hear if they're close */
if (call.active == true && audio.call.id != undefined && audio_is_playing(call.audio.id) == true)
	fn_audio_stop(call.audio.id);
