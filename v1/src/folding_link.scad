// ====================================================================
// ENLACE ARTICULADO PLEGABLE V1 (PLEGADO COMPACTO DE TIJERA HASTA 15°)
//
// Soluciona los 2 problemas reportados:
// 1. Plegado completo: Arquitectura tipo tijera con vigas desplazadas que se
//    solapan en paralelo sin chocar entre sí. Permite plegar desde 180° (abierto)
//    hasta menos de 15° (cerrado compacto a ~50 mm para mochila).
// 2. Conexión 100% concéntrica y sin colisión con los laterales ya impresos
//    (radio exterior R = 4.2 mm deja 0.8 mm de aire libre con la pared de 5.0 mm).
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>
use <printed_pin.scad>

half_span = (stand_span - 2 * (bracket_width + 5)) / 2; // 83.5 mm exactos
link_t = 6.0;   // Grosor estructural del enlace (mm)
link_w = 8.0;   // Ancho resistente de cada viga (mm)
outer_r = 4.2;  // Radio exterior (pared a 5.0 mm -> 0.8 mm de holgura libre)
center_r = 5.5; // Radio del nudillo central (D = 11.0 mm)
hole_d = 5.4;   // Diámetro calibrado para PETG (contrae a ~5.0 mm)
v_gap = 0.5;    // Holgura vertical en la unión central
lap_t = (link_t - v_gap) / 2; // 2.75 mm por semi-articulación
r_clear = center_r + 0.3;     // 5.8 mm de radio de alivio

// Semi-enlace A (Brazo inferior: viga completa en el piso Z = 0 a lap_t)
module folding_link_half_A() {
    difference() {
        union() {
            // Nudillo exterior concéntrico completo a 6.0 mm (interfaz con orejeta base)
            cylinder(r=outer_r, h=link_t);
            
            // Nudillo central (piso inferior: Z = 0 a lap_t)
            translate([half_span, 0, 0])
                cylinder(r=center_r, h=lap_t);
                
            // Viga estructural completa que corre 100% en el piso inferior
            hull() {
                cylinder(r=outer_r, h=lap_t);
                translate([half_span, 0, 0]) cylinder(r=center_r, h=lap_t);
            }
        }
        // Orificios concéntricos
        translate([0, 0, -1]) cylinder(d=hole_d, h=link_t + 2);
        translate([half_span, 0, -1]) cylinder(d=hole_d, h=link_t + 2);
    }
}

// Semi-enlace B (Brazo superior: viga completa en el piso Z = lap_t + v_gap a link_t)
module folding_link_half_B() {
    z_floor = lap_t + v_gap; // 3.25 mm
    
    difference() {
        union() {
            // Nudillo exterior concéntrico completo a 6.0 mm (interfaz con orejeta base)
            cylinder(r=outer_r, h=link_t);
            
            // Nudillo central (piso superior: Z = z_floor a link_t)
            translate([half_span, 0, z_floor])
                cylinder(r=center_r, h=lap_t);
                
            // Viga estructural completa que corre 100% en el piso superior
            hull() {
                translate([0, 0, z_floor]) cylinder(r=outer_r, h=lap_t);
                translate([half_span, 0, z_floor]) cylinder(r=center_r, h=lap_t);
            }
        }
        // Orificios concéntricos
        translate([0, 0, -1]) cylinder(d=hole_d, h=link_t + 2);
        translate([half_span, 0, -1]) cylinder(d=hole_d, h=link_t + 2);
    }
}

// Semi-enlace B orientado plano sobre la cama (invertido para imprimir 100% sin soportes)
module folding_link_half_B_printable() {
    translate([0, 0, link_t])
    rotate([180, 0, 0])
        folding_link_half_B();
}

// Pareja ensamblada completa abierta a 180°
module folding_bar_pair_assembled() {
    color([0.90, 0.45, 0.15]) folding_link_half_A();
    translate([half_span * 2, 0, 0]) rotate([0, 0, 180]) color([0.25, 0.75, 0.35]) folding_link_half_B();
    translate([half_span, 0, 8.5]) rotate([180, 0, 0]) color([0.95, 0.75, 0.10]) snap_pin(grip=6, dia=4.4);
}

// Pareja ensamblada cerrada (plegada a 15°)
module folding_bar_pair_folded() {
    phi = (180 - 15) / 2; // 82.5°
    translate([half_span, 0, 0]) rotate([0, 0, phi]) translate([-half_span, 0, 0])
        color([0.90, 0.45, 0.15]) folding_link_half_A();
    translate([half_span, 0, 0]) rotate([0, 0, 180 - phi]) translate([-half_span, 0, 0])
        color([0.25, 0.75, 0.35]) folding_link_half_B();
    translate([half_span, 0, 8.5]) rotate([180, 0, 0]) color([0.95, 0.75, 0.10]) snap_pin(grip=6, dia=4.4);
}

// Vista previa
folding_bar_pair_assembled();
translate([0, 30, 0]) folding_bar_pair_folded();
