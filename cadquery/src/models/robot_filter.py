import cadquery as cq

# --- Dimensions (Adjust as needed) ---
rect_width = 120.0
rect_depth = 60.0
loft_height = 40.0
neck_height = 20.0
neck_radius = 20.0
wall_thickness = 2.0

# 1. Define the bottom rectangular wire
bottom_wire = cq.Workplane("XY").rect(rect_width, rect_depth)

# 2. Define the top circular wire at the correct height
top_wire = cq.Workplane("XY").workplane(offset=loft_height).circle(neck_radius)

# 3. Create the solid loft between the two wires
main_body = bottom_wire.loft(top_wire)

# 4. Add the cylindrical neck on top
# Select the top face (">Z"), draw a circle, and extrude it.
full_solid = main_body.faces(">Z").workplane().circle(neck_radius).extrude(neck_height)

# 5. Hollow out the entire object
# Select the bottom face ("<Z") and shell inwards by the thickness.
result = full_solid.faces("<Z").shell(-wall_thickness)

# Export to STEP for the best quality in Bambu Studio
cq.exporters.export(result, "nozzle.step")
