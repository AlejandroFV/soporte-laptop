// ====================================================================
// TRAVESAÑO RÍGIDO DIRECTO V1 (PARA SOPORTES YA IMPRESOS)
// - Distancia centro a centro entre orificios: 167.0 mm exactos
// - Cabezales exteriores de radio R = 4.2 mm (deja 0.8 mm de holgura libre
//   con la pared de 5.0 mm de los soportes impresos)
// - Orificios de 5.4 mm (calibrados para contracción de PETG a ~5.0 mm)
// - Viga reforzada de 12 mm con nervio central resistente
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>

crossbar_span = 167.0; // Distancia exacta entre orificios de los soportes
outer_r = 4.2;         // Radio en los extremos (pared está a 5.0 mm)
hole_d = 5.4;          // Diámetro para pasadores PETG de 4.4 mm o tornillos M5
bar_t = 6.0;           // Espesor (mismo que las orejetas del soporte)
bar_w = 12.0;          // Ancho central resistente

module rigid_crossbar() {
    difference() {
        union() {
            // Nudillo izquierdo (R=4.2mm)
            translate([0, 0, 0])
                cylinder(r=outer_r, h=bar_t);
                
            // Transición cónica izquierda
            hull() {
                translate([0, 0, 0])
                    cylinder(r=outer_r, h=bar_t);
                translate([12, -bar_w/2, 0])
                    cube([1, bar_w, bar_t]);
            }
            
            // Cuerpo central
            translate([12, -bar_w/2, 0])
                rounded_cube_xy([crossbar_span - 24, bar_w, bar_t], r=2);
                
            // Transición cónica derecha
            hull() {
                translate([crossbar_span - 12, -bar_w/2, 0])
                    cube([1, bar_w, bar_t]);
                translate([crossbar_span, 0, 0])
                    cylinder(r=outer_r, h=bar_t);
            }
            
            // Nudillo derecho (R=4.2mm)
            translate([crossbar_span, 0, 0])
                cylinder(r=outer_r, h=bar_t);
        }
        
        // Orificios en ambos extremos
        translate([0, 0, -1])
            cylinder(d=hole_d, h=bar_t + 2);
        translate([crossbar_span, 0, -1])
            cylinder(d=hole_d, h=bar_t + 2);
            
        // Ranuras de aligeramiento simétricas
        translate([24, -bar_w/2 + 2.5, -1])
            rounded_cube_xy([crossbar_span/2 - 28, bar_w - 5, bar_t + 2], r=1.5);
        translate([crossbar_span/2 + 4, -bar_w/2 + 2.5, -1])
            rounded_cube_xy([crossbar_span/2 - 28, bar_w - 5, bar_t + 2], r=1.5);
    }
}

// Vista previa
rigid_crossbar();
translate([0, 20, 0]) rigid_crossbar();
