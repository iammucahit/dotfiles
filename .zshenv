
# =====================
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# =====================
# Zinit Plugin Manager
# =====================
# Clone zinit if not installed
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# =================
# Zsh Plugins
# =================
# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# Completions
zinit light zsh-users/zsh-completions

# FZF tab integration
zinit light Aloxaf/fzf-tab

# ===================
# Completion System
# ===================
autoload -Uz compinit

# Only rebuild compdump if older than 24 hours
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Style completions using LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

# FZF-tab preview configurations
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ================
# Key Bindings
# ================
bindkey -e                                           # Emacs keybindings
bindkey '^p' history-search-backward                 # Ctrl+P for backward history
bindkey '^n' history-search-forward                  # Ctrl+N for forward history
bindkey '^[w' kill-region                            # Alt+W to delete line

# ==============
# History
# ==============
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# ============
# Aliases
# ============
alias ls='ls --color=auto'
alias c='clear'

# ================
# PATH Settings
# ================
# Add directories to PATH if they exist
path_dirs=(
    /usr/local/bin
    $HOME/.local/bin
    $HOME/bin
    /opt/nvim-linux-x86_64/bin
    $HOME/.fzf/bin
)

for dir in ${path_dirs[@]}; do
    if [[ -d $dir ]]; then
        path+=$dir
    fi
done

export PATH

# ===================
# Shell Integrations
# ===================
# Oh My Posh prompt
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/iammucahit/oh-my-posh/refs/heads/main/themes/pure.omp.json')"
fi

# Zoxide (smarter cd)
eval "$(zoxide init --cmd cd zsh)"

# FZF integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Final Initialization
zinit cdreplay -q  # Replay compdefs after loading all plugins
