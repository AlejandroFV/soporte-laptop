// ====================================================================
// BANDEJA DE ACCESORIOS V1: TRAVESAÑOS RÍGIDOS + PASADORES (SOLUCIÓN B)
// Para máxima solidez y simplicidad total en soportes ya impresos.
// Imprime en ~14 minutos (~22 g de PETG).
// ====================================================================

include <stand_config.scad>
use <rigid_crossbar.scad>
use <printed_pin.scad>

module plate_accessories_rigid() {
    // 1. Dos travesaños rígidos de 167 mm
    translate([0, 0, 0])  rigid_crossbar();
    translate([0, 18, 0]) rigid_crossbar();
    
    // 2. Cuatro pasadores de soporte (grip=12 mm, D=4.4 mm) y 4 clips
    translate([30, 45, 0]) {
        for (i = [0 : 3]) {
            translate([i * 18, 0, 0])
                hinge_pin_grip(grip=12, dia=4.4);
            translate([i * 18, 20, 0])
                retainer_clip();
        }
    }
}

plate_accessories_rigid();
