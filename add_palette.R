#!/usr/bin/env Rscript

# Simple script to add a new palette to palettes.R, palettes.py, and palettes.json
# 
# Usage:
#   source("add_palette.R")
#   OR
#   Rscript add_palette.R

library(jsonlite)

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

cat("\nDone! Don't forget to commit and push:\n")
cat("  git add .\n")
cat("  git commit -m 'Add", palette_name, "palette'\n")
cat("  git push\n\n")
