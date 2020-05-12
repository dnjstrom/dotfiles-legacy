# Environment variables
# Set english locale
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR nvim
set -x PATH $PATH /Users/daniel/.local/bin
set -x PATH $PATH /Users/daniel/.cargo/bin
set -x PATH $PATH /Users/daniel/go/bin
set -x PATH $PATH /Users/daniel/.cabal/bin

# Set up secret environment variables
source ~/.dotfiles/fish/config.secret.fish

eval (hub alias -s)

# Clear greeting message on startup
set fish_greeting


# function ls
#   command ls $argv | lolcat
# end

if not set -q abbrs_initialized
    set -U abbrs_initialized

    abbr vim 'nvim'
    abbr d 'docker'
    abbr dc 'docker-compose'
    abbr ga 'git add'
    abbr gA 'git add -A :/'
    abbr gc 'git checkout'
    abbr gC 'git commit'
    abbr gAC 'git add -A :/; git commit'
    abbr gf 'git fetch'
    abbr gp 'git pull --rebase'
    abbr gP 'git push'
    abbr gr 'git rebase'
    abbr gs 'git status'
    abbr gd 'git -c color.ui=always status -v -v | less -RX'
    abbr gl 'git log --oneline --graph'
    abbr gb 'git branch'
    abbr geach 'git submodule foreach'
    abbr grekt 'git reset --hard HEAD'
    abbr cd- 'cd -'
    abbr y 'yarn'
    abbr ys 'yarn start'
    abbr yd 'yarn dev'
    abbr yb 'yarn build'
    abbr l 'la'
    abbr c 'code .'
    abbr gitclean 'git checkout master; and git fetch -p; and git pull; and git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d; and git fetch --prune'
end

function tmux_func
    if tmux ls | grep -vq attached
        tmux attach
    else
        tmux
    end
end

function read_confirm
    while true
        read -l -P 'Do you want to continue? [y/N] ' confirm

        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

function push-to-staging
    git fetch
    echo -e "The latest commit to eye-staging was made" (git show --format="%cr" origin/staging | head -n 1)
    echo ""
    echo (git show --format="\"%s\" by %an" origin/staging | head -n 1)
    echo ""

    if read_confirm
        git push -f origin (git rev-parse --abbrev-ref HEAD):staging
    else
        echo "Quitting without pushing"
    end
end


function push-to-eylin
    git fetch
    echo -e "The latest commit to eylin was made" (git show --format="%cr" origin/eylin | head -n 1)
    echo ""
    echo (git show --format="\"%s\" by %an" origin/eylin | head -n 1)
    echo ""

    if read_confirm
        git push -f origin (git rev-parse --abbrev-ref HEAD):eylin
    else
        echo "Quitting without pushing"
    end
end

function push-to-eymon
    git fetch
    echo -e "The latest commit to eymon was made" (git show --format="%cr" origin/eymon | head -n 1)
    echo ""
    echo (git show --format="\"%s\" by %an" origin/eymon | head -n 1)
    echo ""

    if read_confirm
        git push -f origin (git rev-parse --abbrev-ref HEAD):eymon
    else
        echo "Quitting without pushing"
    end
end

function push-to-eyoar
    git fetch
    echo -e "The latest commit to eyoar was made" (git show --format="%cr" origin/eyoar | head -n 1)
    echo ""
    echo (git show --format="\"%s\" by %an" origin/eyoar | head -n 1)
    echo ""

    if read_confirm
        git push -f origin (git rev-parse --abbrev-ref HEAD):eyoar
    else
        echo "Quitting without pushing"
    end
end

starship init fish | source
