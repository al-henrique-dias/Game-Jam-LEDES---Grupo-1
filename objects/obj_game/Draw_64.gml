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
//seleção de itens
if obj_player.selected_item == 1
	draw_sprite(spr_hud_item_select, 1, 32, 16);//item 1 selecionado
if obj_player.selected_item == 2
	draw_sprite(spr_hud_item_select, 1, 32+sprite_get_width(spr_hud_item_1), 16);//item 2 selecionado
if obj_player.selected_item == 3
	draw_sprite(spr_hud_item_select, 1, 96+sprite_get_width(spr_hud_item_2), 16);//item 3 selecionado
	
}

/*Hud para debbuging*/
//draw_text(32, 32, "Player ("+string(obj_player.x)+","+string(obj_player.y)+"):");
//draw_text(32, 44, "direction: "+string(obj_player.image_xscale==1?"right":"left"));
//draw_text(32, 56, "- x speed: "+string(obj_player.x_speed));
//draw_text(32, 67, "- y speed: "+string(obj_player.y_speed));
//draw_text(32, 78, "- item 1 colected: "+string(obj_player.item_1?"true":"false"));
//draw_text(32, 89, "- item 2 colected: "+string(obj_player.item_2?"true":"false"));
//draw_text(32, 100, "- item 3 colected: "+string(obj_player.item_3?"true":"false"));
//draw_text(32, 111, "- selected item: "+string(obj_player.selected_item));