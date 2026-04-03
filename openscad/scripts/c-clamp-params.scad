// === C-Clamp - Shared Parameters & Thread Module ===
// Include this file in each component: include <c-clamp-params.scad>;

// --- Configurable Parameters ---
opening        = 70;    // jaw opening in mm (70mm = 7cm)
frame_thick    = 12;    // thickness of the C-frame cross-section
frame_width    = 20;    // width (depth into screen) of the frame
screw_dia      = 10;    // screw shaft diameter
screw_pitch    = 2.5;   // thread pitch (mm per turn)
thread_depth   = 1.0;   // thread tooth height
pad_dia        = 20;    // swivel pad diameter
pad_height     = 4;     // swivel pad thickness
knob_dia       = 24;    // handle knob diameter
knob_height    = 14;    // handle knob height
knob_lobes     = 4;     // number of knob lobes
clearance      = 0.3;   // thread clearance for printability
$fn            = 80;

// --- Derived ---
inner_h   = opening;
outer_h   = inner_h + 2 * frame_thick;
inner_w   = opening * 0.55;
outer_w   = inner_w + frame_thick;
screw_r   = screw_dia / 2;
screw_len = inner_w + frame_thick + pad_height + 5;
ball_dia  = screw_dia * 0.75;   // ball tip on screw / socket in pad

// === Shared Thread Profile ===
// Helical thread using linear_extrude of a triangular profile.
// male=true for external (screw), male=false for internal (nut hole in frame).
module thread_helix(d, pitch, length, depth, male = true) {
    turns = length / pitch;
    facets = max(36, round(turns * 48));
    cl = male ? 0 : clearance;
    r = d / 2 + (male ? 0 : cl);

    // trapezoidal tooth cross-section as 2D polygon
    tooth = [
        [r - depth, -pitch * 0.2],
        [r + depth * 0.6, 0],
        [r - depth, pitch * 0.2]
    ];

    for (i = [0 : facets - 1]) {
        a1 = i * (turns * 360) / facets;
        a2 = (i + 1) * (turns * 360) / facets;
        z1 = i * length / facets;
        z2 = (i + 1) * length / facets;
        hull() {
            translate([0, 0, z1]) rotate([0, 0, a1])
                translate([r, 0, 0])
                    sphere(d = depth * 0.9, $fn = 6);
            translate([0, 0, z2]) rotate([0, 0, a2])
                translate([r, 0, 0])
                    sphere(d = depth * 0.9, $fn = 6);
        }
    }
}
