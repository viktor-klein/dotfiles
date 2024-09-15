# Generate a consistent SHA-256 hash representing the contents of all files in a directory.
# It handles filenames safely (spaces, newlines), sorts them for stable output,
# and hashes the combined result.
# Usage: hashdir [target_directory]
# Defaults: .
hashdir() {
    local target="${1:-.}"
    (cd "$target" && find . -type f -print0 | sort -z | xargs -0 sha256sum | sha256sum)
}

# Compress top-level .jpg images in a directory, saving optimized copies
# with a `_opt.jpg` suffix next to the original files. Original images are not modified.
# Usage: compress_jpgs [target_directory] [quality]
compress_jpgs() {
    local target="${1:-.}"
    local quality="${2:-85}"

    (
        cd "$target" || exit 1
        find . -maxdepth 1 -type f -iname '*.jpg' | while IFS= read -r img; do
            local base_name
            base_name="$(basename "$img" .jpg)"
            local output_path="./${base_name}_opt.jpg"
            convert "$img" -quality "$quality" "$output_path"
        done
    )
}

# Converts all top-level .jpg files from the specified directory into a processed grayscale PDF.
# The resulting PDF is saved in the current working directory.
# Usage: convert_scans [input_directory] [output_filename] [resample_dpi] [threshold] [shave_pixels]
# Defaults: ., output.pdf, 300, 60%, 50
convert_scans() {
    local input_dir="${1:-.}"
    local output="${2:-output.pdf}"
    local resample="${3:-300}"
    local threshold="${4:-60%}"
    local shave="${5:-50}"

    convert "$input_dir"/*.jpg \
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
