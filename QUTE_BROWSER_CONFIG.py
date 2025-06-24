config.load_autoconfig(False)
# c.colors.tab
# c.colors.statusbar

c.tabs.position = 'left'
c.fonts.default_size = '12pt'
c.url.start_pages = 'https://perplexity.ai'
c.url.default_page = 'https://perplexity.ai'
c.url.searchengines = {
  'DEFAULT': 'https://perplexity.ai?q={}',
  'a': 'https://amazon.co.jp/s?k={}',
  'g': 'https://google.com/search?q={}',
  'r': 'https://reddit.com/search/?q={}',
  'c': 'https://chat.openai.com/?q={}',
  'm': 'https://google.com/maps/search/?query={}',
  'yt': 'https://youtube.com/results?search_query={}',
  'tw': 'https://x.com/search?q={}',
  'wt': 'https://en.wiktionary.org/wiki/{}',
  'wk': 'https://en.wikipedia.org/wiki/{}',
  'gh': 'https://github.com/search?q={}',
  'gl': 'https://gitlab.com/search?search={}',
  'sc': 'https://scholar.google.com/scholar?q={}',
  'gm': 'https://gemini.google.com/app/search?q={}',
  'cl': 'https://claude.ai/new?q={}',
  'aur': 'https://aur.archlinux.org/packages?K={}',
  'rae': 'https://dle.rae.es/{}',
  'per': 'https://perplexity.ai/search?q={}',
  'ytm': 'https://music.youtube.com/search?q={}'
}

def map(key, command):
    config.unbind(key)
    config.bind(key, command)

map('j', 'scroll down')
map('k', 'scroll up')
map('h', 'scroll left')
map('l', 'scroll right')
map('H', 'tab-prev')
map('L', 'tab-next')

config.set('colors.tabs.bar.bg', '#282a36')
config.set('colors.tabs.even.bg', '#44475a')
config.set('colors.tabs.odd.bg', '#282a36')
config.set('colors.tabs.selected.even.bg', '#bd93f9')
config.set('colors.tabs.selected.odd.bg', '#50fa7b')
config.set('colors.tabs.even.fg', '#f8f8f2')
config.set('colors.tabs.odd.fg', '#f8f8f2')
config.set('colors.tabs.selected.even.fg', '#282a36')
config.set('colors.tabs.selected.odd.fg', '#282a36')
config.set('tabs.padding', {'top': 5, 'bottom': 5, 'left': 10, 'right': 10})
