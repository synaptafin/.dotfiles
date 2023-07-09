#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

source ../functions/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Setting up Vim..."

find . -maxdepth 1 -not -name "setup.sh" | while read fn; do
    fn=$(basename $fn)
    # ignore . directory
    if [ "$fn" = "." ]; then
        continue
    fi
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished setting up Vim."