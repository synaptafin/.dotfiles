#!/usr/bin/env fish

# Fish shell version of setup.sh

# Source functions
source functions/functions.fish

set DIR "home"
cd $DIR

set SOURCE_DIR (pwd) # Directory where config stored
echo $SOURCE_DIR

# config file directly locate under $HOME
echo "--- link file ---"
find "$SOURCE_DIR" -maxdepth 1 -type f | sed 's/.*\///g' | while read -l target
    set dest "$SOURCE_DIR/$target"
    set symbol "$HOME/$target"
    # symlink "$dest" "$symbol"
    echo "$dest -> $symbol"
end

echo "--- link dictory ---"
echo $SOURCE_DIR
find "$SOURCE_DIR" -maxdepth 1 -type d | sed 's/.*\///g' | while read -l config_dir
    if not test -d "$HOME/$config_dir"
        # rm -f "$HOME/$config_dir"
        # mkdir "$HOME/$config_dir"
    end

    echo "--- Linking files in directory: $config_dir ---"
    find "$SOURCE_DIR/$config_dir" -maxdepth 1 | sed 's/.*\///g' | while read -l target
        set dest "$SOURCE_DIR/$config_dir/$target"
        set symbol "$HOME/$config_dir/$target"
        # symlink "$dest" "$symbol"
        echo "$dest -> $symbol"
    end
end

success "Setup complete!"
