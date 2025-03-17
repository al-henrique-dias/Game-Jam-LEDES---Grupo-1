if (global.items_collected >= 3) {
    global.items_collected = 0; // Reinicia a contagem
    event_user(0); // Gera um novo mapa chamando o User Event 0
}