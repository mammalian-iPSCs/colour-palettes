# colour-palettes

Shared colour palettes for mammalian iPSC / primate genomics projects. Plain,
static files — copy-paste or source directly, no build step, no dependencies.

## Palettes

### `species_cols`
<svg width="520" height="60" xmlns="http://www.w3.org/2000/svg">
  <rect x="0" y="0" width="60" height="60" fill="#219ebc" stroke="#ddd" stroke-width="1"/>
  <text x="30" y="75" text-anchor="middle" font-size="11" font-family="monospace">Homo sapiens</text>
  
  <rect x="70" y="0" width="60" height="60" fill="#51485E" stroke="#ddd" stroke-width="1"/>
  <text x="100" y="75" text-anchor="middle" font-size="11" font-family="monospace">Pan troglodytes</text>
  
  <rect x="140" y="0" width="60" height="60" fill="#023047" stroke="#ddd" stroke-width="1"/>
  <text x="170" y="75" text-anchor="middle" font-size="11" font-family="monospace">Gorilla gorilla</text>
  
  <rect x="210" y="0" width="60" height="60" fill="#fb8500" stroke="#ddd" stroke-width="1"/>
  <text x="240" y="75" text-anchor="middle" font-size="11" font-family="monospace">Pongo pygmaeus</text>
  
  <rect x="280" y="0" width="60" height="60" fill="#8ecae6" stroke="#ddd" stroke-width="1"/>
  <text x="310" y="75" text-anchor="middle" font-size="11" font-family="monospace">M. ogouensis</text>
  
  <rect x="350" y="0" width="60" height="60" fill="#ffb703" stroke="#ddd" stroke-width="1"/>
  <text x="380" y="75" text-anchor="middle" font-size="11" font-family="monospace">M. sphinx</text>
  
  <rect x="420" y="0" width="60" height="60" fill="#6a994e" stroke="#ddd" stroke-width="1"/>
  <text x="450" y="75" text-anchor="middle" font-size="11" font-family="monospace">A. hybridus</text>
</svg>

### `IUCN_COLOURS`
<svg width="520" height="60" xmlns="http://www.w3.org/2000/svg">
  <rect x="0" y="0" width="50" height="50" fill="#60C659" stroke="#ddd" stroke-width="1"/>
  <text x="25" y="65" text-anchor="middle" font-size="11" font-family="monospace">LC</text>
  
  <rect x="60" y="0" width="50" height="50" fill="#CCE226" stroke="#ddd" stroke-width="1"/>
  <text x="85" y="65" text-anchor="middle" font-size="11" font-family="monospace">NT</text>
  
  <rect x="120" y="0" width="50" height="50" fill="#F9E814" stroke="#ddd" stroke-width="1"/>
  <text x="145" y="65" text-anchor="middle" font-size="11" font-family="monospace">VU</text>
  
  <rect x="180" y="0" width="50" height="50" fill="#FC7F3F" stroke="#ddd" stroke-width="1"/>
  <text x="205" y="65" text-anchor="middle" font-size="11" font-family="monospace">EN</text>
  
  <rect x="240" y="0" width="50" height="50" fill="#D81E05" stroke="#ddd" stroke-width="1"/>
  <text x="265" y="65" text-anchor="middle" font-size="11" font-family="monospace">CR</text>
  
  <rect x="300" y="0" width="50" height="50" fill="#542344" stroke="#ddd" stroke-width="1"/>
  <text x="325" y="65" text-anchor="middle" font-size="11" font-family="monospace">EW</text>
  
  <rect x="360" y="0" width="50" height="50" fill="#000000" stroke="#ddd" stroke-width="1"/>
  <text x="385" y="65" text-anchor="middle" font-size="11" font-family="monospace">EX</text>
  
  <rect x="420" y="0" width="50" height="50" fill="#D1D1C6" stroke="#ddd" stroke-width="1"/>
  <text x="445" y="65" text-anchor="middle" font-size="11" font-family="monospace">DD</text>
  
  <rect x="480" y="0" width="50" height="50" fill="#AAAAAA" stroke="#ddd" stroke-width="1"/>
  <text x="505" y="65" text-anchor="middle" font-size="11" font-family="monospace">NE</text>
</svg>

### `class_col`
<svg width="300" height="60" xmlns="http://www.w3.org/2000/svg">
  <rect x="0" y="0" width="50" height="50" fill="#3B4992FF" stroke="#ddd" stroke-width="1"/>
  <text x="25" y="65" text-anchor="middle" font-size="11" font-family="monospace">Fish</text>
  
  <rect x="60" y="0" width="50" height="50" fill="#EE0000FF" stroke="#ddd" stroke-width="1"/>
  <text x="85" y="65" text-anchor="middle" font-size="11" font-family="monospace">Amphibia</text>
  
  <rect x="120" y="0" width="50" height="50" fill="#008B45FF" stroke="#ddd" stroke-width="1"/>
  <text x="145" y="65" text-anchor="middle" font-size="11" font-family="monospace">Reptil</text>
  
  <rect x="180" y="0" width="50" height="50" fill="#631879FF" stroke="#ddd" stroke-width="1"/>
  <text x="205" y="65" text-anchor="middle" font-size="11" font-family="monospace">Birds</text>
  
  <rect x="240" y="0" width="50" height="50" fill="#008280FF" stroke="#ddd" stroke-width="1"/>
  <text x="265" y="65" text-anchor="middle" font-size="11" font-family="monospace">Mammalia</text>
</svg>

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



## Adding a new palette

```r
source("add_palette.R")
```

Then follow the prompts. The script will add your palette to all three files (R, Python, JSON) automatically.
