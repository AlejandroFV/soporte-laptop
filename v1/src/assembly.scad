// ====================================================================
// ENSAMBLE COMPLETO V1: SOPORTE DUAL UNIFICADO PLEGABLE (1 SOLA PIEZA)
// Con DOBLE RANURA REAL para laptops:
//   1. Ranura Trasera Vertical a 75°: Dell Latitude 7650 (apertura 180°, como en la foto)
//   2. Ranura Media a 38°: MacBook Pro 13" (bisagra limitada a 135°)
//   3. Ranura Frontal a 55°: Samsung Galaxy Tab S11 Ultra
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>
use <bracket.scad>
use <folding_link.scad>
use <printed_pin.scad>

// --- PARÁMETROS DE VISUALIZACIÓN ---
fold_progress = 0.0;        // 0.0 = Abierto (205mm), 1.0 = Plegado (46mm)
show_devices = true;        // Mostrar dispositivos
laptop_mode = "dell_vertical"; // "dell_vertical" (75° en ranura trasera) o "macbook_angled" (38° en rampa media)

// Cinemática de apertura/plegado
open_span = stand_span;
closed_span = 2 * (bracket_width + 5) + 8; // ~46 mm
current_span = open_span * (1 - fold_progress) + closed_span * fold_progress;

half_s = (open_span - 2 * (bracket_width + 5)) / 2; // 83.5
dx_net = current_span - 2 * (bracket_width + 5);
cos_phi = max(0, min(1, dx_net / (2 * half_s)));
phi_deg = acos(cos_phi);

// Colores
col_frame = [0.15, 0.65, 0.75];     // Teal / Turquesa
col_links = [0.20, 0.25, 0.30];     // Grafito oscuro
col_pins = [0.95, 0.75, 0.15];      // Pasadores dorados
col_dell = [0.80, 0.82, 0.85, 0.95]; // Dell Latitude aluminio
col_mac = [0.88, 0.89, 0.90, 0.95];  // MacBook Pro aluminio
col_screen = [0.05, 0.05, 0.08];    // Pantalla
col_tab = [0.18, 0.18, 0.22, 0.95]; // Galaxy Tab S11 Ultra

// ====================================================================
// MAQUETA DE DELL LATITUDE 7650 EN MODO VERTICAL (75°, APERTURA 180°)
// ====================================================================
module mockup_dell_vertical_75() {
    dell_w = 358;
    dell_d = 250;
    dell_t = 19;
    screen_h = 230;
    
    translate([current_span/2 - dell_w/2, 0, 0]) {
        // Base colocada a 75° casi vertical (como en la foto de referencia)
        color(col_dell)
            rounded_cube_xy([dell_w, dell_d, dell_t], r=4);
            
        // Teclado
        color([0.18, 0.18, 0.20])
            translate([20, 95, dell_t]) rounded_cube_xy([dell_w - 40, 135, 0.5], r=2);
            
        // Pantalla abierta a 180° (continúa recta hacia arriba en el mismo plano de 75°)
        translate([0, dell_d, dell_t - 6]) {
            color(col_dell) rounded_cube_xy([dell_w, screen_h, 6], r=4);
            color(col_screen) translate([8, 8, 5.8]) cube([dell_w - 16, screen_h - 16, 0.5]);
        }
    }
}

// ====================================================================
// MAQUETA DE MACBOOK PRO 13" EN MODO ERGONÓMICO (38°, APERTURA 115°)
// ====================================================================
module mockup_macbook_angled_38() {
    mb_w = 304;
    mb_d = 212;
    mb_t = 15.6;
    screen_h = 195;
    
    translate([current_span/2 - mb_w/2, 0, 0]) {
        // Base a 38°
        color(col_mac)
            rounded_cube_xy([mb_w, mb_d, mb_t], r=4);
            
        // Teclado
        color([0.15, 0.15, 0.18])
            translate([15, 80, mb_t]) rounded_cube_xy([mb_w - 30, 115, 0.5], r=2);
            
        // Pantalla abierta a 115° (dentro del límite de 135°)
        translate([0, mb_d - 4, mb_t])
        rotate([-27, 0, 0]) {
            color(col_mac) rounded_cube_xy([mb_w, 4.5, screen_h], r=3);
            color(col_screen) translate([6, -0.2, 8]) cube([mb_w - 12, 0.5, screen_h - 16]);
        }
    }
}

// ====================================================================
// MAQUETA DE SAMSUNG GALAXY TAB S11 ULTRA (14.6")
// ====================================================================
module mockup_tab_s11_ultra() {
    tab_w = 326;
    tab_h = 208;
    tab_t = 6.0;
    
    translate([current_span/2 - tab_w/2, 0, 0]) {
        color(col_tab) rounded_cube_xy([tab_w, tab_h, tab_t], r=6);
        color(col_screen) translate([6, 6, tab_t - 0.2]) cube([tab_w - 12, tab_h - 12, 0.5]);
    }
}

// ====================================================================
// ENSAMBLAJE V1 COMPLETO (1 SOLA PIEZA)
// ====================================================================
module complete_stand() {
    // 1. Soporte Lateral Izquierdo
    color(col_frame)
        bracket(is_right=false);

    // 2. Soporte Lateral Derecho
    translate([current_span, 0, 0])
    mirror([1, 0, 0])
    color(col_frame)
        bracket(is_right=false);

    // 3. Enlace Plegable Trasero (Y = 165, pliega hacia adelante -Y)
    translate([bracket_width + 5, 165, 0]) {
        rotate([0, 0, -phi_deg]) mirror([0, 1, 0]) color(col_links) folding_link_half_A();
        translate([dx_net, 0, 0]) rotate([0, 0, 180 + phi_deg]) mirror([0, 1, 0]) color(col_links) folding_link_half_B();
        
        color(col_pins) {
            cylinder(d=pivot_pin_d, h=7);
            translate([dx_net, 0, 0]) cylinder(d=pivot_pin_d, h=7);
            translate([half_s * cos(phi_deg), -half_s * sin(phi_deg), 0]) cylinder(d=pivot_pin_d, h=7);
        }
    }

    // 4. Enlace Plegable Delantero (Y = 75, pliega hacia atrás +Y)
    translate([bracket_width + 5, 75, 0]) {
        rotate([0, 0, phi_deg]) color(col_links) folding_link_half_A();
        translate([dx_net, 0, 0]) rotate([0, 0, 180 - phi_deg]) color(col_links) folding_link_half_B();
        
        color(col_pins) {
            cylinder(d=pivot_pin_d, h=7);
            translate([dx_net, 0, 0]) cylinder(d=pivot_pin_d, h=7);
            translate([half_s * cos(phi_deg), half_s * sin(phi_deg), 0]) cylinder(d=pivot_pin_d, h=7);
        }
    }

    // 5. Dispositivos
    if (show_devices && fold_progress < 0.2) {
        // Tablet en la ranura frontal (55°)
        translate([0, 18, 12])
        rotate([55, 0, 0])
            mockup_tab_s11_ultra();

        if (laptop_mode == "dell_vertical") {
            // Dell Latitude en la ranura vertical trasera (75.4°, apertura 180°)
            translate([0, 138, 28])
            rotate([75.4, 0, 0])
                mockup_dell_vertical_75();
        } else {
            // MacBook Pro en la rampa ergonómica media (38.16°)
            translate([0, 56, 26])
            rotate([38.16, 0, 0])
                mockup_macbook_angled_38();
        }
    }
}

// Renderizado principal
complete_stand();
