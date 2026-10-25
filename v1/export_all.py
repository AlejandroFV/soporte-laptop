import subprocess
import os

exports = [
    ("src/plate_accessories_folding.scad", "stl/plate_accessories_folding.stl", []),
    ("src/plate_accessories_rigid.scad", "stl/plate_accessories_rigid.stl", []),
    ("src/plate_flush_pins_x4.scad", "stl/flush_pins_x4.stl", []),
    ("src/simulation_assembled_pair.scad", "stl/simulation_assembled_bar_pair.stl", []),
    ("src/folding_link.scad", "stl/folding_links_x4.stl", []),
    ("src/rigid_crossbar.scad", "stl/rigid_crossbars_x2.stl", []),
    ("src/printed_pin.scad", "stl/pins_and_clips.stl", []),
    ("src/print_plate.scad", "stl/single_plate_complete.stl", []),
    ("src/bracket.scad", "stl/bracket_left.stl", ["-D", "is_right=false"]),
    ("src/bracket.scad", "stl/bracket_right.stl", ["-D", "is_right=true"]),
]

for src, out, extra in exports:
    print(f"Exporting {src} -> {out}...")
    cmd = ["openscad", "-o", out] + extra + [src]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        print(f"Error {src}: {res.stderr}")
    else:
        sz = os.path.getsize(out) / 1024
        print(f"Success: {out} ({sz:.1f} KB)")
