# Environment variables
# Set english locale
set -x  LC_ALL en_US.UTF-8  
set -x LANG en_US.UTF-8  
set -x EDITOR nvim
set -x RSENSE_HOME /Users/dstr/.rbenv/shims/rsense
# set -x PATH $PATH /Users/dstr/.local/bin

# Set up secret environment variables
eval (cat ./config.secret.fish)

eval (hub alias -s)

if not set -q abbrs_initialized
  set -U abbrs_initialized
  
  abbr vim 'nvim'
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
  abbr cde 'cd /Users/dstr/Projects/Skalar/gramo/apps/echo'
  abbr cdf 'cd /Users/dstr/Projects/Skalar/gramo/apps/echo-front'
  abbr cd- 'cd -'
  abbr y 'yarn'
end


function gps
  /Users/dstr/Projects/Skalar/gramo/bin/gps $argv
end


function tmux_func
  if tmux ls | grep -vq attached
    tmux attach
  else
    tmux
  end
end
