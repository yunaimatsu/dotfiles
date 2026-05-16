config.load_autoconfig(False)

# Tab
ct = c.colors.tabs
ct.bar.bg = '#050505'

ct.even.bg = '#0d0d0d'
ct.odd.bg  = '#111111'
ct.even.fg = '#404040'
ct.odd.fg  = '#404040'
ct.selected.even.bg = '#222222'
ct.selected.odd.bg  = '#222222'
ct.selected.even.fg = '#eeeeee'
ct.selected.odd.fg  = '#eeeeee'
c.tabs.padding = {'top': 10, 'bottom': 10, 'left': 5, 'right': 5}
c.tabs.indicator.width = 1
c.tabs.favicons.show = 'never'
ti = c.colors.tabs.indicator
ti.start = '#ffffff'
ti.stop  = '#555555'
ti.error = '#333333'
c.tabs.position = 'bottom'
c.fonts.default_size = '10pt'
c.fonts.default_family = 'Times New Roman'

# Statusbar
sb = c.colors.statusbar
sb.insert.bg          = '#050505'
sb.insert.fg          = '#cccccc'
sb.normal.bg          = '#050505'
sb.normal.fg          = '#777777'
sb.command.bg         = '#050505'
sb.command.fg         = '#cccccc'
sb.url.fg             = '#555555'
sb.url.success.http.fg  = '#888888'
sb.url.success.https.fg = '#aaaaaa'
sb.url.error.fg       = '#333333'
sb.url.warn.fg        = '#666666'
sb.url.hover.fg       = '#dddddd'

# Suggestion
cc = c.colors.completion
cc.fg                      = "#cccccc"
cc.odd.bg                  = "#111111"
cc.even.bg                 = "#0d0d0d"
cc.category.bg             = "#1a1a1a"
cc.category.fg             = "#eeeeee"
cc.match.fg                = "#ffffff"
cc.item.selected.bg        = "#2e2e2e"
cc.item.selected.fg        = "#ffffff"
cc.item.selected.border.top    = "#2e2e2e"
cc.item.selected.border.bottom = "#2e2e2e"

c.content.webrtc_ip_handling_policy = "all-interfaces"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.bg = '#050505'

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
ch.fg = "#eeeeee"
ch.bg = "#1a1a1a"
ch.match.fg = "#888888"
c.fonts.hints = "bold 10pt Times New Roman, serif"
h = c.hints
h.padding = {'top': 1, 'right': 4, 'bottom': 1, 'left': 4}
h.radius = 3
h.border = "1px solid #444444"
h.uppercase = True

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
