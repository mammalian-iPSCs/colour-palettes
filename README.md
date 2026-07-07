# colour-palettes

Shared colour palettes for mammalian iPSC / primate genomics projects. Plain,
static files — copy-paste or source directly, no build step, no dependencies.

## Preview

To view the palette swatches, run a local HTTP server in this folder:

```bash
python -m http.server 8000
```

Then open `http://localhost:8000` in your browser and click `preview.html`. 

(You can't open the HTML file directly as `file://` due to browser security — it needs to be served over HTTP.)

Alternatively, if you use VS Code, install the [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) extension and right-click → "Open with Live Server".

## Files

- `palettes.R` — named vectors for R
- `palettes.py` — dicts for Python
- `palettes.json` — universal format for anything else (JS, Illustrator, etc.)
- `add_palette.R` — script to add new palettes

## Usage

**R**, source directly from GitHub:

```r
source("https://raw.githubusercontent.com/mammalian-iPSCs/colour-palettes/main/palettes.R")
```

**Python**, copy `palettes.py` into your project or:

```python
import urllib.request
exec(urllib.request.urlopen(
    "https://raw.githubusercontent.com/mammalian-iPSCs/colour-palettes/main/palettes.py"
).read())
```

**Anything else**, use `palettes.json`.

## Current Palettes

- `species_cols` — one colour per species
- `IUCN_COLOURS` — IUCN Red List category colours (LC, NT, VU, EN, CR, EW, EX, DD, NE)
- `class_col` — superclass colours (Fish, Amphibia, Reptil, Birds, Mammalia)

## Adding a new palette

```r
source("add_palette.R")
```

Then follow the prompts. The script will add your palette to all three files (R, Python, JSON) automatically.
