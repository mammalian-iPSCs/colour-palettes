# colour-palettes

Shared colour palettes for mammalian iPSC / primate genomics projects. Plain,
static files — copy-paste or source directly, no build step, no dependencies.

## Files

- `palettes.R` — named vectors for R
- `palettes.py` — dicts for Python
- `palettes.json` — universal format for anything else (JS, Illustrator, etc.)

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

## Palettes

- `species_cols` — one colour per species
- `IUCN_COLOURS` — IUCN Red List category colours (LC, NT, VU, EN, CR, EW, EX, DD, NE)
- `class_col` — superclass colours (frozen from `ggsci::pal_aaas()`)

## Updating

Edit the value in all three files (`.R`, `.py`, `.json`) to keep them in sync.
