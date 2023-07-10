# Sync local config
# after

find . -not -path './.git/*' -not -name 'setup.sh' | cut -c 3- | while read file; do
	echo "Syncing $file"
	# cp -r $file ~/$file
done

