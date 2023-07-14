#! /usr/bin/env bash

source functions/functions.sh

DIR="home"
cd $DIR

SOURCE_DIR=$(pwd)
DEST_DIR=$HOME

# config file directly locate under $HOME
echo "--- link config file directly locate under $HOME ---"
find $SOURCE_DIR -depth 1 -type f | while read path; do
  target=$(basename $path)
  symlink $path $DEST_DIR/$target
done

# link directory in .config directory for nvim, lf, etc.
echo "--- link directory in .config ---"
find $SOURCE_DIR/.config -depth 1 -type d | while read path; do
  target=$(basename $path)
  symlink $SOURCE_DIR/.config/$target $DEST_DIR/.config/$target
done

# link .tmux directory for tmux plugin
echo "--- setup tmux plugin ---"
if [[ -d ".tmux" ]]; then
  symlink $SOURCE_DIR/.tmux $DEST_DIR/.tmux
fi

success "Setup complete!"
