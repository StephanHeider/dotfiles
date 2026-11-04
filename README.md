# dotfiles

My existing Bash, Git, and Vim configuration, organized by application and
installed with symlinks. No additional tools, settings, or plugins are bundled.

## Install

Requires Linux, Bash, Git, Vim, curl, GNU coreutils (including `readlink -f` and
`sha256sum`), and an internet connection for Git helpers and the existing Vim
plugins. The current Bash `cp` alias
uses `rsync`; install it separately if you use that alias.

Clone this repository anywhere you want to keep it, then run:

```bash
cd dotfiles
bash install.sh
```

The installer asks for your Git user name and email, offering the machine's
existing values as defaults. They are saved in `~/.gitconfig.local`, outside
this repository, and included by the shared Git configuration.

Existing `~/.bashrc`, `~/.gitconfig`, `~/.vim`, and `~/.vimrc` are moved to a
unique `~/.dotfiles-backup.*` directory before being replaced with symlinks.
Already-correct links are left alone, so the installer can be run again.
Your old configurations are not merged; retain the backup for any
machine-specific settings you still need.

Git's Bash completion and prompt scripts are downloaded from the official Git
repository at a pinned Git v2.56.0 commit. SHA-256 checksums are verified before
the scripts are activated or home configuration is changed. Verified downloads
are reused on subsequent runs. These files stay in `bash/` but are ignored by
Git, not bundled in this repository. Failed or invalid downloads stop the
installer; rerun it after resolving the problem.

Vundle and only the plugins already declared in your Vim configuration are
downloaded into `vim/bundle/`, which Git ignores. No system packages are
installed and no administrator access is required. A failed plugin download
may leave a partial installation; fix connectivity and rerun the installer.

Open a new Bash session after installing. Keep the checkout in place: the
installed symlinks point to it, and edits take effect directly from this repo.

## Layout

```text
bash/          Bash settings, aliases, prompt, and ignored Git helper downloads
git/           Shared Git settings, without personal identity
vim/           Vim settings, filetype configuration, and Vundle plugin list
install.sh     Git identity prompts, backups, symlinks, and Vim plugin setup
```

The imported Vim configuration comes from `~/MyVIM`; its filetype settings
and plugin list are preserved. The original source directories are untouched.

## Restore

Remove only the symlinks created by this installer and move the corresponding
files out of the backup directory to their original locations. Git identity is
stored separately in `~/.gitconfig.local`; keep or remove it as appropriate.