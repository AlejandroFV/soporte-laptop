// ====================================================================
// PASADORES IMPRIMIBLES 3D Y CLIPS DE RETENCIÓN CALIBRADOS (V1)
//
// Incluye dos sistemas de fijación de alta retención:
// 1. PASADOR SNAP-FIT (Autoblocante, 1 sola pieza, ¡CERO clips sueltos!)
//    - Puntas flexibles biseladas con barba de retención exterior.
//    - Se empuja a mano por el orificio y hace "CLIC" al salir.
//    - Nunca se cae solo; para desarmar se aprietan las dos puntas.
// 2. PASADOR CON RANURA ANULAR + C-CLIP DE PRESIÓN REAL
//    - Ranura perimétrica circular de 360° (D = 3.0 mm, ancho 1.8 mm).
//    - Clip con boca elástica reducida y reborde envolvente >200°.
//    - Entra a presión y queda trabado firmemente en la ranura.
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>

// ====================================================================
// 1. PASADOR SNAP-FIT AUTOBLOCANTE (RECOMENDADO)
// ====================================================================
module snap_pin(grip=12, dia=4.4, head_d=8.8, head_t=2.5) {
    slit_w = 1.0;
    slit_len = 8.5;
    barb_dia = dia + 1.2; // 5.6 mm de diámetro en la barba
    tip_len = 3.6;
    total_shank = grip + 0.6 + tip_len;
    
    difference() {
        union() {
            // Cabeza ergonómica plana
            cylinder(d=head_d, h=head_t);
            // Vástago principal liso
            translate([0, 0, head_t])
                cylinder(d=dia, h=grip + 0.6);
            // Barba de retención cónica con hombro de bloqueo
            translate([0, 0, head_t + grip + 0.6])
                cylinder(d1=barb_dia, d2=dia*0.6, h=tip_len);
        }
        // Ranura longitudinal para flexión elástica
        translate([0, 0, head_t + total_shank - slit_len/2 + 0.1])
            cube([slit_w, dia + 2, slit_len + 0.2], center=true);
            
        // Alivio circular en la base de la ranura para evitar concentración de tensiones
        translate([0, 0, head_t + total_shank - slit_len])
            cylinder(d=slit_w, h=1.0);
    }
}

// ====================================================================
// 2. PASADOR CON RANURA ANULAR CIRCULAR (COMPATIBLE CON C-CLIP)
// ====================================================================
module hinge_pin_grip(grip=12, dia=4.4, head_d=8.8, head_t=2.5) {
    groove_d = 3.0; // Ranura de 3.0 mm
    groove_w = 1.8; // Ancho para clip de 1.4 mm
    tip_len = 2.0;
    shank_len = grip + 0.5 + groove_w + tip_len;
    
    difference() {
        union() {
            cylinder(d=head_d, h=head_t);
            translate([0, 0, head_t])
                cylinder(d=dia, h=shank_len);
            translate([0, 0, head_t + shank_len])
                cylinder(d1=dia, d2=dia*0.5, h=1.8);
        }
        // Ranura perimetral circular 360° (nunca se sale de ángulo)
        translate([0, 0, head_t + grip + 0.4])
            difference() {
                cylinder(d=dia + 2, h=groove_w);
                cylinder(d=groove_d, h=groove_w);
            }
    }
}

// Clip de retención con ajuste a presión (hace clic en la ranura de 3.0 mm)
module retainer_clip() {
    clip_t = 1.4;
    bore_r = 1.45; // Diámetro interior 2.9 mm (ajuste apretado con PETG)
    throat_w = 2.3; // Boca de 2.3 mm (requiere presión para pasar el eje de 3.0 mm)
    outer_r = 5.2;
    
    difference() {
        union() {
            cylinder(r=outer_r, h=clip_t);
            // Pestaña de extracción para sacarlo con la uña
            translate([-2.5, -outer_r - 2.5, 0])
                cube([5, 3.5, clip_t]);
            translate([0, -outer_r - 2.5, 0])
                cylinder(d=5, h=clip_t);
        }
        // Alojamiento circular del cuello
        translate([0, 0, -0.5])
            cylinder(r=bore_r, h=clip_t + 1);
        // Garganta de entrada elástica
        translate([0, outer_r/2, clip_t/2])
            cube([throat_w, outer_r + 1, clip_t + 1], center=true);
        // Chaflanes guía en la entrada
        translate([-throat_w/2 - 0.5, outer_r - 0.8, -0.5])
            rotate([0, 0, 45]) cube([1.5, 1.5, clip_t + 1]);
        translate([throat_w/2 + 0.5, outer_r - 0.8, -0.5])
            rotate([0, 0, 45]) cube([1.5, 1.5, clip_t + 1]);
    }
}

// ====================================================================
// 3. PASADOR ENRASADO PARA OREJETA DE BASE (CERO SALIENTE INFERIOR)
// ====================================================================
// Se inserta de arriba hacia abajo a través de la barra y la orejeta.
// Su longitud de 11.3 mm termina 0.7 mm antes de salir por la base,
// asegurando que la base del soporte descanse 100% plana en la mesa.
module flush_bracket_pin(ear_h=6.0, bar_h=6.0, head_d=8.5, head_t=2.0) {
    bar_dia = 4.6;   // Gira libre en la barra (orificio ~5.1 mm en PETG)
    ear_dia = 5.05;  // Ajuste elástico firme en la orejeta (orificio ~4.9-5.0 mm)
    
    bar_len = bar_h;        // 6.0 mm
    ear_len = ear_h - 0.7;  // 5.3 mm (deja 0.7 mm de aire libre al fondo)
    total_l = bar_len + ear_len; // 11.3 mm
    
    slit_w = 1.0;
    slit_l = 6.0;
    
    difference() {
        union() {
            // Cabeza ergonómica plana superior (apoya sobre la barra)
            cylinder(d=head_d, h=head_t);
            
            // Sección libre que atraviesa la barra
            translate([0, 0, head_t])
                cylinder(d=bar_dia, h=bar_len);
                
            // Sección inferior de fricción elástica dentro de la orejeta
            translate([0, 0, head_t + bar_len])
                cylinder(d1=ear_dia, d2=ear_dia*0.92, h=ear_len);
                
            // Chaflán de entrada en la punta
            translate([0, 0, head_t + total_l - 0.8])
                cylinder(d1=ear_dia*0.92, d2=3.8, h=0.8);
        }
        
        // Ranura de flexión elástica para comprimirse al insertarlo
        translate([0, 0, head_t + total_l - slit_l/2 + 0.1])
            cube([slit_w, ear_dia + 2, slit_l + 0.2], center=true);
            
        // Alivio de tensiones en la base de la ranura
        translate([0, 0, head_t + total_l - slit_l])
            cylinder(d=slit_w, h=1.0);
    }
}

// Vista previa
snap_pin(grip=12);
translate([15, 0, 0]) snap_pin(grip=6);
translate([30, 0, 0]) hinge_pin_grip(grip=12);
translate([45, 0, 0]) retainer_clip();
translate([60, 0, 0]) flush_bracket_pin();
