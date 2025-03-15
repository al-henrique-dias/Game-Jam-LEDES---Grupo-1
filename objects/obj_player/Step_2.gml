if is_attacking {//ação para cada acionamento de tecla
	sprite_index = spr_player_attack;
	mask_index = spr_player_idle;
}

//Definição do Estado Atual
if is_on_ground
	if is_jumping
		current_state = "Jumping";
	else if is_going_right {
		if is_running
			current_state = "Running to the right";
		else
			current_state = "Walking to the right";
	} else if is_going_left {
		if is_running
			current_state = "Running to the right";
		else
			current_state = "Walking to the right";
	} else
		current_state = "Standing on the scenario";	
else if y_speed > 0
	current_state = "Falling";