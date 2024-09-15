# Generate a consistent SHA-256 hash representing the contents of all files in a directory.
# It handles filenames safely (spaces, newlines), sorts them for stable output,
# and hashes the combined result. Defaults to current directory if no argument is given.
hashdir() {
    local target="${1:-.}" # Default to current directory if none given
    find "$target" -type f -print0 | sort -z | xargs -0 sha256sum | sha256sum
}

# Converts all .jpg files in the current directory to a processed grayscale PDF.
# Usage: convert_scans [output_filename] [resample_dpi] [threshold] [shave_pixels]
# Defaults: output.pdf, 300, 60%, 50
convert_scans() {
    local output="${1:-output.pdf}"
    local resample="${2:-300}"
    local threshold="${3:-60%}"
    local shave="${4:-50}"

    convert ./*.jpg \
        -colorspace Gray \
        -normalize \
        -threshold "$threshold" \
        -despeckle \
        -shave "$shave" \
        -bordercolor white \
        -border "$shave" \
        -resample "$resample" \
        "$output"
}
