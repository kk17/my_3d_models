// === C-Clamp - Screw with Knob (single component) ===
// Export this file as STL for printing.
// Print orientation: knob flat on bed, screw pointing up.
// The screw has external threads that mate with the frame,
// a ball tip at the bottom to seat into the swivel pad,
// and an integrated knob at the top for turning.

include <c-clamp-params.scad>;

module screw_with_knob() {
    union() {
        // --- Threaded shaft ---
        cylinder(d = screw_dia - 0.2, h = screw_len);
        thread_helix(screw_dia, screw_pitch, screw_len, thread_depth, male = true);

        // --- Ball tip at bottom (mates with pad socket) ---
        translate([0, 0, -ball_dia * 0.35])
            sphere(d = ball_dia);

        // --- Integrated knob at top ---
        translate([0, 0, screw_len]) {
            // base cylinder
            cylinder(d = knob_dia * 0.7, h = knob_height);
            // lobes for grip
            for (i = [0 : knob_lobes - 1]) {
                rotate([0, 0, i * (360 / knob_lobes)])
                    translate([knob_dia * 0.3, 0, 0])
                        cylinder(d = knob_dia * 0.35, h = knob_height);
            }
            // grip rings
            for (z = [2 : 2.5 : knob_height - 2]) {
                translate([0, 0, z])
                    difference() {
                        cylinder(d = knob_dia * 0.75, h = 1.2);
                        translate([0, 0, -0.1])
                            cylinder(d = knob_dia * 0.63, h = 1.4);
                    }
            }
        }
    }
}

screw_with_knob();

echo(str("Screw length: ", screw_len, "mm, Ball tip dia: ", ball_dia, "mm"));
