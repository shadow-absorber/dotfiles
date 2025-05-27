import os
from urllib.request import urlopen

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'mocha', True)

# c.url.start_pages = ""
# c.url.default_page = ""

c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 20

c.url.searchengines = {
# note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }

c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

config.load_autoconfig() # load settings done via the gui

c.auto_save.session = True # save tabs on quit/restart

# dark mode setup
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
#config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# styles, cosmetics
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
# c.window.transparent = True # apparently not needed
c.tabs.width = '7%'

# fonts
c.fonts.default_family = []
c.fonts.default_size = '13pt'
c.fonts.web.family.fixed = 'monospace'
c.fonts.web.family.sans_serif = 'monospace'
c.fonts.web.family.serif = 'monospace'
c.fonts.web.family.standard = 'monospace'

# privacy - adjust these settings based on your preference
# config.set("completion.cmd_history_max_items", 0)
# config.set("content.private_browsing", True)
config.set("content.headers.user_agent", "Mozilla/5.0 (X11; Linux x86_64; rv:138.0) Gecko/20100101 Firefox/138.0")
config.set("content.headers.accept_language", "en-US,en;q=0.5")
#c.content.headers.custom = '{"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}'
c.content.canvas_reading = False
c.content.webgl = False
c.content.geolocation = False
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)
# config.set("content.javascript.enabled", False) # tsh keybind to toggle

# turn on adblocking
c.content.blocking.enabled = True
# set ad blocking to use both methods
c.content.blocking.method = 'both'

# set block lists
c.content.blocking.adblock.lists = [
         "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
         "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]
