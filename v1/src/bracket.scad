// ====================================================================
// SOPORTE LATERAL V1 (3 RANURAS FÍSICAS INDEPENDIENTES)
//   1. Ranura Frontal: Tablet Samsung Galaxy Tab S11 Ultra (16 mm, 55°)
//   2. Ranura Media: MacBook Pro 13" (28 mm, Rampa ergonómica 38°)
//   3. Ranura Trasera: Dell Latitude 7650 Vertical (28 mm, 75° paralelo)
// ====================================================================

include <stand_config.scad>
use <modules_common.scad>

module raw_bracket_polygon() {
    polygon(points=[
        // Suelo plano de apoyo sobre la cama (Z = 0)
        [0, 0],
        [232, 0],
        
        // Pata trasera y torre vertical
        [228, 20],
        [200, 120], // Cúspide de la torre trasera
        [187, 120],
        
        // --- RANURA 3: VERTICAL A 75° (Para Dell Latitude / Laptops 180°) ---
        // Cara posterior de la ranura vertical (75.4°)
        [163, 28],  // Fondo posterior de la ranura vertical
        [135, 28],  // Fondo frontal de la ranura vertical -> ¡163 - 135 = 28.0 mm exactos!
        
        // Divisor 2: Entre ranura vertical y rampa de MacBook
        [146, 70],  // Cara frontal de la ranura vertical (75.3°)
        [138, 70],  // Cresta divisoria
        
        // --- RANURA 2: MACBOOK PRO A 38° ---
        // Rampa ergonómica para MacBook Pro (ángulo exacto 38.16°)
        [82, 26],   // Fin de la rampa a 38°
        [54, 26],   // Asiento horizontal para la laptop -> ¡82 - 54 = 28.0 mm!
        
        // Divisor 1: Gancho retenedor entre Laptop y Tablet
        [50, 50],   // Pared de retención del gancho de laptop
        [42, 50],   // Cresta del gancho
        
        // --- RANURA 1: TABLET SAMSUNG GALAXY TAB S11 ULTRA A 55° ---
        // Respaldo de la tablet
        [32, 12],   // Fondo posterior de la ranura de tablet
        [16, 12],   // Fondo frontal de la ranura de tablet -> ¡32 - 16 = 16.0 mm!
        
        // Labio frontal retenedor de tablet
        [12, 28],   // Cara posterior del labio frontal
        [4, 28],    // Cúspide del labio frontal
        [0, 14],    // Cara frontal inclinada
        [0, 0]
    ]);
}

module bracket_profile_2d() {
    difference() {
        // Redondeo suave de todas las crestas de apoyo superiores (r=3.5mm)
        // para proteger el aluminio de laptops y tablets contra rayones,
        // conservando la base Z=0 100% plana para adherencia a la cama.
        intersection() {
            translate([0, 0]) square([232, 200]);
            offset(r=-1.8)
            offset(r=1.8)
            offset(r=3.5)
            offset(r=-3.5)
                raw_bracket_polygon();
        }

        // Ventana triangular trasera para cables (idéntica a la foto)
        polygon(points=[
            [175, 10],
            [210, 10],
            [180, 85]
        ]);
        
        // Ventana de aligeramiento central bajo la rampa de laptop
        polygon(points=[
            [85, 8],
            [130, 8],
            [118, 20],
            [90, 20]
        ]);
    }
}

module bracket(is_right=false) {
    mirror_x = is_right ? 1 : 0;
    
    mirror([mirror_x, 0, 0]) {
        difference() {
            union() {
                // Cuerpo principal extruido del perfil 2D
                rotate([90, 0, 90])
                linear_extrude(height=bracket_width) {
                    bracket_profile_2d();
                }
                
                // Orejetas interiores con pivote vertical (eje Z)
                // Orejeta trasera (Y = 165) a 5.0mm de la pared (idéntica a la pieza impresa del usuario)
                translate([bracket_width, 165, 0])
                hull() {
                    translate([0, -6, 0]) cube([1, 12, 6]);
                    translate([5, 0, 0]) cylinder(d=12, h=6);
                }
                    
                // Orejeta delantera/media (Y = 75)
                translate([bracket_width, 75, 0])
                hull() {
                    translate([0, -6, 0]) cube([1, 12, 6]);
                    translate([5, 0, 0]) cylinder(d=12, h=6);
                }
            }
            
            // Orificios verticales de bisagra (eje Z)
            translate([bracket_width + 5, 165, -1])
                cylinder(d=5.2, h=8);
                
            translate([bracket_width + 5, 75, -1])
                cylinder(d=5.2, h=8);
                
            // Rebajes circulares inferiores para topes de goma antideslizantes (diámetro 9mm, profundidad 1.2mm)
            translate([bracket_width/2, 20, -0.1])
                cylinder(d=9.0, h=1.5);
            translate([bracket_width/2, 115, -0.1])
                cylinder(d=9.0, h=1.5);
            translate([bracket_width/2, 215, -0.1])
                cylinder(d=9.0, h=1.5);
        }
    }
}

// Vista previa
bracket(is_right=false);
