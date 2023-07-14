#! /usr/bin/env bash

# OS detection
UNAME_OUTPUT=$(uname -s)

case "$UNAME_OUTPUT" in
Linux*) OS=LINUX ;;
Darwin*) OS=DARWIN ;; *) OS=UNSUPPORTED ;; esac

if [[ $OS == "UNSUPPORTED" ]]; then
	echo "Sorry, this OS is not supported at this time: $OS"
	exit 1
fi

echo "Detected Operating System: $OS"

DIR=$(dirname $0)
echo $DIR

# load utils functions
source ./functions/functions.sh

# make sure sudo permission when process is running
# info "Propmting for sudo password"
# if sudo -v; then
# 	# Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
# 	while true; do
# 		sudo -n true         # refresh sudo credentials sleep 60             # test credentials every minute
# 		kill -0 "$$" || exit # if process exists, keep loop
# 	done 2>/dev/null &     # execute in background
# 	success "Sudo credentials updated."
# else
# 	error "Failed to obtain sudo credentials."
# fi

# brew bundle --file ~/.dotfiles/Brewfile
sh setup.sh

success "Finish installing Dotfiles"

