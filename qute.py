config.load_autoconfig(False)

# Palette: black backgrounds everywhere; accents only as dark foregrounds
BLACK  = '#000000'
RED    = '#8b1a1a' # dark red
GREEN  = '#1a6b1a' # dark green
BLUE   = '#2a4a9b' # dark blue
YELLOW = '#8b8b1a' # dark yellow
ORANGE = '#a05a1a' # dark orange
VIOLET = '#6a1a8b' # dark violet

# Tab
ct = c.colors.tabs
ct.bar.bg = '#000000'

ct.even.bg = '#0b0b0b'
ct.odd.bg  = '#101010'
ct.even.fg = '#4a4a4a'
ct.odd.fg  = '#4a4a4a'
ct.selected.even.bg = '#1c1c1c'
ct.selected.odd.bg  = '#1c1c1c'
ct.selected.even.fg = '#eeeeee'
ct.selected.odd.fg  = '#eeeeee'
c.tabs.padding = {'top': 4, 'bottom': 4, 'left': 12, 'right': 12}
c.tabs.indicator.width = 1
c.tabs.favicons.show = 'never'
ti = c.colors.tabs.indicator
ti.start = '#999999'
ti.stop  = '#333333'
ti.error = RED
c.tabs.position = 'top'
c.fonts.default_size = '10pt'
c.fonts.default_family = 'Noto Sans'
c.messages.timeout = 50000

# Statusbar
sb = c.colors.statusbar
sb.insert.bg          = '#000000'
sb.insert.fg          = '#bbbbbb'
sb.normal.bg          = '#000000'
sb.normal.fg          = '#666666'
sb.command.bg         = '#000000'
sb.command.fg         = '#bbbbbb'
sb.url.fg             = '#555555'
sb.url.success.http.fg  = ORANGE
sb.url.success.https.fg = GREEN
sb.url.error.fg       = RED
sb.url.warn.fg        = YELLOW
sb.url.hover.fg       = '#dddddd'

# Statusbar modes (black bg, dark accent fg)
sb.caret.bg           = BLACK
sb.caret.fg           = VIOLET
sb.caret.selection.bg = BLACK
sb.caret.selection.fg = VIOLET
sb.passthrough.bg     = BLACK
sb.passthrough.fg     = BLUE
sb.private.bg         = BLACK
sb.private.fg         = '#888888'
sb.command.private.bg = BLACK
sb.command.private.fg = '#bbbbbb'
sb.progress.bg        = '#444444'

# Messages (defaults are bright red/orange bars)
cme = c.colors.messages
cme.error.bg     = BLACK
cme.error.fg     = RED
cme.error.border = RED
cme.warning.bg     = BLACK
cme.warning.fg     = ORANGE
cme.warning.border = ORANGE
cme.info.bg     = BLACK
cme.info.fg     = '#888888'
cme.info.border = '#333333'

# Downloads (defaults are a blue->green gradient)
cd = c.colors.downloads
cd.bar.bg   = BLACK
cd.start.bg = BLACK
cd.start.fg = BLUE
cd.stop.bg  = BLACK
cd.stop.fg  = GREEN
cd.error.bg = BLACK
cd.error.fg = RED
cd.system.bg = 'none' # no color interpolation between start and stop
cd.system.fg = 'none'

# Prompts (default is a blue box)
cp = c.colors.prompts
cp.bg = BLACK
cp.fg = '#bbbbbb'
cp.border = '1px solid #333333'
cp.selected.bg = '#1e1e1e'
cp.selected.fg = '#ffffff'

# Keyhint popup
ck = c.colors.keyhint
ck.bg = BLACK
ck.fg = '#bbbbbb'
ck.suffix.fg = YELLOW

# Context menu
ccm = c.colors.contextmenu
ccm.menu.bg = BLACK
ccm.menu.fg = '#bbbbbb'
ccm.selected.bg = '#1e1e1e'
ccm.selected.fg = '#ffffff'
ccm.disabled.fg = '#444444'

# Suggestion
cc = c.colors.completion
cc.fg                      = "#bbbbbb"
cc.odd.bg                  = "#080808"
cc.even.bg                 = "#050505"
cc.category.bg             = "#101010"
cc.category.fg             = "#dddddd"
cc.match.fg                = "#ffffff"
cc.item.selected.bg        = "#1e1e1e"
cc.item.selected.fg        = "#ffffff"
cc.item.selected.border.top    = "#1e1e1e"
cc.item.selected.border.bottom = "#1e1e1e"

# Downloads

c.downloads.location.directory = '~/storage/download'
c.downloads.location.prompt = False
c.tabs.show = 'multiple'  # Prevent downloads bar from taking space

def send_mako_notification(filename):
    try:
        filepath = os.path.expanduser(filename)
        message = f"Downloaded: {os.path.basename(filepath)}"
        subprocess.Popen(['makoctl', 'invoke'], 
                         input=message.encode(), 
                         stdout=subprocess.DEVNULL, 
                         stderr=subprocess.DEVNULL)
    except Exception as e:
        print(f"Mako notification failed: {e}")
config.bind('<alt-d>', 'download-clear')

# Language: request US English pages regardless of system locale
c.content.headers.accept_language = 'en-US,en;q=0.9'

c.content.webrtc_ip_handling_policy = "all-interfaces"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.bg = '#000000'

c.qt.args = [
    "--enable-webrtc",
    "--enable-webrtc-remote-event-log",
    "--enable-media-stream",
    "--use-fake-ui-for-media-stream",
    "--use-fake-device-for-media-stream",
    "--enable-usermedia-screen-capturing",
    "--enable-gpu-rasterization",
    "--ignore-gpu-blacklist",
    "--disable-gpu-sandbox",
    "--allow-running-insecure-content",
    "--disable-web-security",
    "--disable-features=VizDisplayCompositor",
    "--enable-features=VaapiVideoDecoder",
    "--autoplay-policy=no-user-gesture-required",
    "--enable-logging=stderr",
    "--v=1",
    "--log-level=0",
    "--vmodule=*media*=3",
]

config.bind('<Ctrl-b>', 'config-cycle tabs.show always never')
config.bind('<Ctrl-g>', 'mode-leave', mode='passthrough')

# Media
cm = c.content.media
cm.audio_capture = True
cm.video_capture = True
cm.audio_video_capture = True
c.content.desktop_capture = True
c.content.notifications.enabled = True
c.content.autoplay = True
c.content.javascript.enabled = True

# Hints
ch = c.colors.hints
ch.fg = "#dddddd"
ch.bg = "#0d0d0d"
ch.match.fg = "#777777"
c.fonts.hints = "bold 10pt Noto Sans, sans-serif"
h = c.hints
h.padding = {'top': 1, 'right': 4, 'bottom': 1, 'left': 4}
h.radius = 3
h.border = "1px solid #2a2a2a"
h.uppercase = True

# Web apps (Gmail, Google Sheets/Docs): insert mode by default, no hints needed
# auto_load doesn't support URL patterns; global is fine since it only fires
# when a page auto-focuses an editable element on load.
c.input.insert_mode.auto_load = True
for pattern in ['*://mail.google.com/*', '*://docs.google.com/*']:
    config.set('input.insert_mode.leave_on_load', False, pattern)

# Bindkey
c.bindings.key_mappings = {"<Ctrl-G>": "<Escape>"}
c.url.start_pages = 'https://perplexity.ai'
c.url.default_page = 'https://perplexity.ai'
c.url.searchengines = {
    'DEFAULT':       'https://google.com/search?q={}',
    'pl': 'https://perplexity.ai?q={}',
    'a':       'https://amazon.co.jp/s?k={}',
    'r':       'https://reddit.com/search/?q={}',
    'c':       'https://chat.openai.com/?q={}',
    'm':       'https://google.com/maps/search/{}',
    'yt':      'https://youtube.com/results?search_query={}',
    'dr':      'https://drive.google.com/drive/search?q={}',
    'tw':      'https://x.com/search?q={}',
    'wt':      'https://en.wiktionary.org/wiki/{}',
    'wk':      'https://en.wikipedia.org/wiki/{}',
    'gh':      'https://github.com/search?q={}',
    'gl':      'https://gitlab.com/search?search={}',
    'sc':      'https://scholar.google.com/scholar?q={}',
    'cl':      'https://claude.ai/new?q={}',
    'aur':     'https://aur.archlinux.org/packages?K={}',
    'rae':     'https://dle.rae.es/{}',
    'ytm':     'https://music.youtube.com/search?q={}',
    'esja':    'https://kotobank.jp/esjaword/{}',
}

# Binding key
def map(key, command):
    config.unbind(key)
    config.bind(key, command)

map('j', 'scroll down')
map('k', 'scroll up')
map('h', 'scroll left')
map('l', 'scroll right')
config.bind('<Meta-j>', 'tab-next')
config.bind('<Meta-k>', 'tab-prev')

for m in ['normal', 'insert', 'caret']:
    config.bind('<Meta-c>', 'fake-key <Ctrl-c>', mode=m) # copy selection natively
    config.bind('<Meta-v>', 'fake-key <Ctrl-v>', mode=m) # paste clipboard natively

def completion(c, config):
    c.colors.completion.fg = "#cfcfcf"  # Text color
    c.colors.completion.odd.bg = "#262626"  # Odd row background
    c.colors.completion.even.bg = "#1a1a1a"  # Even row background
    c.colors.completion.category.bg = "#333347"  # Category header background
    c.colors.completion.category.fg = "#f5c542"  # Category header text
    c.colors.completion.match.fg = "#42f58d"  # Highlight match color
    c.colors.completion.item.selected.bg = "#3c4480"
    c.colors.completion.item.selected.fg = "#ffffff"
    c.colors.completion.item.selected.border.top = "#3c4480"
    c.colors.completion.item.selected.border.bottom = "#3c4480"

def statusbar(c, config):
    c.colors.statusbar.insert.bg = '#FF5733'
    c.colors.statusbar.url.fg = '#ff0000'
    c.colors.statusbar.url.success.http.fg = '#ff0000'
    c.colors.statusbar.url.success.https.fg = '#ff0000'
    c.colors.statusbar.url.error.fg = '#ff0000'
    c.colors.statusbar.url.warn.fg = '#ff0000'
    c.colors.statusbar.url.hover.fg = '#ff0000'
    c.colors.statusbar.command.bg = '#000000'
    c.colors.statusbar.insert.bg = '#FF5733'
    c.colors.statusbar.normal.bg = '#00000000'

def tab(c, config):
    # bg-color of the tab bar 
    config.set('colors.tabs.bar.bg', '#1e1e1e')
    config.set('colors.webpage.darkmode.enabled', True)

    ## Non-selected
    config.set('colors.tabs.even.bg', '#222222')
    config.set('colors.tabs.odd.bg', '#444444')
    config.set('colors.tabs.even.fg', '#aaaaaa')
    config.set('colors.tabs.odd.fg', '#aaaaaa')

    ## Selected
    config.set('colors.tabs.selected.even.bg', '#aaaaaa')
    config.set('colors.tabs.selected.odd.bg', '#aaaaaa')
    config.set('colors.tabs.selected.even.fg', '#111111')
    config.set('colors.tabs.selected.odd.fg', '#111111')

    ## Tab box 
    c.tabs.padding = {'top': 6, 'bottom': 6, 'left': 4, 'right': 4 }
    c.tabs.favicons.show = 'never'
