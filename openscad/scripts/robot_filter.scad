// --- Dimensions (Adjust as needed) ---
rect_width = 137;
rect_depth = 58;
loft_height = 40;
neck_height = 35;
neck_radius = 17.5;
wall_thick = 2;
bottom_cube_height = 4;
$fn = 100; // Smooth circles

module outer_shape() {
    // The transition part
    hull() {
        // Bottom rectangle (as a very thin cube)
        cube([rect_width, rect_depth, bottom_cube_height], center=true);
        // Top circle (as a very thin cylinder)
        translate([0, 0, loft_height])
            cylinder(h=0.01, r=neck_radius);
    }
    // The neck part
    translate([0, 0, loft_height])
        cylinder(h=neck_height, r=neck_radius);
}

module inner_shape() {
    // Reduce dimensions for the hollow inside
    hull() {
        cube([rect_width - 2*wall_thick, rect_depth - 2*wall_thick, bottom_cube_height], center=true);
        translate([0, 0, loft_height])
            cylinder(h=0.01, r=neck_radius - wall_thick);
    }
    translate([0, 0, loft_height])
        // Make it slightly taller to ensure a clean cut through the top
        cylinder(h=neck_height + 1, r=neck_radius - wall_thick);
}

// Final subtraction
difference() {
    outer_shape();
    // Lower the inner shape slightly to cut through the bottom
    translate([0, 0, -0.1])
        inner_shape();
}
