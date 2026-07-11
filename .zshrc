# Functions
a() { alias "$1"="$2"; }
e() { export "$1"="$2"; }
s() { printf '%*s\n' "$(tput cols)" '' | tr ' ' '-'; }

# Basic command
a n "nvim"
a r "nvim -R"
a cp "cp -i"
a mv "mv -i"
a l "ls -alhi --color=always"

a ss "sudo SYSTEMD_EDITOR=/usr/bin/nvim systemctl"
a pm "sudo pacman"

# Shell configuration
a nr "nvim ~/.zshrc"
a rr "source ~/.zshrc"

# Editor configuration
a nn "nvim ~/.config/nvim/init.lua"
a nnc "nvim ~/.config/nvim/lua/core.lua"
a nnp "nvim ~/.config/nvim/lua/plugins.lua"

# GUI configuration
a nh "nvim ~/.config/hypr/hyprland.lua"
a nw "nvim ~/.config/waybar/config"
a nws "nvim ~/.config/waybar/style.css"
a nm "nvim ~/.config/mako/config" # Mako
a nf "nvim ~/.config/foot/foot.ini" # Foot
a nq "nvim ~/.config/qutebrowser/config.py" # Qutebrowser
a rh "hyprctl reload > /dev/null; pkill waybar; (nohup waybar > /dev/null 2>&1 &); makoctl reload > /dev/null 2>&1"
a rw "pkill waybar; (nohup waybar > /dev/null 2>&1 &)" # Waybar
a rmk "makoctl reload > /dev/null 2>&1" # Mako ("rm" would shadow the file-remove command)
a rf "pkill -x foot; (nohup foot --server > /dev/null 2>&1 &)" # Foot: restarts the server, closes all footclient windows
a rq "(qutebrowser :config-source > /dev/null 2>&1 &)" # Qutebrowser: reload config in the running instance

# Fcitx5 (repo copy is the source of truth)
a nfi "nvim $HOME/dotfiles/fcitx5-profile"
a rfi "fcitx5 -rd > /dev/null 2>&1" # Restart fcitx5 to pick up config
ufi() { # Sync GUI-made profile changes back into the repo and restore the symlink
  local live="$HOME/.config/fcitx5/profile"
  local repo="$HOME/dotfiles/fcitx5-profile"
  if [ -L "$live" ]; then
    echo "profile still symlinked; nothing to sync"
  else
    cp "$live" "$repo" && ln -sfn "$repo" "$live" && echo "profile synced to repo; symlink restored"
  fi
}

# Git configuration
a ng "git config --global --edit"

# Self-host with Docker
penpot() {
  local REPO="$HOME/penpot"
  local COMPOSE="$REPO/docker/devenv/docker-compose.yaml"

  if [[ ! -f "$COMPOSE" ]]; then
    echo "compose file not found: $COMPOSE" >&2
    return 1
  fi

  docker compose -f "$COMPOSE" up -d
}

# Git
a gsc "gh add"
a gsr "gh status"
a gsl "gh status"
a gsu "gh status"
a gsd "gh status"

# GitHub Issue
a gic "gh issue create"
a gir "gh issue view --comments"
a gil "gh issue list --limit 1000"
a giu "gh issue edit"
a gid "gh issue close; gh issue lock"

# GitHub PR
a gpc "gh pr create"
a gpr "s; gh pr view; s; gh pr checks; s; gh pr diff; s;"
a gpl "gh pr list"
a gpu "gh pr checkout; s; gh pr edit"
a gpd "gh pr close; gh issue lock"

# Input method
e GTK_IM_MODULE fcitx # GNOME/GTK apps<D-'>
e QT_IM_MODULE fcitx # KDE/Qt apps
e XMODIFIERS @im=fcitx # X11 apps
e SDL_IM_MODULE fcitx # SDL apps (mainly game apps)
e IMSETTINGS_MODULE fcitx # Fedora Linux
e INPUT_METHOD fcitx # OS default IM

# --- History Settings ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.log/zsh"

setopt allexport
setopt autocd
setopt correct
setopt hist_ignore_dups
setopt hist_append
setopt PROMPT_SUBST
git_prompt() {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  printf 'git:%s' "$branch"
}

PS1='%~ $(git_prompt) '

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
e BUN_INSTALL "$HOME/.bun"
e PATH "$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

e EDITOR "nvim"
e VISUAL "nvim"

e WORKING_DIR "working"
e DOTFILES_DIR "$WORKING_DIR/dotfiles"

if ! pgrep -x "Hyprland" > /dev/null; then
  start-hyprland
fi
eval "$(direnv hook zsh)"

# bun completions
[ -s "/home/yunai/.bun/_bun" ] && source "/home/yunai/.bun/_bun"

# AI
a naic "nvim $HOME/.codex/config.toml"
a naia "nvim $HOME/.claude/config.json"
a naig "nvim $HOME/.gemini/settings.json"

# Claude Code -> local LLM (Ollama speaks the Anthropic API natively)
e ANTHROPIC_BASE_URL "http://localhost:11434"
e ANTHROPIC_AUTH_TOKEN "dummy" # skips the OAuth /login flow
e ANTHROPIC_MODEL "qwen2.5-coder:7b"
e ANTHROPIC_SMALL_FAST_MODEL "qwen2.5-coder:7b"
e DISABLE_AUTOUPDATER 1 # no update checks
e CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1 # belt-and-braces: disables error reporting etc.

