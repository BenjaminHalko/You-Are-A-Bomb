if(audio_sound_get_gain(song) <= 0) exit;
audio_sound_gain(song,audio_sound_get_gain(song)-0.1,0);
audio_sound_pitch(audio_play_sound(snPickup,2,false),0.7);
