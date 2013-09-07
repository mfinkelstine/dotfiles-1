# Resolve path until file is no longer a symlink
PROFILE_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$PROFILE_SOURCE" ]; do
	DOTFILES_DIR="$( cd -P "$( dirname "$PROFILE_SOURCE" )" && pwd )"
	PROFILE_SOURCE="$(readlink "$PROFILE_SOURCE")"
	[[ $PROFILE_SOURCE != /* ]] && PROFILE_SOURCE="$DIR/$PROFILE_SOURCE"
done
DOTFILES_DIR="$( cd -P "$( dirname "$PROFILE_SOURCE" )/.." && pwd )"

# Finally we can evaluate the actual files
for DOTFILE in `find "$DOTFILES_DIR"/system`
do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

[ -f "$DOTFILES_DIR"/git/.git-completion ] && source "$DOTFILES_DIR"/git/.git-completion

unset DOTFILE PROFILE_SOURCE DOTFILES_DIR
