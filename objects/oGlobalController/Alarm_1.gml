/// @desc Jump in to multiplayer

with(oGameManager) {
	global.usingMultiplayer = true;
	rollback_define_player(oPlayer);
	rollback_define_input({
		left: [vk_left,ord("A"),gp_padl],
		right: [vk_right,ord("D"),gp_padr],
		jump: [vk_space,vk_shift,vk_control,vk_up,ord("W"),gp_face1,gp_face2,gp_face3,gp_face4],
		axisH: gp_axislh
	});
	if (!rollback_join_game()) {
		rollback_create_game(4,!OPERA);
		other.multiplayerCreated = true;
	} else other.multiplayerCreated = false;
	playerNames = ["PLAYER 1","PLAYER 2","PLAYER 3","PLAYER 4"];
	create = 2;
	other.create = 2;
}
title = false;