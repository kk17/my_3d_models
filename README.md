# My 3D Models

This workspace is set up for 3D model development using CadQuery (primary) and OpenSCAD (secondary), managed with uv.

## Setup

1. Install uv if not already installed.
2. Run `uv sync` to install dependencies.
3. For CadQuery models, place scripts in `cadquery/src/models/`.
4. For OpenSCAD scripts, place in `openscad/scripts/`.

## Running CadQuery Models

Use `uv run python cadquery/src/models/your_model.py` to execute a model script.

## Testing

Run `uv run pytest cadquery/tests/` to run tests.

## Exports

Generated files (STL, STEP, etc.) are placed in `cadquery/exports/` or `openscad/exports/`.
