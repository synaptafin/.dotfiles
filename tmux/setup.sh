#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

source ../functions/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Setting up tmux..."

# link directory .tmux to ~/.tmux
# link .tmux.conf to ~/.tmux.conf
# link .tmux-powerlinerc to ~/.tmux-powerlinerc
find . -type f | cut -c 3- | while read fn; do
	if [ "$fn" = "." ]; then
		continue
	fi
  echo "source file: $SOURCE/$fn, link path: $DESTINATION/$fn"
	# symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

# success "Finished setting up tmux."
