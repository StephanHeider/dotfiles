# Load Git bash completion
source "$sh_bashrc_dir/git-completion.bash"
source "$sh_bashrc_dir/git-prompt.sh"

# PROMPT
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\n \[\033[0;34m\]┌─────(\[\033[1;35m\]\u@\h\[\033[0;34m\])─────(\[\033[1;32m\]\w\[\033[0;35m\]$(__git_ps1 " (%s)")\[\033[0;34m\])'
PS1+=' \n └> \[\033[1;36m\]\$ \[\033[0m\]'
