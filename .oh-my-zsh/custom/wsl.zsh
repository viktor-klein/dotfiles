# Custom git wrapper to route commands to either WSL Git or Windows Git
# - Always use WSL Git when:
#   - 'help' is the first argument (e.g., `git help status`)
#   - '--help' appears anywhere in the arguments
# - Use Windows Git (git.exe) when in /mnt/c/ path and not a help request
# - Default to WSL Git otherwise
# function git() {
#     # If the first argument is 'help', always use WSL Git
#     if [[ "$1" == "help" ]]; then
#         command git "$@"
#         return
#     fi
#
#     # Check for '--help' anywhere
#     for arg in "$@}"; do
#         if [[ "$arg" == "--help" ]]; then
#             command git "$@"
#             return
#         fi
#     done
#
#     if [[ "$(pwd)" == /mnt/c/* ]]; then
#         # Use Windows Git if inside the C: drive (mounted as /mnt/c/)
#         git.exe "$@"
#     else
#         # Use WSL Git for all other cases
#         command git "$@"
#     fi
# }
