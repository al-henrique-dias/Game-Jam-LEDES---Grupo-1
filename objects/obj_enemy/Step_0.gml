if place_meeting(x+sign(x_speed), y, obj_ground) or !place_meeting(x+16, y+2, obj_ground) {
	x_speed *= sign(image_xscale);
	image_xscale *= -1;
}
move_and_collide(x_speed, 0, obj_ground);

//atirar
//instance_create_layer(x, y, "Instances", obj_bullet);