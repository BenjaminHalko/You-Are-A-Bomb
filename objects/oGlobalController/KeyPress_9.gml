/// @desc
global.particle = !global.particle;

var _pitch = [0.7,1.4];
audio_sound_pitch(audio_play_sound(snPickup,2,false),_pitch[global.particle]);
