global.items_collected = 0; // Contagem inicial de itens coletados

// Configurar a câmera
global.camera = camera_create();
var view_width = 1280;  // Largura da visão (ajuste conforme necessário)
var view_height = 720; // Altura da visão (ajuste conforme necessário)
camera_set_view_size(global.camera, view_width, view_height);
view_set_camera(0, global.camera);
view_enabled = true;
view_visible[0] = true;

// Gerar o mapa inicial
event_user(0); // Chama o User Event 0 para criar o primeiro mapa