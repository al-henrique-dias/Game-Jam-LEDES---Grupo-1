/*HUD do Jogador*/
if(instance_exists(obj_player)){//só aparece em telas de jogo (onde o player está presente)
	
	/*Itens*/
	draw_sprite(spr_hud_item_frame, 1, 32, 16);//item 1 vazio
	if(obj_player.item_1)
		draw_sprite(spr_hud_item_1, 1, 32, 16);//item 1 coletado
	draw_sprite(spr_hud_item_frame, 1, 32+sprite_get_width(spr_hud_item_frame), 16);//item 2 vazio
	if(obj_player.item_2)
		draw_sprite(spr_hud_item_2, 1, 32+sprite_get_width(spr_hud_item_1), 16);//item 2 coletado
	draw_sprite(spr_hud_item_frame, 1, 96+sprite_get_width(spr_hud_item_frame), 16);//item 3 vazio
	if(obj_player.item_3)
		draw_sprite(spr_hud_item_3, 1, 96+sprite_get_width(spr_hud_item_2), 16);//item 3 coletado
	
}

/*Hud para debbuging*/
draw_text(32, 32, "Player ("+string(obj_player.x)+","+string(obj_player.y)+") ("+string(obj_player.current_state)+"):");
draw_text(32, 44, "direction: "+string(obj_player.image_xscale==1?"right":"left"));
draw_text(32, 56, "- x speed: "+string(obj_player.x_speed));
draw_text(32, 67, "- y speed: "+string(obj_player.y_speed));
draw_text(32, 78, "- item 1 colected: "+string(obj_player.item_1?"true":"false"));
draw_text(32, 89, "- item 2 colected: "+string(obj_player.item_2?"true":"false"));
draw_text(32, 100, "- item 3 colected: "+string(obj_player.item_3?"true":"false"));
draw_text(32, 124, "- current sprite: "+string(obj_player.sprite_index));