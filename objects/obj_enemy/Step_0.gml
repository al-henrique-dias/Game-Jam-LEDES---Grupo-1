// Aplicar gravidade (inimigo cai se não houver chão)
if (!place_meeting(x, y + 1, obj_solid)) {
    vspeed += gravidade;
} else {
    vspeed = 0;
}

// Definir movimento horizontal
hspeed = direcao * velocidade;

// Verificar colisão com parede
if (place_meeting(x + hspeed, y, obj_solid)) {
    direcao *= -1; // Inverter direção
    hspeed = direcao * velocidade;
}

// Verificar beira do penhasco (se não houver chão à frente)
//if (!place_meeting(x + (sprite_width / 2 * direcao), y + 1, obj_floor)) {
  //  direcao *= -1; // Inverter direção
    //hspeed = direcao * velocidade;
//}

// Atualizar posição
x += hspeed;
y += vspeed;