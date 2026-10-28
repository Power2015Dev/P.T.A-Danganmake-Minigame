shader_type canvas_item;

// Escala independiente para agrandar la imagen sin tocar los Anchors
uniform float zoom_x : hint_range(0.1, 5.0) = 1.5;
uniform float zoom_y : hint_range(0.1, 5.0) = 1.5;

// Mover la textura dentro del recuadro (útil si queda muy abajo o muy arriba)
uniform float offset_x : hint_range(-2.0, 2.0) = 0.0;
uniform float offset_y : hint_range(-2.0, 2.0) = 0.2; 

// Intensidad del efecto 3D hacia el horizonte
uniform float perspective : hint_range(0.0, 3.0) = 1.2;

void fragment() {
    vec2 uv = UV;
    
    // 1. Mover el origen de coordenadas al centro de la parte inferior
    uv -= vec2(0.5, 1.0);
    
    // 2. Aplicar el desplazamiento (offset)
    uv.x -= offset_x;
    uv.y -= offset_y;
    
    // 3. Calcular la distancia Z (profundidad)
    // Como uv.y ahora es negativo hacia arriba, multiplicarlo por perspectiva simula alejamiento
    float z = 1.0 - (uv.y * perspective); 
    
    // 4. Aplicar la perspectiva (achica el eje X y aplasta el eje Y en la lejanía)
    uv.x *= z; 
    uv.y *= z; 
    
    // 5. Aplicar el tamaño (Zoom) para hacer que ocupe todo el espacio que necesites
    uv.x /= zoom_x;
    uv.y /= zoom_y;
    
    // 6. Devolver el origen a su lugar normal (arriba a la izquierda = 0,0)
    uv += vec2(0.5, 1.0);

    // 7. Cortar lo que quede fuera de la textura original para evitar repeticiones feas
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        COLOR = vec4(0.0);
    } else {
        COLOR = texture(TEXTURE, uv);
    }
}