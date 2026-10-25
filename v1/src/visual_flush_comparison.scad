// Comparativa visual: Pasador Antiguo vs Nuevo Pasador Enrasado
include <stand_config.scad>
use <folding_link.scad>
use <printed_pin.scad>
use <bracket.scad>

module assembly_joint_old() {
    // Orejeta base (Z = 0 a 6)
    color([0.8, 0.8, 0.8, 0.5]) {
        translate([0, 0, 0])
            cylinder(d=12, h=6);
    }
    // Barra plegable (Z = 6 a 12)
    color([0.25, 0.75, 0.35, 0.7]) {
        translate([0, 0, 6])
            cylinder(r=4.2, h=6);
    }
    // Pasador antiguo (insertado desde abajo hacia arriba, como en la foto)
    color([0.95, 0.25, 0.20]) {
        translate([0, 0, -2.5])
            snap_pin(grip=12, dia=4.4);
    }
    // Plano de la mesa (Z = 0)
    color([0.2, 0.4, 0.8, 0.3]) {
        translate([-15, -15, -0.2])
            cube([30, 30, 0.2]);
    }
}

module assembly_joint_new() {
    // Orejeta base (Z = 0 a 6)
    color([0.8, 0.8, 0.8, 0.5]) {
        translate([0, 0, 0])
            cylinder(d=12, h=6);
    }
    // Barra plegable (Z = 6 a 12)
    color([0.25, 0.75, 0.35, 0.7]) {
        translate([0, 0, 6])
            cylinder(r=4.2, h=6);
    }
    // Nuevo pasador enrasado (insertado desde arriba hacia abajo)
    color([0.15, 0.85, 0.35]) {
        translate([0, 0, 14.0])
        rotate([180, 0, 0])
            flush_bracket_pin();
    }
    // Plano de la mesa (Z = 0)
    color([0.2, 0.4, 0.8, 0.3]) {
        translate([-15, -15, -0.2])
            cube([30, 30, 0.2]);
    }
}

translate([-25, 0, 0]) assembly_joint_old();
translate([25, 0, 0]) assembly_joint_new();
