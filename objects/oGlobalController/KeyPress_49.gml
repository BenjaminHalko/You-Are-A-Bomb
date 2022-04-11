if(vol <= 0) exit;
vol -= .1;
audio_master_gain(vol);
audio_sound_pitch(audio_play_sound(snPickup,2,false),0.7);
