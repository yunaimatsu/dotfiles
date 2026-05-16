config.load_autoconfig(False)

ct = c.colors.tabs
ct.bar.bg = '#1e1e1e'
ct.even.bg = '#222222'
ct.odd.bg  = '#444444'
ct.even.fg = '#aaaaaa'
ct.odd.fg  = '#aaaaaa'
ct.selected.even.bg = '#aaaaaa'
ct.selected.odd.bg  = '#aaaaaa'
ct.selected.even.fg = '#111111'
ct.selected.odd.fg  = '#111111'
c.tabs.padding = {'top': 6, 'bottom': 6, 'left': 4, 'right': 4}
c.tabs.favicons.show = 'never'

sb = c.colors.statusbar
sb.insert.bg          = '#FF5733'
sb.normal.bg          = '#00000000'
sb.command.bg         = '#000000'
sb.url.fg             = '#ff0000'
sb.url.success.http.fg  = '#ff0000'
sb.url.success.https.fg = '#ff0000'
sb.url.error.fg       = '#ff0000'
sb.url.warn.fg        = '#ff0000'
sb.url.hover.fg       = '#ff0000'

cc = c.colors.completion
cc.fg                      = "#cfcfcf"
cc.odd.bg                  = "#262626"
cc.even.bg                 = "#1a1a1a"
cc.category.bg             = "#333347"
cc.category.fg             = "#f5c542"
cc.match.fg                = "#42f58d"
cc.item.selected.bg        = "#3c4480"
cc.item.selected.fg        = "#ffffff"
cc.item.selected.border.top    = "#3c4480"
cc.item.selected.border.bottom = "#3c4480"

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

cm = c.content.media
cm.audio_capture = True
cm.video_capture = True
cm.audio_video_capture = True
c.content.desktop_capture = True
c.content.notifications.enabled = True
c.content.autoplay = True
c.content.javascript.enabled = True

c.tabs.position = 'left'
c.fonts.default_size = '8pt'
c.fonts.default_family = 'JetBrains Mono'

ch = c.colors.hints
ch.fg = "#FFFFFF"
ch.bg = "#1e1e2e"
ch.match.fg = "#f7768e"
c.fonts.hints = "bold 8pt JetBrains Mono, monospace"

h = c.hints
h.padding = {'top': 1, 'right': 4, 'bottom': 1, 'left': 4}
h.radius = 3
h.border = "1px solid #7dcfff"
h.uppercase = True

ti = c.colors.tabs.indicator
ti.start = '#2ECC40'
ti.stop = '#FFDC00'
ti.error = 'red'

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

def map(key, command):
    config.unbind(key)
    config.bind(key, command)

map('j', 'scroll down')
map('k', 'scroll up')
map('h', 'scroll left')
map('l', 'scroll right')
config.bind('<Meta-j>', 'tab-next')
config.bind('<Meta-k>', 'tab-prev')
