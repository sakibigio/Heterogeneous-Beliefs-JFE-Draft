# Configure latexmk to use build/ directory for auxiliary files
# This keeps the source directory clean

# Set output directory for all generated files (auxiliary files and PDF)
$out_dir = 'build';
$aux_dir = 'build';

# Ensure the build directory exists
system("mkdir -p build");

# Configure all LaTeX engines to output to build directory
# This ensures synctex works correctly
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build %O %S';
$latex = 'latex -interaction=nonstopmode -file-line-error -output-directory=build %O %S';

# Set PDF mode
$pdf_mode = 1;

# Let latexmk handle bibtex/biber automatically.
# With $aux_dir and $out_dir set to 'build', the default bibtex/biber
# commands work correctly, so we do not override them here.
# (If you ever need custom behavior, you can reintroduce custom $bibtex/$biber.)
# $bibtex_use = 1;
# $bibtex = 'cp build/%R.aux %R.aux && bibtex %R 2>&1 | grep -v "I found no" || true; mv %R.bbl build/%R.bbl 2>/dev/null || touch build/%R.bbl; rm -f %R.aux %R.blg 2>/dev/null || true';
# $biber = 'biber --output-directory=build %O %S';

# Clean up command - removes files from build directory
$clean_ext = 'bbl synctex.gz';

