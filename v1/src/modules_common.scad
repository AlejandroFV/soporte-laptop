// ====================================================================
// UTILIDADES Y MÓDULOS COMUNES
// ====================================================================

// Cubo con esquinas redondeadas en el plano XY
module rounded_cube_xy(size, r=3, center=false) {
    x = size[0];
    y = size[1];
    z = size[2];
    rad = min(r, min(x/2, y/2));
    
    offset_x = center ? -x/2 : 0;
    offset_y = center ? -y/2 : 0;
    offset_z = center ? -z/2 : 0;

    translate([offset_x, offset_y, offset_z]) {
        hull() {
            translate([rad, rad, 0]) cylinder(r=rad, h=z);
            translate([x - rad, rad, 0]) cylinder(r=rad, h=z);
            translate([x - rad, y - rad, 0]) cylinder(r=rad, h=z);
            translate([rad, y - rad, 0]) cylinder(r=rad, h=z);
        }
    }
}

// Perfil de cola de milano macho para ensamble deslizante
module dovetail_male(w_base=12, w_neck=8, depth=6, height=14, tolerance=0) {
    b = w_base - 2*tolerance;
    n = w_neck - 2*tolerance;
    d = depth - tolerance;
    h = height;
    
    linear_extrude(height=h) {
        polygon(points=[
            [-b/2, 0],
            [b/2, 0],
            [n/2, d],
            [-n/2, d]
        ]);
    }
}

// Perfil de cola de milano hembra (ranura receptora)
module dovetail_female(w_base=12, w_neck=8, depth=6, height=14, tolerance=0.35) {
    b = w_base + 2*tolerance;
    n = w_neck + 2*tolerance;
    d = depth + tolerance;
    h = height + 1; // holgura z
    
    translate([0, -0.5, -0.5])
    linear_extrude(height=h) {
        polygon(points=[
            [-b/2, 0],
            [b/2, 0],
            [n/2, d],
            [-n/2, d]
        ]);
    }
}

// Perforación avellanada / con rebaje para cabeza de tornillo o pin
module pin_hole(dia=5.2, head_dia=9.5, head_depth=3.0, total_h=20) {
    cylinder(d=dia, h=total_h + 2, center=true);
    translate([0, 0, total_h/2 - head_depth + 0.1])
        cylinder(d=head_dia, h=head_depth + 1);
    translate([0, 0, -total_h/2 - 1])
        cylinder(d=head_dia, h=head_depth + 1);
}
