#! /usr/bin/env bash

source functions/functions.sh

DIR="home"
cd $DIR

SOURCE_DIR=$(pwd) # Directory where config stored

# config file directly locate under $HOME
echo "--- link file ---"
find $SOURCE_DIR -depth 1 -type f | sed 's/.*\///g' | while read target; do
  dest=$SOURCE_DIR/$target
  symbol=$HOME/$target
  symlink $dest $symbol
done

echo "--- link dictory ---"
find ${SOURCE_DIR} -d 1 -type d | sed 's/.*\///g' | while read config_dir; do
  if [ ! -d $HOME/$config_dir ]; then
    rm -f $HOME/$config_dir
    mkdir $HOME/$config_dir
  fi
  find $config_dir -d 1 | sed 's/.*\///g' | while read target; do
    dest=$SOURCE_DIR/$config_dir/$target
    symbol=$HOME/$config_dir/$target
    symlink $dest $symbol
  done
done

success "Setup complete!"
