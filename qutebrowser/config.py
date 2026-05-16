config.load_autoconfig(False)
from tab import tab
from statusbar import statusbar
from completion import completion
tab(c, config)
statusbar(c, config)
completion(c, config)

c.content.webrtc_ip_handling_policy = "all-interfaces"
c.colors.webpage.darkmode.enabled = False

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
config.bind('<Ctrl-j>', 'tab-next')
config.bind('<Ctrl-k>', 'tab-prev')
