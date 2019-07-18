# export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR='micro'

# LS colors

if [[ ("$TERM" = *256color || "$TERM" = screen* || "$TERM" = xterm* ) && -f /etc/lscolor-256color ]]; then
    eval $(dircolors -b /etc/lscolor-256color)
else
    eval $(dircolors)
fi

# oh-my-zsh path
export ZSH="$HOME/.oh-my-zsh"

# Theme config to OH-MY-ZSH


ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs)
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_IP_BACKGROUND="233"
POWERLEVEL9K_IP_FOREGROUND="15"
POWERLEVEL9K_VCS_STATE_CLEAN="34"
POWERLEVEL9K_VCS_STATE_MODIFIED="190"
POWERLEVEL9K_VCS_STATE_UNTRACKED="3"
DISABLE_AUTO_TITLE="true"

POWERLEVEL9K_DIR_HOME_FOREGROUND="16"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="16"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="16"
POWERLEVEL9K_DIR_ETC_FOREGROUND="16"

if [ "$USERNAME" = "root" ]; then
	POWERLEVEL9K_OS_ICON_BACKGROUND="16"
	POWERLEVEL9K_OS_ICON_FOREGROUND="196"
	POWERLEVEL9K_DIR_HOME_BACKGROUND="240"
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="240"
	POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="240"
	POWERLEVEL9K_DIR_ETC_BACKGROUND="240"
	echo oi
else
	POWERLEVEL9K_OS_ICON_BACKGROUND="233"
	POWERLEVEL9K_OS_ICON_FOREGROUND="15"
	POWERLEVEL9K_DIR_HOME_BACKGROUND="29"
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="29"
	POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="23"
	POWERLEVEL9K_DIR_ETC_BACKGROUND="23"
fi

# Remove "%" after excute bin in terminal

setopt PROMPT_CR  
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# Binding Keys

bindkey  "^[[H" beginning-of-line
bindkey  "^[[F" end-of-line
bindkey  "^Q" kill-buffer

# Alias

alias update="sudo apt update && upgrade_oh_my_zsh > /dev/null"
alias upgrade="sudo apt upgrade"
alias install="sudo apt install"
alias uninstall="sudo apt remove"
alias autoremove="sudo apt autoremove"
alias zshrc_up="git add ~/.zshrc && git commit -m \"$(date +\"%d-%m-%y\")\" && git push"
alias clear="tput reset"
alias g="googler --count 5 "
alias mi="micro"

# User functions

# Waits for changes to the file to run

exe(){
    if [ -z $1 ] || [ ! -f $1 ]; then
        echo "[exe]: invalid files"
        return 0
    fi
    while true; do
        if [ "$last_modif" != "`date -r $1 +%T`" ]; then
            local last_modif=`date -r $1 +%T`
            kill $(jobs -p) 2> /dev/null
            clear
            echo "[exe]: starting $1...";
            if [ "${1##*.}" = "c" ]; then
                gcc $1 -o ${1%.*}
                if [ $? -eq 0 ]; then
                    (./${1%.*} &)
                fi
            elif [ "${1##*.}" = "py" ]; then
                (python3 $1 &)
            elif [ "${1##*.}" = "sh" ]; then
                (./$1 &)
            elif [ "${1##*.}" = "rb" ]; then
                (ruby $1 &)
            elif [ "${1##*.}" = "js" ]; then
                (node $1 &)
            else
                echo "[exe]: unknown file type"
                ./$1
            fi
        fi
        sleep 0.3
    done   
}

# Safe Paste

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Personal Configs

DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="dd/mm/yyyy"

# Plugins

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Import OH-MY-ZSH

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 
