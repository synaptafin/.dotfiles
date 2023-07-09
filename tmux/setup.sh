#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

source ../functions/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Setting up tmux..."

find . -maxdepth 1 -not -name "setup.sh" | while read fn; do
    fn=$(basename $fn)
    if [ "$fn" = "." ]; then
        continue
    fi
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished setting up tmux."