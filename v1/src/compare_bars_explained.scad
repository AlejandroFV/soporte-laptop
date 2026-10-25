include <stand_config.scad>
use <folding_link.scad>

h_span = 83.5;

// Simulación de las barras viejas (rectas centradas)
module old_straight_bar_half(is_top=false) {
    w = 8.0;
    r_cen = 6.0;
    t = 6.0;
    lap = is_top ? 3.0 : 0;
    
    difference() {
        union() {
            cylinder(r=4.5, h=t);
            translate([h_span, 0, lap]) cylinder(r=r_cen, h=3.0);
            hull() {
                cylinder(r=4.0, h=t);
                translate([h_span, 0, lap]) cylinder(r=4.0, h=3.0);
            }
        }
        translate([0, 0, -1]) cylinder(d=5.0, h=t+2);
        translate([h_span, 0, -1]) cylinder(d=5.0, h=t+2);
    }
}

// 1. IZQUIERDA: BARRAS VIEJAS (Chocan a 75° de frente)
translate([-45, 0, 0]) {
    phi_old = (180 - 75) / 2; // 52.5°
    translate([0, 0, 0]) rotate([0, 0, phi_old]) translate([-h_span, 0, 0])
        color([0.9, 0.25, 0.2]) old_straight_bar_half(false);
    translate([0, 0, 0]) rotate([0, 0, 180 - phi_old]) translate([-h_span, 0, 0])
        color([0.8, 0.35, 0.3]) old_straight_bar_half(true);
}

// 2. DERECHA: BARRAS NUEVAS V1 (Cierran a 15° en paralelo sin chocar)
translate([45, 0, 0]) {
    phi_new = (180 - 15) / 2; // 82.5°
    translate([0, 0, 0]) rotate([0, 0, phi_new]) translate([-h_span, 0, 0])
        color([0.15, 0.75, 0.35]) folding_link_half_A();
    translate([0, 0, 0]) rotate([0, 0, 180 - phi_new]) translate([-h_span, 0, 0])
        color([0.2, 0.55, 0.95]) folding_link_half_B();
}
