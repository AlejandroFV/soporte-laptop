// ====================================================================
// BANDEJA DE 4 PASADORES ENRASADOS PARA OREJETAS DE BASE
//
// Soluciona la inclinación lateral del soporte eliminando cualquier
// saliente inferior contra el escritorio.
// Imprime en ~3 minutos (~3 g de PETG).
// ====================================================================

use <printed_pin.scad>

module plate_flush_pins_x4() {
    for (i = [0 : 3]) {
        translate([i * 15, 0, 0])
            flush_bracket_pin();
    }
}

plate_flush_pins_x4();
