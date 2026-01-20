# bindkey
bindkey -e
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line

# Functions
a() { alias "$1"="$2"; }
e() { export "$1"="$2"; }
s() { printf '%*s\n' "$(tput cols)" '' | tr ' ' '-' }

# Basic command
a n "nvim"
a r "nvim -R"
a cp "cp -i"
a mv "mv -i"
a l "ls -alhi --color=always"
a rrr "rr & mkdir -p $HOME/$WORKING_DIR && cd $HOME/$WORKING_DIR"

# Shell configuration
a nr "nvim ~/.zshrc"
a rr "source ~/.zshrc"

# Editor configuration
a nn "nvim ~/.config/nvim/init.lua"
a nnc "nvim ~/.config/nvim/lua/core.lua"
a nnp "nvim ~/.config/nvim/lua/plugins.lua"

# GUI configuration
a nh "nvim ~/.config/hypr/hyprland.conf" # Hyprland
a nb "nvim ~/.config/waybar/config" # Waybar
a nbs "nvim ~/.config/waybar/style.css" # Waybar
a nm "nvim ~/.config/mako/config" # Mako
a nf "nvim ~/.config/foot/foot.ini" # Foot
a rh "hyprctl reload; pkill waybar; nohup waybar > /dev/null 2>&1 & disown; makoctl reload"

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
