
# Path
typeset -U path
path=(
    /usr/local/bin
    $HOME/.local/bin
    $HOME/bin
    /opt/nvim-linux-x86_64/bin
    $HOME/.fzf/bin
    $path
)
export PATH
export EDITOR='vim'

# Completion
autoload -Uz compinit
compinit -C -d ~/.zcompdump

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


# Prompt
setopt PROMPT_SUBST
git_info() {
  local status_info=$(git status --porcelain=v2 --branch 2>/dev/null)
  [[ -z $status_info ]] && return

  local branch=$(echo "$status_info" | grep '^# branch.head' | awk '{print $3}')
  local ab_info=$(echo "$status_info" | grep '^# branch.ab')
  
  local indicators=""
  if [[ -n $ab_info ]]; then
    local ahead=$(echo "$ab_info" | awk '{print $3}')
    local behind=$(echo "$ab_info" | awk '{print $4}')
    [[ $ahead != "+0" ]] && indicators+="%F{green}↑${ahead#+}%f"
    [[ $behind != "-0" ]] && indicators+="%F{red}↓${behind#-}%f"
  fi

  local dirty=""; [[ $(echo "$status_info" | grep -v '^#' | wc -l) -gt 0 ]] && dirty="%F{yellow}*%f"

  echo " %F{242}on %F{cyan}$branch%f${dirty} $indicators"
}

PROMPT='%F{blue}%~%f$(git_info)
%F{magenta}❯%f '


# Misc
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt sharehistory hist_ignore_all_dups interactivecomments

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'


# Integrations
[[ -f ~/.zoxide.zsh ]] && source ~/.zoxide.zsh
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh


# Cleanup
if [[ -f ~/.zcompdump ]]; then
  zcompile -U ~/.zcompdump
fi