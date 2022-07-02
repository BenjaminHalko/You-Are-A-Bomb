/// @desc

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fontGui);

draw_text(room_width/2,room_height/2,string("WAITING FOR PLAYERS...\n\n"+string(players)+" OUT OF 4 PLAYERS JOINED\n\nPRESS ENTER TO START EARLY"))