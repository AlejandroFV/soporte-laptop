// ====================================================================
// BANDEJA DE IMPRESIÓN COMPLETA V1 (ESPACIADO CORREGIDO Y SEPARADO)
// Todas las piezas están 100% separadas e independientes.
// Cabe perfectamente en la cama de 256x256 (Bambu Lab A1/P1/X1)
// y en camas estándar de 220x220 mm.
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>
use <bracket.scad>
use <folding_link.scad>
use <printed_pin.scad>

module plate_all_in_one() {
    // 1. Soporte lateral izquierdo (de pie sobre su base)
    // Ocupa X: 20 a 45 mm, Y: 15 a 200 mm
    translate([20, 15, 0])
        bracket(is_right=false);

    // 2. Soporte lateral derecho (de pie sobre su base, con separación holgada de 40mm)
    // Ocupa X: 85 a 110 mm, Y: 15 a 200 mm
    // Las orejetas interiores quedan a X=45 y X=85 -> ¡Separación libre de 40 mm!
    translate([110, 15, 0])
        bracket(is_right=true);

    // 3. Cuatro enlaces articulados (impresos planos en la mitad derecha)
    // Cada enlace mide ~95 mm de largo y 12 mm de ancho
    translate([130, 20, 0]) {
        // Enlace frontal
        translate([0, 0, 0]) folding_link_half_A();
        translate([0, 20, 0]) folding_link_half_B_printable();
        
        // Enlace trasero
        translate([0, 40, 0]) folding_link_half_A();
        translate([0, 60, 0]) folding_link_half_B_printable();
    }

    // 4. Seis pasadores y clips de retención (con separación amplia)
    // 4 pasadores enrasados para articulaciones soporte-brazo
    // 2 pasadores snap-fit cortos (grip=6mm) para articulaciones centrales brazo-brazo
    translate([130, 105, 0]) {
        for (i = [0 : 3]) {
            translate([i * 15, 0, 0])
                flush_bracket_pin();
            translate([i * 15, 22, 0])
                retainer_clip();
        }
        for (i = [4 : 5]) {
            translate([i * 15, 0, 0])
                snap_pin(grip=6, dia=4.4);
            translate([i * 15, 22, 0])
                retainer_clip();
        }
    }
}

// Vista previa
plate_all_in_one();
