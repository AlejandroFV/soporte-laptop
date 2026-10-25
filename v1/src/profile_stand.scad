// ====================================================================
// SOPORTE DUAL UNIFICADO (V1 - INSPIRADO EN DISEÑO MINIMALISTA)
// Adaptado para:
//   - MacBook Pro 13" (bisagra limitada a 135°)
//   - Dell Latitude 7650 (16", ~2kg, apertura hasta 180°)
//   - Samsung Galaxy Tab S11 Ultra (14.6") y tablets compactas
// Mecanismo unificado: 1 SOLA PIEZA plegable para transporte.
// ====================================================================

$fn = 60;
tol = 0.35;

// Ancho de trabajo (separación entre soportes)
stand_span = 200;      // 200 mm entre centros
bracket_thickness = 14;// Grosor de cada perfil lateral

// --- GEOMETRÍA DEL PERFIL LATERAL MINIMALISTA ---
// Diseñado para acomodar:
// 1. Cuna Frontal (Tablet / Tab S11 Ultra): ~55° inclinación
// 2. Ranura Ergonómica (MacBook Pro / Universal): ~38° inclinación (permite a la MacBook abrir 110° con holgura)
// 3. Ranura Vertical (Laptops 180° como Dell/Legion): ~72° inclinación
// 4. Ventana pasacables trasera (como en la foto de referencia)

module sculpted_side_profile_2d() {
    // Definición poligonal del perfil lateral con curvatura ergonómica
    // Coordenadas [x, y]: x = fondo (0 a 180mm), y = altura (0 a 115mm)
    
    // Puntos clave:
    // Suelo: de x=0 a x=180
    // Front lip: x=10, y=22
    // Tablet rest: x=24 a x=45, ángulo 55°
    // Middle divider: x=55, y=55
    // MacBook / Universal laptop ramp: x=65 a x=125, ángulo 38°
    // Rear tower: x=145, y=110
    // Rear foot: x=180, y=0
    
    difference() {
        polygon(points=[
            // Suelo plano
            [0, 0],
            [180, 0],
            
            // Pata trasera (triangular elegante como en la foto)
            [175, 25],
            [150, 110], // Cúspide de la torre trasera
            [138, 110],
            
            // Respaldo de ranura vertical (72°)
            [122, 50],
            
            // Cuna para MacBook / Laptop (38° ergonómico)
            [90, 42],
            
            // Divisor central (cresta entre laptop y tablet)
            [62, 60],
            [54, 60],
            
            // Respaldo de la tablet (55°)
            [30, 20],
            [18, 12],
            
            // Labio frontal de retención de tablet
            [12, 28],
            [4, 28],
            [0, 15],
            [0, 0]
        ]);
        
        // Ventana pasacables / aligeramiento triangular trasero (como en la foto)
        polygon(points=[
            [142, 12],
            [165, 12],
            [145, 75]
        ]);
        
        // Aligeramiento central debajo del soporte de laptop
        polygon(points=[
            [68, 12],
            [120, 12],
            [105, 30],
            [75, 30]
        ]);
    }
}

// Vista 2D preliminar
sculpted_side_profile_2d();
