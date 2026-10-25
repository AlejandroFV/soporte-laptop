// ====================================================================
// GENERADOR DE RENDERIZADOS PARA LA GUÍA DE ENSAMBLE PASO A PASO
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>
use <bracket.scad>
use <folding_link.scad>
use <printed_pin.scad>

// Paleta de colores didáctica
col_bracket_L = [0.12, 0.55, 0.70]; // Azul cian / Teal
col_bracket_R = [0.10, 0.45, 0.60]; // Azul acero
col_link_A    = [0.92, 0.45, 0.15]; // Naranja vibrante (Brazo A - Macho)
col_link_B    = [0.25, 0.75, 0.35]; // Verde esmeralda (Brazo B - Hembra)
col_pin       = [0.95, 0.75, 0.10]; // Amarillo / Dorado (Pasadores)
col_clip      = [0.85, 0.20, 0.25]; // Rojo brillante (Clips de retención)

h_span = (stand_span - 2 * (bracket_width + 5)) / 2; // 83.5 mm

// --- DIAGRAMA 1: ENSAMBLE DE LA BISAGRA CENTRAL (BRAZO A + BRAZO B) ---
module diagram_step1_center_hinge() {
    // Brazo A en posición con ángulo de 25° para apreciar la articulación
    rotate([0, 0, 15])
    translate([-h_span, 0, 0])
        color(col_link_A)
            folding_link_half_A();

    // Brazo B colocado enfrente, encajando en el nudillo central
    rotate([0, 0, -15])
    translate([h_span, 0, 0])
        rotate([0, 0, 180])
            color(col_link_B)
                folding_link_half_B();

    // Pasador corto (grip=6mm) flotando arriba para mostrar inserción vertical
    translate([0, 0, 22])
        color(col_pin)
            rotate([180, 0, 0])
                hinge_pin_grip(grip=6, dia=4.7);

    // Clip de retención flotando abajo listo para entrar en la ranura
    translate([0, -14, -10])
        color(col_clip)
            rotate([0, 0, 90])
                retainer_clip();
}

// --- DIAGRAMA 2: UNIÓN DE LAS BARRAS A LOS SOPORTES LATERALES ---
module diagram_step2_brackets_assembly() {
    // Soporte Izquierdo
    color(col_bracket_L)
        bracket(is_right=false);

    // Soporte Derecho
    translate([stand_span, 0, 0])
        mirror([1, 0, 0])
            color(col_bracket_R)
                bracket(is_right=false);

    // Barra Articulada Trasera (Y = 165)
    translate([bracket_width + 5, 165, 6]) {
        color(col_link_A) folding_link_half_A();
        translate([2 * h_span, 0, 0]) rotate([0, 0, 180]) color(col_link_B) folding_link_half_B();
        
        // Pasador central instalado
        translate([h_span, 0, -1]) color(col_pin) cylinder(d=4.7, h=7.5);
        translate([h_span, 0, -2.5]) color(col_clip) retainer_clip();
    }
    
    // Barra Articulada Delantera (Y = 75)
    translate([bracket_width + 5, 75, 6]) {
        color(col_link_A) folding_link_half_A();
        translate([2 * h_span, 0, 0]) rotate([0, 0, 180]) color(col_link_B) folding_link_half_B();
        
        // Pasador central instalado
        translate([h_span, 0, -1]) color(col_pin) cylinder(d=4.7, h=7.5);
        translate([h_span, 0, -2.5]) color(col_clip) retainer_clip();
    }

    // Pasadores de articulación lateral (mostrados flotando en inserción)
    // Trasero izquierdo
    translate([bracket_width + 5, 165, 26])
        rotate([180, 0, 0])
            color(col_pin)
                hinge_pin_grip(grip=12, dia=4.7);
    translate([bracket_width + 5, 165, -10])
        color(col_clip)
            rotate([0, 0, 90])
                retainer_clip();

    // Delantero izquierdo
    translate([bracket_width + 5, 75, 26])
        rotate([180, 0, 0])
            color(col_pin)
                hinge_pin_grip(grip=12, dia=4.7);
    translate([bracket_width + 5, 75, -10])
        color(col_clip)
            rotate([0, 0, 90])
                retainer_clip();

    // Delantero derecho
    translate([stand_span - (bracket_width + 5), 75, 26])
        rotate([180, 0, 0])
            color(col_pin)
                hinge_pin_grip(grip=12, dia=4.7);
    translate([stand_span - (bracket_width + 5), 75, -10])
        color(col_clip)
            rotate([0, 0, 90])
                retainer_clip();

    // Trasero derecho
    translate([stand_span - (bracket_width + 5), 165, 26])
        rotate([180, 0, 0])
            color(col_pin)
                hinge_pin_grip(grip=12, dia=4.7);
    translate([stand_span - (bracket_width + 5), 165, -10])
        color(col_clip)
            rotate([0, 0, 90])
                retainer_clip();
}

// Selector de vista
view_step = 1; // 1 = Bisagra central, 2 = Ensamble general con soportes

if (view_step == 1) {
    diagram_step1_center_hinge();
} else if (view_step == 2) {
    diagram_step2_brackets_assembly();
}
