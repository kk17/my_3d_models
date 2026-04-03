// === C-Clamp - Assembly View ===
// This file assembles all components for visualization.
// For printing, export each component file individually:
//   c-clamp-frame.scad  - the C-shaped body (with internal threads)
//   c-clamp-screw.scad  - the threaded screw with integrated knob
//   c-clamp-pad.scad    - the swivel pad (with ball socket)
// All parameters are shared via c-clamp-params.scad

include <c-clamp-params.scad>;
use <c-clamp-frame.scad>;
use <c-clamp-screw.scad>;
use <c-clamp-pad.scad>;

// === Assembled view ===
color("Green") c_frame();

hole_x = outer_w - frame_thick / 2;
hole_y = frame_width / 2;
screw_bottom_z = outer_h - frame_thick - screw_len + frame_thick;

// screw + knob (threads through the top jaw)
translate([hole_x, hole_y, screw_bottom_z])
    color("DimGray") screw_with_knob();

// swivel pad (sits under the screw ball tip on the bottom jaw)
translate([hole_x, hole_y, frame_thick])
    color("Gray") swivel_pad();

// === Info ===
echo(str("C-Clamp: opening=", opening, "mm, frame=", frame_thick,
         "mm, screw=", screw_dia, "mm"));
