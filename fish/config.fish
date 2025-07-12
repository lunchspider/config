if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/home/aman/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /usr/bin/conda
    eval /usr/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# starship config
starship init fish | source

direnv hook fish | source


# opam configuration
source /home/aman/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
