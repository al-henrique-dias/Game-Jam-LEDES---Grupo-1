randomize(); // Gera aleatoriedade diferente a cada execução
global.root = new BSPNode(0, 0, 32, 24); // Room de 1024x768 em células
divide_node(global.root);
connect_rooms(global.root);
