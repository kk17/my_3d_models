// === C-Clamp - Frame Component ===
// Export this file as STL for printing the C-frame body.
// Print orientation: lay flat on the bottom jaw.
// The top jaw has internal threads so the screw can grip.

include <c-clamp-params.scad>;

module _corner_gusset(flip, cx, cy) {
    gusset_r = frame_thick * 0.8;
    translate([cx, 0, cy]) {
        mirror([0, 0, flip])
        difference() {
            cube([gusset_r, frame_width, gusset_r]);
            translate([gusset_r, -1, gusset_r])
                rotate([-90, 0, 0])
                    cylinder(r = gusset_r, h = frame_width + 2);
        }
    }
}

module c_frame() {
    hole_x = outer_w - frame_thick / 2;
    hole_y = frame_width / 2;

    difference() {
        union() {
            // left vertical leg
            cube([frame_thick, frame_width, outer_h]);

            // bottom horizontal jaw
            cube([outer_w, frame_width, frame_thick]);

            // top horizontal jaw with extra boss for thread depth
            translate([0, 0, outer_h - frame_thick])
                cube([outer_w, frame_width, frame_thick]);

            // threaded boss protruding upward for more thread engagement
            translate([hole_x, hole_y, outer_h])
                cylinder(d = screw_dia + 6, h = 4);

            // corner reinforcement fillets
            _corner_gusset(0, frame_thick, frame_thick);
            _corner_gusset(1, frame_thick, outer_h - frame_thick);
        }

        // bore hole through top jaw + boss
        translate([hole_x, hole_y, outer_h - frame_thick - 1])
            cylinder(d = screw_dia + clearance * 2, h = frame_thick + 4 + 2);

        // internal thread cut into the bore
        translate([hole_x, hole_y, outer_h - frame_thick - 0.5])
            thread_helix(screw_dia + clearance * 2, screw_pitch,
                         frame_thick + 4 + 1, thread_depth, male = false);
    }
}

c_frame();
