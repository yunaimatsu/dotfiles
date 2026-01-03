ログを読む方法を確認する

                                                                                                                      
  If you're using a modern Linux desktop (like GNOME or KDE), chances are it's already running Wayland by default —   
  unless you or your distro opted to stick with X11 for compatibility reasons.                                        
                                                                                                                      
  Let me know if you want to compare how GNOME or KDE behave under Wayland vs X11!                                    
  meta, super?
  ## 🧠 Modifier Key Mapping on Linux
   Linux Key Symbol  │ Common Name       │ Karabiner Name    │ Key Code          │ Physical Key Example (US layout)   
  ───────────────────┼───────────────────┼───────────────────┼───────────────────┼──────────────────────────────────  
    KEY_LEFTALT      │ Alt (left)        │  "left_option"    │  0x38  (Mac)      │ Left ⌥ Option key                  
    KEY_RIGHTALT     │ Alt (right)       │  "right_option"   │                   │ Right ⌥ Option                     
    KEY_LEFTCTRL     │ Control           │  "left_control"   │  0x3B  (Mac)      │ Left Control key                   
    KEY_RIGHTCTRL    │ Control (right)   │  "right_control"  │                   │ Right Control                      
    KEY_LEFTMETA     │ Super/Meta        │  "left_command"   │  0x37  (Mac)      │ ⌘ Command (left)                   
    KEY_RIGHTMETA    │ Super/Meta        │  "right_command"  │                   │ ⌘ Command (right)                  
  ## 🧩 What's  meta  vs  super ?                                                                                     
  •  Super  is the term used by Linux for the Windows key / Command key.                                              
  •  Meta  is a legacy term from Lisp machines and Emacs — on Linux they're often treated the same as Super.          
  • In X11/Wayland configs:                                                                                           
    •  Super  is bound to the Windows key or Command key.                                                             
    •  Meta  is often mapped to  Alt , but this can be user-configurable.                                             
  ## 🧭 TL;DR for Your Use Case                                                                                       
  If you're mapping ⌘ (Command) from macOS:                                                                           
  • Use  KEY_LEFTMETA  or  KEY_RIGHTMETA  — they are the Linux equivalent.                                            
  If you're mapping ⌥ (Option) from macOS:                                                                            
  • Use  KEY_LEFTALT  or  KEY_RIGHTALT                                                                                
  ## 🧪 How to Confirm Your Modifier Key Codes                                                                        
  Run:                                                                                                                
    sudo evtest                                                                                                       
                                                                                                                      
                                                                                                                      
  and press your modifiers to confirm how they’re seen by your system.                                                
                                                                                                                      
  Or check:                                                                                                           
                                                                                                                      
    bash                                                                                                              
    コピーする編集する                                                                                                
    xmodmap -pke | grep -Ei 'meta|alt|super'                                                                          
                                                                                                                      
                                                                                                                      
  Let me know which keyboard layout you're on (e.g. ANSI HHKB, Apple Magic Keyboard) and I can tell you precisely     
  which Linux key codes map to which modifier names.                                                                  
  history of computer modifier key                                                                                    
  The modifier key—a key that modifies the action of another key—has a rich history dating back to the early days of  
  computing and typewriters. Here's a concise yet deep look into how modifier keys evolved:                           
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


Show window list in Hyprland yunaimatsu/officinae#12
  いつもウィンドウがとっ散らかるから 
  Windowsを参考にウィンドウ一覧を見れるようにする。                                                                   


View this issue on GitHub: https://github.com/yunaimatsu/officinae/issues/12
CREATE: sleep, reboot, poweroff yunaimatsu/officinae#14
Open • yunaimatsu opened about 1 month ago • 0 comments


  bind = $mod SHIFT ALT, s, exec, systemctl suspend                                                                   
  bind = $mod SHIFT ALT, r, exec, systemctl reboot                                                                    
  bind = $mod SHIFT ALT, q, exec, systemctl poweroff                                                                  
UPDATE: Avoid `META+_`KEY CTRL+META+_ yunaimatsu/officinae#16
  <D-[>                                                                                                               
  <D-]>                                                                                                               
  <D-;>                                                                                                               
  <D-´>                                                                                                               
