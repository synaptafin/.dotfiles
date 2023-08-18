set fish_greeting ""

set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

if type -q lf
  alias lf="lfcd"
end

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

bind \cr fzf_select_history # Bind for peco select history to Ctrl+R
bind \cf fzf_change_directory # Bind for peco change directory to Ctrl+F

# vim-like
bind \cl forward-char

# prevent iterm2 from closing when typing Ctrl-D (EOF)
bind \cd delete-char

if status is-interactive
    # Commands to run in interactive sessions can go here
end

