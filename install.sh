#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
backup_dir=

for dependency in git vim readlink curl sha256sum; do
    if ! command -v "$dependency" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$dependency" >&2
        exit 1
    fi
done

prompt_identity() {
    local key=$1 label=$2 current value
    current=$(git config --global --includes --get "$key" || true)
    while true; do
        printf '%s [%s]: ' "$label" "$current" >&2
        if ! IFS= read -r value; then
            printf '\nInstallation cancelled: Git identity input is required.\n' >&2
            return 1
        fi
        value=${value:-$current}
        if [[ -n ${value//[[:space:]]/} ]]; then
            printf '%s\n' "$value"
            return
        fi
        printf '%s must not be empty.\n' "$label" >&2
    done
}

git_name=$(prompt_identity user.name 'Git user name')
git_email=$(prompt_identity user.email 'Git email')

link_config() {
    local source=$1 target=$2
    if [[ -L $target && $(readlink -- "$target") == "$source" ]]; then
        return
    fi
    if [[ -e $target || -L $target ]]; then
        if [[ -z $backup_dir ]]; then
            backup_dir=$(mktemp -d "$HOME/.dotfiles-backup.XXXXXXXX")
            printf 'Backing up existing files to %s\n' "$backup_dir"
        fi
        mv -- "$target" "$backup_dir/"
    fi
    ln -s -- "$source" "$target"
    printf 'Linked %s\n' "$target"
}

git_helpers_revision=a018953688f1b10bddf91bff8747068f5f4746a4

verify_git_helpers() {
    printf '%s  %s\n' \
        3b1018983d1ca279967403e65d1dac8b4afd30baafdf104f057a652c199015a6 "$1/git-completion.bash" \
        7ff718f4a06fd0a0be7edfef926abb41b1353c48c1515ad312d226965b74943a "$1/git-prompt.sh" |
        sha256sum --check --status
}

if [[ ! -f $repo_dir/bash/git-completion.bash || ! -f $repo_dir/bash/git-prompt.sh ]] ||
    ! verify_git_helpers "$repo_dir/bash" 2>/dev/null; then
    download_dir=$(mktemp -d "$repo_dir/bash/.git-helpers.XXXXXXXX")
    trap 'rm -rf -- "$download_dir"' EXIT
    for helper in git-completion.bash git-prompt.sh; do
        printf 'Downloading %s...\n' "$helper"
        curl --fail --silent --show-error --location --proto '=https' \
            --connect-timeout 15 --max-time 120 \
            --output "$download_dir/$helper" \
            "https://raw.githubusercontent.com/git/git/$git_helpers_revision/contrib/completion/$helper"
    done
    if ! verify_git_helpers "$download_dir"; then
        printf 'Git helper checksum verification failed; installation stopped.\n' >&2
        exit 1
    fi
    for helper in git-completion.bash git-prompt.sh; do
        mv -- "$download_dir/$helper" "$repo_dir/bash/$helper"
    done
fi

if [[ ! -f $repo_dir/vim/bundle/Vundle.vim/autoload/vundle.vim ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$repo_dir/vim/bundle/Vundle.vim"
fi

git config --file "$HOME/.gitconfig.local" user.name "$git_name"
git config --file "$HOME/.gitconfig.local" user.email "$git_email"

link_config "$repo_dir/bash/sh.bashrc" "$HOME/.bashrc"
link_config "$repo_dir/git/gitconfig" "$HOME/.gitconfig"
link_config "$repo_dir/vim" "$HOME/.vim"
link_config "$repo_dir/vim/vimrc" "$HOME/.vimrc"

printf 'Installing the existing Vim plugin list...\n'
vim -N -es -u "$HOME/.vimrc" -i NONE '+PluginInstall' '+qall'
printf 'Installed. Open a new Bash session to load your configuration.\n'