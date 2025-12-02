WAYBAR yunaimatsu/officinae#2
Open • yunaimatsu opened about 5 months ago • 2 comments


  Display network condition                                                                                           
  Wifi? Ethernet?                                                                                                     
  Strength of network?                                                                                                
  The name of network?                                                                                                


yunaimatsu (Owner) • Jun 23, 2025

  Display bluetooth devices' battery                                                                                  
  View icon in Waybar                                                                                                 

View the full review: https://github.com/yunaimatsu/officinae/issues/2#issuecomment-3052093083

daX-26-yoshihiro-matsuura • Jun 27, 2025 • Newest comment

  時間                                                                                                                
                                                                                                                      
  Battery                                                                                                             
                                                                                                                      
  Read                                                                                                                
                                                                                                                      
  • 残量                                                                                                              
  • プラグに繋がっているか否か                                                                                        
                                                                                                                      
  ### 容量                                                                                                            
                                                                                                                      
  Read                                                                                                                
                                                                                                                      
  • メモリ                                                                                                            
  • ストレージ                                                                                                        
                                                                                                                      
  スクリーンショット                                                                                                  
  スクリーンレコード                                                                                                  
  Record                                                                                                              
                                                                                                                      
  ### システム                                                                                                        
                                                                                                                      
  ネットワーク                                                                                                        
                                                                                                                      
  • wifi                                                                                                              
  • Bluetooth                                                                                                         

View the full review: https://github.com/yunaimatsu/officinae/issues/2#issuecomment-3052093093


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/2
Understand the process of hyprland yunaimatsu/officinae#4
Open • yunaimatsu opened about 4 months ago • 1 comment


  No description provided


yunaimatsu (Owner) • Jul 14, 2025 • Newest comment

  ログを読む方法を確認する                                                                                            

View the full review: https://github.com/yunaimatsu/officinae/issues/4#issuecomment-3068090386


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/4
Share script to switch background image yunaimatsu/officinae#5
Open • yunaimatsu opened about 4 months ago • 0 comments


                                                                                                                      
    #!/bin/bash                                                                                                       
                                                                                                                      
    # 壁紙ディレクトリ（変更可）                                                                                      
    WALLPAPER_DIR="$HOME/Pictures/wallpapers"                                                                         
    # 出力先                                                                                                          
    OUTPUT_IMG="/tmp/processed_wallpaper.jpg"                                                                         
    # Tokyo Night風カラー（暗青 + 半透明）                                                                            
    TONE_COLOR="#1a1b2690"  # 透明度付き（90 = 約56%）                                                                
                                                                                                                      
    # ランダムに画像を選択                                                                                            
    SELECTED_IMG=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)                  
                                                                                                                      
    # 加工して保存（1920x1080 にリサイズ＋オーバーレイ）                                                              
    convert "$SELECTED_IMG" \                                                                                         
      -resize 1920x1080^ -gravity center -extent 1920x1080 \                                                          
      \( -size 1920x1080 xc:"$TONE_COLOR" \) \                                                                        
      -compose overlay -composite \                                                                                   
      "$OUTPUT_IMG"                                                                                                   
                                                                                                                      
    # Hyprpaper 設定（壁紙を更新）                                                                                    
    hyprctl hyprpaper unload all                                                                                      
    hyprctl hyprpaper preload "$OUTPUT_IMG"                                                                           
    hyprctl hyprpaper wallpaper "eDP-1,$OUTPUT_IMG"                                                                   


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/5
Lock the device 🔐 automatically yunaimatsu/officinae#6
Open • yunaimatsu opened about 4 months ago • 0 comments


  No description provided


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/6
Notes yunaimatsu/officinae#7
Open • yunaimatsu opened about 1 month ago • 0 comments


  diff b/n wayland and x11                                                                                            
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  Wayland and X11 (also known as X or X.Org Server) are both display server protocols used in Linux and other Unix-   
  like                                                                                                                
  systems to manage graphical output and input. Here's a breakdown of the key differences between them  :             
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🖥️ 1. Architecture                                                                                               
                                                                                                                      
  • X11 (X.Org):                                                                                                      
    • Old, complex, and feature-rich.                                                                                 
    • Uses a client-server model where the X server handles input/output, and applications are clients.               
    • Allows network transparency (run apps remotely).                                                                
  • Wayland:                                                                                                          
    • Modern, simpler design.                                                                                         
    • Compositing is built-in; no need for an external compositor like Compiz.                                        
    • No network transparency by default (but possible with tools like Waypipe).                                      
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## ⚙️ 2. Performance & Latency                                                                                      
                                                                                                                      
  • X11:                                                                                                              
    • Higher latency due to legacy architecture and indirect rendering.                                               
    • More overhead, especially with modern GPUs and high-refresh-rate displays.                                      
  • Wayland:                                                                                                          
    • Lower latency and better performance.                                                                           
    • Direct communication between clients and the compositor (e.g., Mutter, KWin, Weston).                           
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🔒 3. Security                                                                                                   
                                                                                                                      
  • X11:                                                                                                              
    • Poor security model — any client can snoop on or inject input into others.                                      
  • Wayland:                                                                                                          
    • Stronger isolation — clients can’t spy on each other by design.                                                 
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🎨 4. Compositing                                                                                                
                                                                                                                      
  • X11:                                                                                                              
    • Optional and external (e.g., via Compton, Compiz).                                                              
    • Can be inconsistent or buggy.                                                                                   
  • Wayland:                                                                                                          
    • Mandatory and integrated.                                                                                       
    • Smoother and more consistent visual effects.                                                                    
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🛠️ 5. Tool & Driver Support                                                                                      
                                                                                                                      
  • X11:                                                                                                              
    • Broad compatibility — works with older and current applications.                                                
    • Still required for some apps (especially legacy ones).                                                          
  • Wayland:                                                                                                          
    • Growing support, but not 100%.                                                                                  
    • May need XWayland (a compatibility layer) to run X11 apps.                                                      
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🔧 6. Configuration                                                                                              
                                                                                                                      
  • X11:                                                                                                              
    • Highly configurable via  xorg.conf ,  xrandr , etc.                                                             
    • Complex but flexible.                                                                                           
  • Wayland:                                                                                                          
    • Less configurable via command line.                                                                             
    • Relies more on DE tools and compositor settings.                                                                
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧠 Summary Table                                                                                                 
                                                                                                                      
   Feature                              │ X11                                 │ Wayland                               
  ──────────────────────────────────────┼─────────────────────────────────────┼─────────────────────────────────────  
   Age                                  │ 1984 (very old)                     │ 2008+ (modern)                        
   Performance                          │ Higher latency                      │ Lower latency                         
   Security                             │ Weak                                │ Stronger isolation                    
   Compositing                          │ External & optional                 │ Built-in & mandatory                  
   App Compatibility                    │ Very high                           │ Improving (XWayland helps)            
   Network Transparency                 │ Built-in                            │ Needs external tools                  
   Customization                        │ More options                        │ Less but simpler                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  If you're using a modern Linux desktop (like GNOME or KDE), chances are it's already running Wayland by default —   
  unless you or your distro opted to stick with X11 for compatibility reasons.                                        
                                                                                                                      
  Let me know if you want to compare how GNOME or KDE behave under Wayland vs X11!                                    
                                                                                                                      
  ### あなた:                                                                                                         
                                                                                                                      
  Is there wayland-version karabiner-element?                                                                         
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  There is currently no native Wayland-compatible version of Karabiner-Elements, because:                             
                                                                                                                      
  • Karabiner-Elements is macOS-only: It’s specifically built for macOS using macOS-specific APIs (like IOKit and HID).
  • It does not run on Linux at all, whether Wayland or X11.                                                          
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧭 Linux Alternatives for Key Remapping on Wayland                                                               
                                                                                                                      
  If you're on Linux and looking for Karabiner-Elements-like functionality under Wayland, here are some options:      
                                                                                                                      
  ### ✅ 1. input-remapper                                                                                            
                                                                                                                      
  • 🔧 GUI tool for remapping keyboard, mouse, and gamepad.                                                           
  • 🖥️ Works under Wayland and X11.                                                                                   
  • 🐧 Supports per-device and per-application profiles.                                                              
  • 📦 Available on GitHub: https://github.com/sezanzeb/input-remapper                                                
                                                                                                                      
  ### ✅ 2. keyd                                                                                                      
                                                                                                                      
  • ⚡ Low-level and lightweight remapping daemon.                                                                    
  • ⚙️ Can handle complex remappings (like hyper keys).                                                               
  • 🛠️ Needs a bit of config via text files.                                                                          
  • 📦 GitHub: https://github.com/rvaiya/keyd                                                                         
  • ⚠️ Requires root permissions and works at the input device level (not Wayland-specific but compatible).           
                                                                                                                      
  ### ✅ 3. interception-tools + caps2esc                                                                             
                                                                                                                      
  • 🔧 For low-level remapping like turning  Caps Lock  into  Esc  or  Ctrl .                                         
  • 🧱 Works well on Wayland because it intercepts input before Wayland even sees it.                                 
                                                                                                                      
  ### ✅ 4. Sway (Wayland compositor) native config                                                                   
                                                                                                                      
  • If using Sway (Wayland version of i3), you can do remapping directly in the config:                               
    bash                                                                                                              
    コピーする編集する                                                                                                
    bindsym Caps_Lock escape                                                                                          
                                                                                                                      
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## ⚠️ Caveats                                                                                                       
                                                                                                                      
  • Under Wayland, key remapping depends heavily on the compositor (GNOME, KDE, Sway, etc.).                          
  • Some remappers (like xmodmap, xcape) don’t work on Wayland — they are X11-only.                                   
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 📝 Summary                                                                                                       
                                                                                                                      
   Tool               │ Wayland Support    │ Complexity         │ GUI                │ Notes                          
  ────────────────────┼────────────────────┼────────────────────┼────────────────────┼──────────────────────────────  
   input-remapper     │ ✅                 │ Easy               │ ✅                 │ Good for most use-cases        
   keyd               │ ✅                 │ Medium             │ ❌                 │ More powerful, needs config    
   interception-tools │ ✅                 │ Medium             │ ❌                 │ Great for modifier remapping   
   Sway config        │ ✅ (Sway only)     │ Easy               │ ❌                 │ Only works in Sway             
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  Let me know your Linux distro and DE/WM (e.g., Fedora + GNOME, Arch + Hyprland, etc.), and I can recommend the best-
  fit solution.                                                                                                       
                                                                                                                      
  ### あなた:                                                                                                         
                                                                                                                      
  I wanna iac like karabiner json                                                                                     
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  If you're looking for an Infrastructure-as-Code (IaC)-style setup for keyboard remapping on Wayland/Linux — similar 
  to                                                                                                                  
  Karabiner-Elements' JSON-based config — the best equivalent experience can be achieved using tools like  keyd  or   
  interception-tools .                                                                                                
                                                                                                                      
  Here’s how you can get a Karabiner-style JSON-based or config-file-based system on Wayland:                         
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## ✅ Option 1: keyd (Best "Karabiner-like" IaC)                                                                    
                                                                                                                      
  URL: https://github.com/rvaiya/keyd                                                                                 
                                                                                                                      
  • Declarative config files ( /etc/keyd/default.conf )                                                               
  • Simple to manage, portable, system-level remapping                                                                
  • Works well on both Wayland and X11                                                                                
                                                                                                                      
  ### 🔧 Example:  Caps Lock  as  Esc  when tapped,  Ctrl  when held (Karabiner classic!)                             
                                                                                                                      
    ini                                                                                                               
    コピーする編集する                                                                                                
    [main]                                                                                                            
    capslock = overload(control, esc)                                                                                 
                                                                                                                      
                                                                                                                      
  ### 🔧 Example:  Cmd + H  →  Alt + Left  (like a Karabiner rule)                                                    
                                                                                                                      
    ini                                                                                                               
    コピーする編集する                                                                                                
    [main]                                                                                                            
    leftmeta+h = leftalt+left                                                                                         
                                                                                                                      
                                                                                                                      
  You can treat the config like IaC: put it in version control, deploy with Ansible, etc.                             
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## ✅ Option 2: interception-tools + dual-function plugin                                                           
                                                                                                                      
  URL: https://gitlab.com/interception/linux/tools                                                                    
                                                                                                                      
  This is lower-level and more powerful, but requires:                                                                
                                                                                                                      
  •  udevmon  rules                                                                                                   
  • YAML or TOML-style config via plugins like  caps2esc                                                              
                                                                                                                      
  Good for strict IaC setups, but more complex to set up.                                                             
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## ✅ Option 3: input-remapper                                                                                      
                                                                                                                      
  URL: https://github.com/sezanzeb/input-remapper                                                                     
                                                                                                                      
  • GUI + CLI                                                                                                         
  • Saves per-device configs as JSON-like files in  ~/.config/input-remapper-2/                                       
  • You can version-control the config, although it’s less structured than Karabiner.                                 
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🛠️ You can build a Karabiner-style config pipeline like this:                                                    
                                                                                                                      
  ### Folder structure example:                                                                                       
                                                                                                                      
    pgsql                                                                                                             
    コピーする編集する                                                                                                
    keymap-config/                                                                                                    
    ├── keyd/                                                                                                         
    │   └── default.conf                                                                                              
    ├── interception/                                                                                                 
    │   └── udevmon.yaml                                                                                              
    ├── input-remapper/                                                                                               
    │   └── some-device.json                                                                                          
                                                                                                                      
                                                                                                                      
  Then you could write a shell script or Ansible role to:                                                             
                                                                                                                      
  • Copy the config into place                                                                                        
  • Restart the appropriate daemons ( systemctl restart keyd , etc.)                                                  
  • Check syntax / validation                                                                                         
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧠 Summary                                                                                                       
                                                                                                                      
   Tool                 │ Declarative Config   │ JSON-like            │ Wayland Support      │ Karabiner-Like         
  ──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────┼──────────────────────  
    keyd                │ ✅ ( *.conf )        │ ❌ (INI)             │ ✅                   │ ✅                     
    interception-tools  │ ✅ ( *.yaml )        │ ❌ (YAML)            │ ✅                   │ ✅ (powerful)          
    input-remapper      │ ✅ ( *.json )        │ ✅                   │ ✅                   │ ✅ (basic)             
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  If you want, I can help convert your existing Karabiner JSON into a  keyd  or  interception-tools  config — just    
  paste your config snippet.                                                                                          
                                                                                                                      
  ### あなた:                                                                                                         
                                                                                                                      
  Which is the most customizable?                                                                                     
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  If you're looking for maximum customizability (Karabiner-level power), here’s a ranked breakdown of the most        
  powerful                                                                                                            
  keyboard remapping tools on Wayland/Linux:                                                                          
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🥇 1. interception-tools + plugins (most customizable)                                                           
                                                                                                                      
  • 🔥 Most low-level and flexible — operates between the kernel and the user session.                                
  • ✅ Full support for complex combos: tap vs hold, sequences, layers, multiple modifiers, device-specific rules.    
  • 📦 Plugin ecosystem (e.g.,  dual-function-keys ,  caps2esc , custom C plugins).                                   
  • 🧰 Configurable via YAML or TOML (depending on the plugin).                                                       
  • ⚠️ Needs root access and udev rules. Complex to set up.                                                           
                                                                                                                      
  ### ✅ Pros                                                                                                         
                                                                                                                      
  • Near-Karabiner-level control (especially with dual-function plugin)                                               
  • Works across all desktop environments and compositors                                                             
  • Predictable and portable — great for IaC-style configs                                                            
                                                                                                                      
  ### ⚠️ Cons                                                                                                         
                                                                                                                      
  • Steep learning curve                                                                                              
  • Requires kernel-level configuration and care                                                                      
  • Debugging can be tricky                                                                                           
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🥈 keyd (powerful + easier config)                                                                               
                                                                                                                      
  • 📜 Uses simple  INI style config files.                                                                           
  • 💡 Supports: layers, overloads (tap vs hold), multi-key remapping, application-specific rules (via  keyd-         
  application-mapper ).                                                                                               
  • 🧪 Works at device level — bypasses Wayland/X11 restrictions.                                                     
                                                                                                                      
  ### ✅ Pros                                                                                                         
                                                                                                                      
  • Easier syntax than  interception-tools                                                                            
  • Very fast and reliable                                                                                            
  • Great for automation / config management                                                                          
                                                                                                                      
  ### ⚠️ Cons                                                                                                         
                                                                                                                      
  • Slightly less customizable than  interception-tools  if you need extremely advanced behavior (like chord sequences,
  sticky keys, or tap dances)                                                                                         
  • Needs root access for installation and remapping                                                                  
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🥉 input-remapper (GUI + decent flexibility)                                                                     
                                                                                                                      
  • 📋 JSON-based per-device configs                                                                                  
  • 🖥️ Has a GUI for easy setup                                                                                       
  • 🎮 Works with keyboards, mice, gamepads                                                                           
                                                                                                                      
  ### ✅ Pros                                                                                                         
                                                                                                                      
  • Easy to use, quick to start                                                                                       
  • Good for per-device customization                                                                                 
  • Remaps mouse + gamepad too                                                                                        
                                                                                                                      
  ### ⚠️ Cons                                                                                                         
                                                                                                                      
  • Limited tap-hold logic (not designed for advanced modifier combos)                                                
  • Doesn’t support full key-layering or application-specific logic                                                   
  • Harder to script or manage as IaC                                                                                 
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧠 TL;DR – Best for Customization?                                                                               
                                                                                                                      
   Feature/Tool               │ interception-tools 🥇      │ keyd 🥈                    │ input-remapper 🥉           
  ────────────────────────────┼────────────────────────────┼────────────────────────────┼───────────────────────────  
   Tap vs Hold                │ ✅ Full control            │ ✅ Built-in                │ ⚠️ Basic only               
   Multi-layer mapping        │ ✅ Full                    │ ✅ Partial (via mapping)   │ ❌                          
   Chords / Combos            │ ✅ With plugin/custom C    │ ⚠️ Limited                 │ ❌                          
   Device-specific config     │ ✅ Yes                     │ ✅ Yes                     │ ✅ Yes                      
   App-specific remapping     │ ✅ (via plugin)            │ ⚠️ Needs helper tool       │ ❌                          
   IaC-friendliness           │ ✅ YAML-based              │ ✅ INI-based               │ ⚠️ JSON but GUI-generated   
   Wayland support            │ ✅ Native                  │ ✅ Native                  │ ✅ Native                   
   Ease of use                │ ❌ Complex                 │ ✅ Moderate                │ ✅ Easy                     
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 👉 Recommendation                                                                                                
                                                                                                                      
  • Want maximum power and don’t mind complexity? →  interception-tools                                               
  • Want power + sane defaults + IaC-ready? →  keyd                                                                   
  • Want easy GUI remapping? →  input-remapper                                                                        
                                                                                                                      
  Let me know what exact remaps or layers you want to build, and I can recommend the best tool + provide an example   
  config.                                                                                                             
                                                                                                                      
  ### あなた:                                                                                                         
                                                                                                                      
  translate the following karabiner.json into interception-tools.                                                     
                                                                                                                      
   {                                                                                                                  
  "description": "Custom keybindings: Emacs-style movement and Alt+keys to numbers",                                  
  "manipulators": [                                                                                                   
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "f",                                                                                                    
  "modifiers": { "mandatory": ["control"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "right_arrow" }],                                                                              
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "b",                                                                                                    
  "modifiers": { "mandatory": ["control"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "left_arrow" }],                                                                               
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "n",                                                                                                    
  "modifiers": { "mandatory": ["control"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "down_arrow" }],                                                                               
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "p",                                                                                                    
  "modifiers": { "mandatory": ["control"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "up_arrow" }],                                                                                 
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "h",                                                                                                    
  "modifiers": { "mandatory": ["control"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "delete_or_backspace" }],                                                                      
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "d",                                                                                                    
  "modifiers": { "mandatory": ["control"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "delete_forward" }],                                                                           
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "spacebar",                                                                                             
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "0" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "m",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "1" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "comma",                                                                                                
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "2" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "period",                                                                                               
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "3" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "j",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "4" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "k",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "5" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "l",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "6" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "u",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "7" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "i",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "8" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "o",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "9" }],                                                                                        
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "p",                                                                                                    
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "equal_sign" }],                                                                               
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "semicolon",                                                                                            
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "keypad_plus" }],                                                                              
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "slash",                                                                                                
  "modifiers": { "mandatory": ["option"] }                                                                            
  },                                                                                                                  
  "to": [{ "key_code": "keypad_hyphen" }],                                                                            
  "type": "basic"                                                                                                     
  },                                                                                                                  
  {                                                                                                                   
  "from": {                                                                                                           
  "key_code": "period",                                                                                               
  "modifiers": { "mandatory": ["command"] }                                                                           
  },                                                                                                                  
  "to": [{ "key_code": "escape" }],                                                                                   
  "type": "basic"                                                                                                     
  }                                                                                                                   
  ]                                                                                                                   
  }                                                                                                                   
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  Here’s a translation of your  karabiner.json  config into an  interception-tools  YAML config, using the            
  interception-caps2esc  plugin and a generic udevmon setup.                                                          
                                                                                                                      
  This example assumes you're using the  dual-function-keys  or similar plugin to handle remaps.                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ### 🗂️  udevmon.yaml                                                                                                
                                                                                                                      
    yaml                                                                                                              
    コピーする編集する                                                                                                
    - JOB: "intercept -g $DEVNODE | dual-function-keys -c /etc/interception/karabiner_like.yaml | uinput -d $DEVNODE" 
      DEVICE:                                                                                                         
        EVENTS:                                                                                                       
          EV_KEY: [KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G, KEY_H, KEY_I, KEY_J, KEY_K, KEY_L, KEY_M, KEY_N,  
  KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T, KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z, KEY_SPACE, KEY_COMMA, KEY_DOT,  
  KEY_SLASH, KEY_SEMICOLON]                                                                                           
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ### 🗂️  /etc/interception/karabiner_like.yaml                                                                       
                                                                                                                      
    yaml                                                                                                              
    コピーする編集する                                                                                                
    MAPPINGS:                                                                                                         
      - KEY: KEY_F                                                                                                    
        MODIFIERS: [KEY_LEFTCTRL]                                                                                     
        TAP: KEY_RIGHT                                                                                                
                                                                                                                      
      - KEY: KEY_B                                                                                                    
        MODIFIERS: [KEY_LEFTCTRL]                                                                                     
        TAP: KEY_LEFT                                                                                                 
                                                                                                                      
      - KEY: KEY_N                                                                                                    
        MODIFIERS: [KEY_LEFTCTRL]                                                                                     
        TAP: KEY_DOWN                                                                                                 
                                                                                                                      
      - KEY: KEY_P                                                                                                    
        MODIFIERS: [KEY_LEFTCTRL]                                                                                     
        TAP: KEY_UP                                                                                                   
                                                                                                                      
      - KEY: KEY_H                                                                                                    
        MODIFIERS: [KEY_LEFTCTRL]                                                                                     
        TAP: KEY_BACKSPACE                                                                                            
                                                                                                                      
      - KEY: KEY_D                                                                                                    
        MODIFIERS: [KEY_LEFTCTRL]                                                                                     
        TAP: KEY_DELETE                                                                                               
                                                                                                                      
      - KEY: KEY_SPACE                                                                                                
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_0                                                                                                    
                                                                                                                      
      - KEY: KEY_M                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_1                                                                                                    
                                                                                                                      
      - KEY: KEY_COMMA                                                                                                
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_2                                                                                                    
                                                                                                                      
      - KEY: KEY_DOT                                                                                                  
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_3                                                                                                    
                                                                                                                      
      - KEY: KEY_J                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_4                                                                                                    
                                                                                                                      
      - KEY: KEY_K                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_5                                                                                                    
                                                                                                                      
      - KEY: KEY_L                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_6                                                                                                    
                                                                                                                      
      - KEY: KEY_U                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_7                                                                                                    
                                                                                                                      
      - KEY: KEY_I                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_8                                                                                                    
                                                                                                                      
      - KEY: KEY_O                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_9                                                                                                    
                                                                                                                      
      - KEY: KEY_P                                                                                                    
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_EQUAL                                                                                                
                                                                                                                      
      - KEY: KEY_SEMICOLON                                                                                            
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_KPPLUS                                                                                               
                                                                                                                      
      - KEY: KEY_SLASH                                                                                                
        MODIFIERS: [KEY_LEFTALT]                                                                                      
        TAP: KEY_KPMINUS                                                                                              
                                                                                                                      
      - KEY: KEY_DOT                                                                                                  
        MODIFIERS: [KEY_LEFTMETA]                                                                                     
        TAP: KEY_ESC                                                                                                  
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ### 🧠 Notes                                                                                                        
                                                                                                                      
  • Replace  KEY_LEFTCTRL ,  KEY_LEFTALT , and  KEY_LEFTMETA  based on your actual modifier keys.                     
  • The  dual-function-keys  plugin may require a specific version or syntax; some remappers use  KEY_LEFTMETA  while 
  others require hex keycodes or key names.                                                                           
  • The plugin will need to be installed and listed in your system’s  $PATH .                                         
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  Would you like a version that installs everything (udevmon, plugin, config) as an Ansible role or script?           
                                                                                                                      
  ### あなた:                                                                                                         
                                                                                                                      
  meta, super?                                                                                                        
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  Great question. Here's the clarification:                                                                           
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧠 Modifier Key Mapping on Linux                                                                                 
                                                                                                                      
   Linux Key Symbol  │ Common Name       │ Karabiner Name    │ Key Code          │ Physical Key Example (US layout)   
  ───────────────────┼───────────────────┼───────────────────┼───────────────────┼──────────────────────────────────  
    KEY_LEFTALT      │ Alt (left)        │  "left_option"    │  0x38  (Mac)      │ Left ⌥ Option key                  
    KEY_RIGHTALT     │ Alt (right)       │  "right_option"   │                   │ Right ⌥ Option                     
    KEY_LEFTCTRL     │ Control           │  "left_control"   │  0x3B  (Mac)      │ Left Control key                   
    KEY_RIGHTCTRL    │ Control (right)   │  "right_control"  │                   │ Right Control                      
    KEY_LEFTMETA     │ Super/Meta        │  "left_command"   │  0x37  (Mac)      │ ⌘ Command (left)                   
    KEY_RIGHTMETA    │ Super/Meta        │  "right_command"  │                   │ ⌘ Command (right)                  
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧩 What's  meta  vs  super ?                                                                                     
                                                                                                                      
  •  Super  is the term used by Linux for the Windows key / Command key.                                              
  •  Meta  is a legacy term from Lisp machines and Emacs — on Linux they're often treated the same as Super.          
  • In X11/Wayland configs:                                                                                           
    •  Super  is bound to the Windows key or Command key.                                                             
    •  Meta  is often mapped to  Alt , but this can be user-configurable.                                             
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧭 TL;DR for Your Use Case                                                                                       
                                                                                                                      
  If you're mapping ⌘ (Command) from macOS:                                                                           
                                                                                                                      
  • Use  KEY_LEFTMETA  or  KEY_RIGHTMETA  — they are the Linux equivalent.                                            
                                                                                                                      
  If you're mapping ⌥ (Option) from macOS:                                                                            
                                                                                                                      
  • Use  KEY_LEFTALT  or  KEY_RIGHTALT                                                                                
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧪 How to Confirm Your Modifier Key Codes                                                                        
                                                                                                                      
  Run:                                                                                                                
                                                                                                                      
    bash                                                                                                              
    コピーする編集する                                                                                                
    sudo evtest                                                                                                       
                                                                                                                      
                                                                                                                      
  and press your modifiers to confirm how they’re seen by your system.                                                
                                                                                                                      
  Or check:                                                                                                           
                                                                                                                      
    bash                                                                                                              
    コピーする編集する                                                                                                
    xmodmap -pke | grep -Ei 'meta|alt|super'                                                                          
                                                                                                                      
                                                                                                                      
  Let me know which keyboard layout you're on (e.g. ANSI HHKB, Apple Magic Keyboard) and I can tell you precisely     
  which Linux key codes map to which modifier names.                                                                  
                                                                                                                      
  ### あなた:                                                                                                         
                                                                                                                      
  history of computer modifier key                                                                                    
                                                                                                                      
  ### ChatGPT:                                                                                                        
                                                                                                                      
  The modifier key—a key that modifies the action of another key—has a rich history dating back to the early days of  
  computing and typewriters. Here's a concise yet deep look into how modifier keys evolved:                           
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## ⌨️ 1. Pre-Computer Origins: The Shift Key                                                                        
                                                                                                                      
  • 1878: Remington No. 2 typewriter introduces the Shift key to toggle between lowercase and uppercase letters using 
  a shifted typebar mechanism.                                                                                        
  • Purpose: Literal mechanical shift of letter arms — hence the name.                                                
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🖥️ 2. Early Computer Terminals (1960s–1970s)                                                                     
                                                                                                                      
  ### 🗝️ Control (Ctrl)                                                                                               
                                                                                                                      
  • Origin: Teletype machines (TTY).                                                                                  
  • Used to send control characters (e.g.  Ctrl+C  = interrupt,  Ctrl+G  = bell).                                     
  • Dropped 2 high bits of ASCII to generate codes (e.g.,  A  = 65 →  Ctrl+A  = 1).                                   
                                                                                                                      
  ### 🧠 Meta                                                                                                         
                                                                                                                      
  • Introduced on Lisp Machines at MIT in the 1970s.                                                                  
  • Preceded Alt and Super.                                                                                           
  • Originally set the 8th bit of the character:  Meta-A  =  0x81  (instead of  0x41  for  A ).                       
  • Used in Emacs and MIT environments.                                                                               
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🪟 3. Alt and Super (1980s–1990s)                                                                                
                                                                                                                      
  ### 🧭 Alt (Alternate)                                                                                              
                                                                                                                      
  • Introduced by IBM on the PC/AT keyboard (1984).                                                                   
  • Used to access alternative functions (like menu navigation).                                                      
  • Became essential in GUI operating systems (e.g.,  Alt+Tab ,  Alt+F4  in Windows).                                 
                                                                                                                      
  ### 🪟 Super                                                                                                        
                                                                                                                      
  • Originated from Sun Microsystems keyboards and Symbolics Lisp Machines.                                           
  • Assigned to what is now the Windows key.                                                                          
  • Linux later adopted it as the "Super" key to avoid calling it "Windows".                                          
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🍏 4. Apple Enters (1980s–2000s)                                                                                 
                                                                                                                      
   Key                                  │ Introduced                          │ Purpose                               
  ──────────────────────────────────────┼─────────────────────────────────────┼─────────────────────────────────────  
   Command (⌘)                          │ 1984                                │ Mac-only key for OS commands          
   Option (⌥)                           │ 1984                                │ Acts like Alt + symbol entry          
   Control (^)                          │ 1984                                │ Used more for text nav (Unix-style)   
                                                                                                                      
  • Command replaced Control for most shortcuts to avoid conflicting with Unix terminal behavior.                     
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧩 5. Modern Modifiers (2000s–Today)                                                                             
                                                                                                                      
   Name                      │ OS/Platform               │ Keycap Symbols           │ Common Use                      
  ───────────────────────────┼───────────────────────────┼──────────────────────────┼───────────────────────────────  
   Shift                     │ All                       │ ⇧                        │ Capitalize / modify input       
   Ctrl                      │ Unix, Windows             │ ^                        │ Terminal, OS shortcuts          
   Alt                       │ Windows/Linux             │ ⎇                        │ Menus, modifiers                
   Meta                      │ Emacs, Lisp legacy        │ (no standard symbol)     │ Still active in some contexts   
   Super                     │ Linux                     │ ⊞ / ⌘ / 🪟               │ Window manager shortcuts        
   Command                   │ macOS                     │ ⌘                        │ Primary shortcut key on macOS   
   Option                    │ macOS                     │ ⌥                        │ Alternative input / modifier    
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🔁 Timeline Summary                                                                                              
                                                                                                                      
    makefile                                                                                                          
    コピーする編集する                                                                                                
    1878: Shift (Remington No. 2)                                                                                     
    1960s: Control (Teletype)                                                                                         
    1970s: Meta (Lisp Machines)                                                                                       
    1984: Alt (IBM PC/AT), Command & Option (Mac)                                                                     
    1990s: Super (Sun/Windows)                                                                                        
    Today: Mix of all, standardized in OS-specific ways                                                               
                                                                                                                      
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  ## 🧠 Legacy Lives On                                                                                               
                                                                                                                      
  • Emacs and X11 still support Meta, Super, Hyper.                                                                   
  • Modern Linux users often remap keys like Caps Lock to Ctrl, or Space to Meta/Super using tools like Karabiner,    
  interception-tools, or xmodmap.                                                                                     
  • Modifier keys are still essential in accessibility, productivity tools, and game input systems.                   
                                                                                                                      
  --------                                                                                                            
                                                                                                                      
  Let me know if you want:                                                                                            
                                                                                                                      
  • A visual chart of key placements across keyboards (Mac vs PC vs HHKB)                                             
  • A breakdown of modifier usage in terminal vs GUI                                                                  
  • A specific historical dig on the Emacs key ecosystem (Meta, Ctrl, Hyper)                                          
                                                                                                                      
  This config handles all the key translations from your Karabiner setup.                                             


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/7
Organize the requirements yunaimatsu/officinae#8
Open • yunaimatsu opened about 1 month ago • 0 comments


  ### Battery                                                                                                         
                                                                                                                      
  Read                                                                                                                
                                                                                                                      
  • 残量                                                                                                              
  • プラグに繋がっているか否か                                                                                        
                                                                                                                      
  ### 容量                                                                                                            
                                                                                                                      
  Read                                                                                                                
                                                                                                                      
  • メモリ                                                                                                            
  • ストレージ                                                                                                        
                                                                                                                      
  ###                                                                                                                 
                                                                                                                      
  スクリーンショット                                                                                                  
  スクリーンレコード                                                                                                  
  Record                                                                                                              
                                                                                                                      
  ### システム                                                                                                        
                                                                                                                      
  ネットワーク                                                                                                        
                                                                                                                      
  • wifi                                                                                                              
  • Bluetooth                                                                                                         
                                                                                                                      
  ショートカットキーリスト                                                                                            
                                                                                                                      
  ### 入力                                                                                                            
                                                                                                                      
  • 言語変更                                                                                                          
                                                                                                                      
  ### 出力                                                                                                            
                                                                                                                      
  • Volume                                                                                                            
  • Brightness                                                                                                        


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/8
Keybaord remapping yunaimatsu/officinae#9
Open • yunaimatsu opened about 1 month ago • 0 comments


  ## Windows                                                                                                          
                                                                                                                      
  #Requires AutoHotkey v2.0                                                                                           
                                                                                                                      
  #HotIf true                                                                                                         
  #a::Send("{RCtrl down}a{RCtrl up}")                                                                                 
  #b::Send("{RCtrl down}b{RCtrl up}")                                                                                 
  #c::Send("{RCtrl down}c{RCtrl up}")                                                                                 
  #d::Send("{RCtrl down}d{RCtrl up}")                                                                                 
  #e::Send("{RCtrl down}e{RCtrl up}")                                                                                 
  #f::Send("{RCtrl down}f{RCtrl up}")                                                                                 
  #g::Send("{RCtrl down}g{RCtrl up}")                                                                                 
  #h::Send("{RCtrl down}h{RCtrl up}")                                                                                 
  #i::Send("{RCtrl down}i{RCtrl up}")                                                                                 
  #j::Send("{RCtrl down}j{RCtrl up}")                                                                                 
  #k::Send("{RCtrl down}k{RCtrl up}")                                                                                 
  #L::Return  ; #L cannot be overridden in Windows                                                                    
  #m::Send("{RCtrl down}m{RCtrl up}")                                                                                 
  #n::Send("{RCtrl down}n{RCtrl up}")                                                                                 
  #o::Send("{RCtrl down}o{RCtrl up}")                                                                                 
  #p::Send("{RCtrl down}p{RCtrl up}")                                                                                 
  #q::Send("{RCtrl down}q{RCtrl up}")                                                                                 
  #r::Send("{RCtrl down}r{RCtrl up}")                                                                                 
  #s::Send("{RCtrl down}s{RCtrl up}")                                                                                 
  #t::Send("{RCtrl down}t{RCtrl up}")                                                                                 
  #u::Send("{RCtrl down}u{RCtrl up}")                                                                                 
  #v::Send("{RCtrl down}v{RCtrl up}")                                                                                 
  #w::Send("{RCtrl down}w{RCtrl up}")                                                                                 
  #x::Send("{RCtrl down}x{RCtrl up}")                                                                                 
  #y::Send("{RCtrl down}y{RCtrl up}")                                                                                 
  #z::Send("{RCtrl down}z{RCtrl up}")                                                                                 
                                                                                                                      
  <!m::Send("1")                                                                                                      
  <!,::Send("2")                                                                                                      
  <!.::Send("3")                                                                                                      
  <!j::Send("4")                                                                                                      
  <!k::Send("5")                                                                                                      
  <!l::Send("6")                                                                                                      
  <!u::Send("7")                                                                                                      
  <!i::Send("8")                                                                                                      
  <!o::Send("9")                                                                                                      


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/9
Keyd yunaimatsu/officinae#10
Open • yunaimatsu opened about 1 month ago • 1 comment


  Windows are manged and manipulated with  Super  key.                                                                
                                                                                                                      
  • Alt                                                                                                               
  qwerty u(7) i(8) o(9) p(=) (left_bracket)  /right_bracket                                                           
  asdfgh j(4) k(5) l(6) ;(+) ' Enter                                                                                  
  zxcvbn m(1) ,(2) .(3) /                                                                                             
  • Super                                                                                                             
  qwer -- ty -- u(WIN7) i(WIN8) o(WIN9) p(=) []                                                                       
  a(@)s(%)d(#)f(*) -- gh -- j(WIN4) k(WIN5) l(WIN6) ;(+) '() Enter( $TERMINAL )                                       
  zxcv -- b( $BROWSER )n -- m(WIN1) ,(WIN2) .(WIN3) /                                                                 
  • Super+Shift                                                                                                       
  qwerty u(go to WIN7) i(go to WIN8) o(go to WIN9) p(=) []                                                            
  asdfgh j(go to WIN4) k(go to WIN5) l(go to WIN6) ;(+) 'Enter                                                        
  zxcvbn m(go to WIN1) ,(go to WIN2) .(go to WIN3) /                                                                  
                                                                                                                      
  Markdown                                                                                                            
                                                                                                                      
  Regex                                                                                                               
  ^ & *                                                                                                               
  Chat tool                                                                                                           
  @                                                                                                                   
  !¡?¿                                                                                                                
  /|\                                                                                                                 
  _                                                                                                                   
  @ # $ % ^ & *                                                                                                       
                                                                                                                      
  結論: 演算で分けるのはやめる                                                                                        
  理由: こんなハード寄りなプログラム書くことは、マークダウンや正規表現、メンションよりも圧倒的に少ない。              
                                                                                                                      
    +                                                                                                                 
    -                                                                                                                 
    *                                                                                                                 
    /                                                                                                                 
    ^                                                                                                                 
    %                                                                                                                 


yunaimatsu (Owner) • Oct 24, 2025 • Newest comment

  基本は社内<acに合わせる。                                                                                           

View the full review: https://github.com/yunaimatsu/officinae/issues/10#issuecomment-3444307666


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/10
UPDATE: Use relative units in Waybar style CSS yunaimatsu/officinae#11
Open • yunaimatsu opened about 1 month ago • 0 comments


  waybarだけじゃなくて、hyprlandのウィンドウマネージャも。                                                            


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/11
UPDATE: Show window list in Hyprland yunaimatsu/officinae#12
Open • yunaimatsu opened about 1 month ago • 0 comments


  いつもウィンドウがとっ散らかるから、                                                                                
  Windowsを参考にウィンドウ一覧を見れるようにする。                                                                   


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/12
CREATE: sleep, reboot, poweroff yunaimatsu/officinae#14
Open • yunaimatsu opened about 1 month ago • 0 comments


  bind = $mod SHIFT ALT, s, exec, systemctl suspend                                                                   
  bind = $mod SHIFT ALT, r, exec, systemctl reboot                                                                    
  bind = $mod SHIFT ALT, q, exec, systemctl poweroff                                                                  


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/14
UPDATE: Organize the order by which each program/tool is executed yunaimatsu/officinae#15
Open • yunaimatsu opened about 1 month ago • 0 comments


  Por ejemplo, cuál applicación se executará cuando se abre la terminaz?                                              


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/15
UPDATE: Avoid `META+_`KEY CTRL+META+_ yunaimatsu/officinae#16
Open • yunaimatsu opened about 1 month ago • 0 comments


                                                                                                                      
  <D-[>                                                                                                               
  <D-]>                                                                                                               
                                                                                                                      
  
                                                                                                                      
  <D-;>                                                                                                               
  <D-´>                                                                                                               
                                                                                                                      
                                                                                                                      


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/16
CREATE: Integrate `musea` `theatra` `musicae` `incantationes` yunaimatsu/officinae#17
Open • yunaimatsu opened about 15 days ago • 0 comments
Assignees: yunaimatsu


  No description provided


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/17
UPDATE: Merge previous officinae README yunaimatsu/officinae#18
Open • yunaimatsu opened about 14 days ago • 1 comment


  No description provided


github-actions • 14d • Newest comment

  @yunaimatsu                                                                                                         
  [NEW TASK] UPDATE: Merge previous officinae README                                                                  

View the full review: https://github.com/yunaimatsu/officinae/issues/18#issuecomment-3543558174


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/18
CREATE: Void, Gentoo yunaimatsu/officinae#19
Open • yunaimatsu opened about 12 days ago • 1 comment


  No description provided


github-actions • 12d • Newest comment

  @yunaimatsu                                                                                                         
  [NEW TASK] CREATE: Void, Gentoo                                                                                     

View the full review: https://github.com/yunaimatsu/officinae/issues/19#issuecomment-3555855445


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/19
CREATE: Understand `systemd` yunaimatsu/officinae#20
Open • yunaimatsu opened about 12 days ago • 1 comment


  No description provided


github-actions • 12d • Newest comment

  @yunaimatsu                                                                                                         
  [NEW TASK] CREATE: Understand  systemd                                                                              

View the full review: https://github.com/yunaimatsu/officinae/issues/20#issuecomment-3555856352


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/20
