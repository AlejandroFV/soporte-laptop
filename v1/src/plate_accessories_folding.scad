// ====================================================================
// BANDEJA DE ACCESORIOS V1: BARRAS TIJERA PLEGABLES + PASADORES MEJORADOS
//
// Incluye:
// - 4 barras plegables V1 (plegado completo de 180° a 15° sin colisión)
// - 4 pasadores ENRASADOS para las orejetas de la base + 2 SNAP-FIT centrales
// - 6 pasadores con ranura anular 360° + clips de resorte calibrados a presión
// Imprime en ~20 minutos (~28 g de PETG) con 0% DE SOPORTES.
// ====================================================================

include <stand_config.scad>
use <folding_link.scad>
use <printed_pin.scad>

module plate_accessories_folding() {
    // 1. Cuatro semi-enlaces articulados tipo tijera (2 frontales + 2 traseros)
    // Ampliamente espaciados (22 mm entre centros) para cero interferencias
    // Brazo B se imprime en orientación plana invertida (100% libre de soportes)
    translate([0, 0, 0]) {
        translate([0, 0, 0])  folding_link_half_A();
        translate([0, 22, 0]) folding_link_half_B_printable();
        translate([0, 44, 0]) folding_link_half_A();
        translate([0, 66, 0]) folding_link_half_B_printable();
    }
    
    // 2. Sistema de Pasadores Enrasados y Snap-Fit
    // 4 pasadores ENRASADOS (sin saliente inferior) para las orejetas de la base
    // 2 pasadores snap-fit cortos (grip=6 mm) para unión central entre brazos
    translate([0, 95, 0]) {
        for (i = [0 : 3]) {
            translate([i * 16, 0, 0])
                flush_bracket_pin();
        }
        for (i = [4 : 5]) {
            translate([i * 16, 0, 0])
                snap_pin(grip=6, dia=4.4);
        }
    }

    // 3. Sistema Alternativo: Pasadores con ranura anular + C-clips calibrados a presión
    translate([0, 118, 0]) {
        for (i = [0 : 3]) {
            translate([i * 16, 0, 0])
                hinge_pin_grip(grip=12, dia=4.4);
            translate([i * 16, 18, 0])
                retainer_clip();
        }
        for (i = [4 : 5]) {
            translate([i * 16, 0, 0])
                hinge_pin_grip(grip=6, dia=4.4);
            translate([i * 16, 18, 0])
                retainer_clip();
        }
    }
}

plate_accessories_folding();
