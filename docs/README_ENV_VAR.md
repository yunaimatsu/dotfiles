
# GTK apps (like Gedit, Nautilus, etc.)
export GDK_BACKEND=wayland

# Qt applications (like VLC, qBittorrent, etc.)
export QT_QPA_PLATFORM=wayland

# SDL apps (like some games and emulators)
export SDL_VIDEODRIVER=wayland

# Clutter-based apps
export CLUTTER_BACKEND=wayland

# Firefox
export MOZ_ENABLE_WAYLAND=1

# The system and apps that you're using a Wayland session
export XDG_SESSION_TYPE=wayland

# Chromium and Electron apps (like Chrome, VSCode, Discord)
export OZONE_PLATFORM=wayland
