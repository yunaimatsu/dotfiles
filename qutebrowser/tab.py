def tab(c, config):
    ct = c.colors.tabs
    ct.bar.bg = '#1e1e1e'
    c.colors.webpage.darkmode.enabled = True

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
