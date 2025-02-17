eval "$(starship init zsh)"

# Better history management
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

###############################
# Environment Variables
###############################


export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'

# Directories
export DOTFILES=$HOME/code/dotfiles
export CODEDIR=$HOME/code
export ICLOUD=$HOME/icloud
export ZETTELKASTEN=$HOME/zettelkasten
export SCRIPTS=$DOTFILES/scripts

# Go configuration
export GODEBUG=asyncpreemptoff=1
export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"

# Docker configuration
export DOCKER_DEFAULT_PLATFORM=linux/arm64

# Path configuration
path=(
    $HOME/.local/bin                          # pipx binaries, uv python installs
    /opt/homebrew/opt/postgresql@13/bin       # PostgreSQL
    $SCRIPTS
    ${GOPATH}/bin
    ${GOROOT}/bin
    $path
)
export PATH


# Plugin configuration
plugins=(
    git
    brew
    history
    kubectl
    docker
    aws
    history-substring-search
    zsh-autosuggestions        # Add if you have it installed
    zsh-syntax-highlighting    # Add if you have it installed
)

###############################
# Completion Settings
###############################

# Initialize completion system
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Tool-specific completions
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
complete -C '/opt/homebrew/bin/aws_completer' aws
complete -o nospace -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.2.0/terraform terraform

###############################
# Tool Configuration
###############################
# NVM configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


###############################
# Source Additional Files
###############################
# Source aliases first (so they're available in other sourced files)
if [ -f "$DOTFILES/.aliases" ]; then
    source "$DOTFILES/.aliases"
else
    echo "Warning: .aliases file not found in $DOTFILES"
fi

# Source configuration files
for config_file in ~/.{bashrc}; do
    [ -f "$config_file" ] && source "$config_file"
done


# Python configuration
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"

