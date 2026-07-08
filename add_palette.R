#!/usr/bin/env Rscript

# Simple script to add a new palette to palettes.R, palettes.py, palettes.json, and README.md
# Generates SVG swatches and stores them in the swatches/ folder
# 
# Usage:
#   source("add_palette.R")
#   OR
#   Rscript add_palette.R

library(jsonlite)

# Function to generate and save SVG swatches
generate_and_save_svg <- function(palette_name, colors) {
  # Determine swatch size and layout
  swatch_width <- 50
  swatch_height <- 50
  swatch_y <- 10
  text_y <- 75
  font_size <- 11
  char_width <- font_size * 0.62  # approx monospace glyph width
  min_slot_width <- 60
  gap <- 10

  labels <- names(colors)
  hex_vals <- unlist(colors)

  # Pick readable text colour: dark grey by default, white only when the
  # swatch itself is (near-)black and dark text would be illegible
  text_colour_for <- function(hex) {
    hex <- sub("^#", "", hex)
    r <- strtoi(substr(hex, 1, 2), 16L)
    g <- strtoi(substr(hex, 3, 4), 16L)
    b <- strtoi(substr(hex, 5, 6), 16L)
    luminance <- 0.299 * r + 0.587 * g + 0.114 * b
    if (luminance < 40) "#ffffff" else "#333333"
  }

  # Give each swatch enough width for its own label so long names don't overlap
  slot_widths <- pmax(min_slot_width, nchar(labels) * char_width + gap)

  body_lines <- character(0)
  x_pos <- 10
  for (i in seq_along(labels)) {
    slot_width <- slot_widths[i]
    rect_x <- x_pos + (slot_width - swatch_width) / 2
    text_x <- x_pos + slot_width / 2
    fill_colour <- text_colour_for(hex_vals[i])

    body_lines <- c(body_lines,
      sprintf('  <rect x="%.1f" y="%d" width="%d" height="%d" fill="%s" stroke="#ddd" stroke-width="1"/>',
              rect_x, swatch_y, swatch_width, swatch_height, hex_vals[i]),
      sprintf('  <text x="%.1f" y="%d" text-anchor="middle" font-size="%d" font-family="monospace" fill="%s">%s</text>',
              text_x, text_y, font_size, fill_colour, labels[i])
    )

    x_pos <- x_pos + slot_width + gap
  }

  total_width <- round(x_pos)
  total_height <- 100

  svg_lines <- c(
    '<?xml version="1.0" encoding="UTF-8"?>',
    sprintf('<svg width="%d" height="%d" xmlns="http://www.w3.org/2000/svg">', total_width, total_height),
    body_lines,
    '</svg>'
  )

  # Save to swatches folder
  if (!dir.exists("swatches")) {
    dir.create("swatches")
  }

  filename <- sprintf("swatches/%s.svg", palette_name)
  writeLines(svg_lines, filename)

  return(filename)
}

# Prompt user for palette details
cat("\n--- Add a new colour palette ---\n\n")

palette_name <- readline("Palette name (e.g., 'tissue_cols'): ")
palette_name <- trimws(palette_name)

if (palette_name == "") {
  stop("Palette name cannot be empty.")
}

cat("\nEnter colours as 'name = #HEX' (one per line, blank line to finish):\n")
cat("Example: Human = #219ebc\n\n")

colors <- list()
i <- 1
while (TRUE) {
  line <- readline(paste0("[", i, "] "))
  if (line == "") {
    break
  }
  
  # Parse "name = #HEX"
  parts <- strsplit(line, "=")[[1]]
  if (length(parts) != 2) {
    cat("  ⚠ Invalid format. Use 'name = #HEX'\n")
    next
  }
  
  name <- trimws(parts[1])
  hex <- trimws(parts[2])
  
  if (!grepl("^#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?$", hex)) {
    cat("  ⚠ Invalid hex code. Use #RRGGBB or #RRGGBBAA\n")
    next
  }
  
  colors[[name]] <- hex
  cat("  ✓ Added\n")
  i <- i + 1
}

if (length(colors) == 0) {
  stop("No colours provided.")
}

# Format for R
r_lines <- sprintf('  "%s" = "%s"', names(colors), unlist(colors))
r_code <- paste0(
  palette_name, " <- c(\n",
  paste(r_lines, collapse = ",\n"),
  "\n)"
)

# Format for Python
py_lines <- sprintf('    "%s": "%s"', names(colors), unlist(colors))
py_code <- paste0(
  palette_name, " = {\n",
  paste(py_lines, collapse = ",\n"),
  ",\n}"
)

# Generate and save SVG file, then create README section
svg_file <- generate_and_save_svg(palette_name, colors)
readme_section <- sprintf("### `%s`\n![%s](%s)", palette_name, palette_name, svg_file)

# Add to files
cat("\n--- Adding to files ---\n")

# R file
r_file <- "palettes.R"
if (file.exists(r_file)) {
  content <- readLines(r_file)
  content <- append(content, c("", r_code))
  writeLines(content, r_file)
  cat("✓ Added to", r_file, "\n")
}

# Python file
py_file <- "palettes.py"
if (file.exists(py_file)) {
  content <- readLines(py_file)
  content <- append(content, c("", py_code))
  writeLines(content, py_file)
  cat("✓ Added to", py_file, "\n")
}

# JSON file
json_file <- "palettes.json"
if (file.exists(json_file)) {
  data <- fromJSON(json_file)
  data[[palette_name]] <- colors
  write_json(data, json_file, pretty = TRUE)
  cat("✓ Added to", json_file, "\n")
}

# README file
readme_file <- "README.md"
if (file.exists(readme_file)) {
  content <- readLines(readme_file)
  
  # Find the line before "## Files" to insert the new palette section
  files_idx <- which(grepl("^## Files", content))
  if (length(files_idx) > 0) {
    insert_idx <- files_idx[1] - 1
    content <- append(content, 
                     c("", readme_section, ""),
                     after = insert_idx)
    writeLines(content, readme_file)
    cat("✓ Added to", readme_file, "\n")
  } else {
    cat("⚠ Could not find '## Files' section in README\n")
  }
}

cat("\nDone! Don't forget to commit and push:\n")
cat("  git add .\n")
cat("  git commit -m 'Add", palette_name, "palette'\n")
cat("  git push\n\n")
