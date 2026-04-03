// === C-Clamp - Swivel Pad Component ===
// Export this file as STL for printing the swivel pad.
// Print orientation: flat side down.
// The pad has a hemispherical socket on top that captures
// the ball tip of the screw, allowing swivel motion.

include <c-clamp-params.scad>;

module swivel_pad() {
    socket_d = ball_dia + clearance * 2;

    difference() {
        union() {
            // main pad disc
            cylinder(d = pad_dia, h = pad_height);
            // raised collar around the socket for ball retention
            translate([0, 0, pad_height])
                cylinder(d = socket_d + 3, h = ball_dia * 0.4);
        }

        // hemispherical socket to capture ball tip
        translate([0, 0, pad_height + ball_dia * 0.4])
            sphere(d = socket_d);

        // entry slot so the ball can snap in (slightly narrower than ball)
        translate([0, 0, pad_height + ball_dia * 0.35])
            cylinder(d = socket_d * 0.7, h = ball_dia * 0.3);
    }
}

swivel_pad();
