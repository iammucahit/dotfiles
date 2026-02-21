
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
  local branch=$(git branch --show-current 2>/dev/null)
  [[ -z $branch ]] && return

  local dirty=""; [[ -n $(git status --porcelain 2>/dev/null) ]] && dirty="%F{yellow}*%f"
  
  local counts=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
  local indicators=""
  if [[ -n $counts ]]; then
    local ahead=$(echo $counts | awk '{print $1}')
    local behind=$(echo $counts | awk '{print $2}')
    [[ $ahead -gt 0 ]] && indicators+="%F{green}↑${ahead}%f"
    [[ $behind -gt 0 ]] && indicators+="%F{red}↓${behind}%f"
  fi

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
  zcompile ~/.zcompdump
fi