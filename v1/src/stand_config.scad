// ====================================================================
// PARÁMETROS MAESTROS: SOPORTE DUAL UNIFICADO PLEGABLE (V1)
// ====================================================================

$fn = 60;
tol = 0.35;                 // Tolerancia de impresión 3D (ajuste suave)

// --- DIMENSIONES GENERALES ---
stand_span = 205;           // Ancho total abierto entre brackets (centro a centro)
bracket_width = 14;         // Espesor estructural de cada soporte lateral (mm)
bracket_length = 185;       // Longitud de apoyo en mesa (cabe en camas 220x220)
bracket_height = 108;       // Altura máxima de la torre trasera

// --- GEOMETRÍA CUNA TABLET (FRONTAL) ---
// Para Samsung Galaxy Tab S11 Ultra (326 x 208 x 5.5mm / 10-12mm con funda)
tab_slot_depth = 14.5;      // Ancho de la ranura de tablet (admite funda gruesa)
tab_slot_angle = 55;        // Ángulo de visualización cómodo (~55° desde horizontal)
tab_lip_h = 24;             // Altura del labio frontal de retención

// --- GEOMETRÍA CUNA LAPTOP (MACBOOK PRO + DELL LATITUDE 7650) ---
// El ángulo de 38° es el punto óptimo donde:
//  - La MacBook Pro (bisagra máx 135°) abre a 105°-110° con holgura natural
//  - La Dell Latitude 7650 (16", 2kg) descansa con centro de gravedad centrado
//  - La pantalla de la laptop comienza exactamente arriba de la Tab S11 Ultra
laptop_deck_angle = 38;     // Ángulo de inclinación de la base de laptop
laptop_lip_height = 20;     // Gancho retenedor frontal de la laptop
laptop_deck_length = 115;   // Longitud de la rampa de descanso

// --- MECANISMO DE UNIFICACIÓN PLEGABLE (FOLDING LINKAGE) ---
// Enlaces articulados con bisagra central de mariposa y tope a 180°
link_span = stand_span - 2 * bracket_width; // Longitud total desplegada
link_half_len = link_span / 2;             // Longitud de cada semi-enlace
pivot_pin_d = 4.8;                         // Diámetro de pasadores (compatible M5)
