# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

if set -q TMUX
    set -e ITERM_PROFILE
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    if string match -q -- 'tmux*' $TERM
        set -g fish_vi_force_cursor 1
    end
end

function fish_greeting
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
end

function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        keychain --eval --quiet | source
        startx -- -keeptty
    end
end

# su fix (not important)
function su
	/bin/su --shell=/usr/bin/fish $argv
end

# nnn cd on quit
function n --wraps nnn --description 'support nnn quit and change directory'
    # Block nesting of nnn in subshells
    if test -n "$NNNLVL"
        if [ (expr $NNNLVL + 0) -ge 1 ]
            echo "nnn is already running"
            return
        end
    end

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "-x" from both lines below,
    # without changing the paths.
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end

# fish_vi_key_bindings
# fish_default_key_bindings
fish_hybrid_key_bindings
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

function extract -a file
    if test -f "$file"
        switch "$file"
            case "*.tar.bz2"
                tar xjf $file
            case "*.tar.gz"
                tar xzf $file
            case "*.bz2"
                bunzip2 $file
            case "*.rar"
                unrar x $file
            case "*.gz"
                gunzip $file
            case "*.tar"
                tar xf $file
            case "*.tbz2"
                tar xjf $file
            case "*.tgz"
                tar xzf $file
            case "*.zip"
                unzip $file
            case "*.Z"
                uncompress $file
            case "*.7z"
                7z x $file
            case "*"
                echo "'$file' cannot be extracted via ex()"
        end
    else
        echo "'$file' is not a valid file"
    end
end

if [ "$TERM" = "xterm-kitty" ]
  alias ssh="kitty +kitten ssh"
end

alias v="nvim"

alias ls="exa"
alias l="exa -lg"
alias ll="exa -lg"
alias la="exa -lag"

alias nb="newsboat"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias dus="du -d 1 -h | sort -h -r"

alias cj="cd (fd --type directory '' $HOME | fzf)"
alias wj="cd (fd --type directory '' $HOME/dev | fzf)"
alias wjv="cd (fd --type directory '' $HOME/dev | fzf) && v ."
alias oj="open (fd --type file '' $HOME | fzf)"
alias vj="v (fd -H -E node_modules -E .git -E .cache -E '*.pyc' --type file '' $HOME | fzf)"
alias fj="cd (sh $HOME/.local/bin/workspace-shell)"

alias s="systemctl"
alias ss="sudo systemctl"

set -Ux TERMINAL kitty

set -Ux MYVIMRC $HOME/.config/nvim/init.lua
set -Ux VISUAL nvim
set -Ux EDITOR nvim
set -Ux NNN_FIFO /tmp/nnn.fifo
set -Ux NNN_PLUG f:preview-tui

set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux WINEPREFIX $XDG_DATA_HOME/wineprefixes/default

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

# valgrind fix (https://bbs.archlinux.org/viewtopic.php?id=276422)
set -Ux DEBUGINFOD_URLS "https://debuginfod.archlinux.org"
