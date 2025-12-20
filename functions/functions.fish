#!/usr/bin/env fish

# Fish shell version of functions.sh

# functions for create symlink and print info

# $argv[1] source file path
# $argv[2] symbolic link path
function symlink
    set OVERWRITTEN ""

    # remove existing link file
    if test -e "$argv[2]"; or test -h "$argv[2]"
        set OVERWRITTEN "(Overwritten)"
        if rm -r "$argv[2]"
            substep_success "Removed existing link $argv[2]."
        else
            substep_error "Failed to remove existing link $argv[2]."
        end
    end

    # create new link file
    if ln -s "$argv[1]" "$argv[2]"
        substep_success "Symlinked $argv[2] to $argv[1]. $OVERWRITTEN"
    else
        substep_error "Symlinking $argv[2] to $argv[1] failed."
    end
end

function clear_broken_symlinks
    find "$argv[1]" -xtype l | while read -l fn
        if rm "$fn"
            substep_success "Removed broken symlink at $fn."
        else
            substep_error "Failed to remove broken symlink at $fn."
        end
    end
end

# Printing functions
function coloredEcho
    set exp "$argv[1]"
    set color "$argv[2]"
    set arrow "$argv[3]"
    
    switch $color
        case black
            set color 0
        case red
            set color 1
        case green
            set color 2
        case yellow
            set color 3
        case blue
            set color 4
        case magenta
            set color 5
        case cyan
            set color 6
        case white '*'
            set color 7
    end
    
    tput bold
    tput setaf "$color"
    echo "$arrow $exp"
    tput sgr0
end

function info
    coloredEcho "$argv[1]" blue "========>"
end

function success
    coloredEcho "$argv[1]" green "========>"
end

function error
    coloredEcho "$argv[1]" red "========>"
end

function substep_info
    coloredEcho "$argv[1]" magenta "===="
end

function substep_success
    coloredEcho "$argv[1]" cyan "===="
end

function substep_error
    coloredEcho "$argv[1]" red "===="
end
