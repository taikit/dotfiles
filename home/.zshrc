# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).

# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(rails git  bundler brew)

# User configuration

export PATH="/usr/bin:/bin"
export PATH="/usr/local/bin:$PATH"
eval `/usr/libexec/path_helper -s`

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL='ja_JP.UTF-8'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

eval "$(rbenv init -)"
eval "$(pyenv init -)"
autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -v

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward

setopt auto_cd
function chpwd() { ls }
setopt correct
setopt list_packed

alias sb="subl"
alias at="atom"
alias op="open"

## 重複パスを登録しない
typeset -U path cdpath fpath manpath

## sudo用のpathを設定
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

## pathを設定
path=(~/bin(N-/) /usr/local/bin(N-/) ${path})

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH"
eval "$(direnv hook zsh)"
export PATH="/usr/local/sbin:$PATH"

## for MacVim
alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi=vim
alias vimdiff=/Applications/MacVim.app/Contents/MacOS/vimdiff
alias view=/Applications/MacVim.app/Contents/MacOS/view

alias ctags="`brew --prefix`/bin/ctags"
export GOPATH=~/.go

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# added for git hub
eval "$(hub alias -s)"

#Pyenvとの干渉のWarningを消す
alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:?/} brew"

alias zshconf="vim ~/.zshrc"
alias vimconf="vim ~/.vimrc"
alias tmuxconf="vim ~/.tmux.conf"
