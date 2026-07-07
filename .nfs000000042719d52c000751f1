#!/usr/bin/env Rscript

# Simple script to add a new palette to palettes.R, palettes.py, palettes.json, and README.md
# 
# Usage:
#   source("add_palette.R")
#   OR
#   Rscript add_palette.R

library(jsonlite)

# Function to generate SVG swatches for the README
generate_svg_swatches <- function(palette_name, colors) {
  n_colors <- length(colors)
  
  # Determine swatch size and spacing
  if (n_colors <= 5) {
    swatch_width <- 50
    swatch_height <- 50
    spacing <- 60
    text_y_offset <- 65
  } else if (n_colors <= 9) {
    swatch_width <- 50
    swatch_height <- 50
    spacing <- 60
    text_y_offset <- 65
  } else {
    swatch_width <- 40
    swatch_height <- 40
    spacing <- 50
    text_y_offset <- 55
  }
  
  total_width <- n_colors * spacing
  svg_start <- sprintf('<svg width="%d" height="80" xmlns="http://www.w3.org/2000/svg">', total_width)
  
  svg_rects <- character(n_colors)
  for (i in seq_along(colors)) {
    x_pos <- (i - 1) * spacing
    label <- names(colors)[i]
    hex_val <- unlist(colors)[i]
    
    svg_rects[i] <- sprintf(
      '  <rect x="%d" y="0" width="%d" height="%d" fill="%s" stroke="#ddd" stroke-width="1"/>\n  <text x="%d" y="%d" text-anchor="middle" font-size="11" font-family="monospace">%s</text>',
      x_pos, swatch_width, swatch_height, hex_val,
      x_pos + swatch_width / 2, text_y_offset, label
    )
  }
  
  svg_end <- '</svg>'
  
  svg_code <- paste(c(svg_start, svg_rects, svg_end), collapse = "\n")
  return(svg_code)
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

# Generate SVG for README
svg_code <- generate_svg_swatches(palette_name, colors)
readme_section <- sprintf("### `%s`\n%s", palette_name, svg_code)

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
