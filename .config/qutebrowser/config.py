config.load_autoconfig(False)
 
c.downloads.location.suggestion = 'path'
c.downloads.location.directory = '~/Downloads/'

c.colors.webpage.preferred_color_scheme = 'dark'

c.url.default_page = "https://google.com/"
c.url.start_pages = ["https://www.google.com/"]
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!c':       'https://claude.ai/new?q={}',
    '!a':       'https://www.amazon.com/s?k={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
    '!dd':      'https://thefreedictionary.com/{}',
    '!e':       'https://www.ebay.com/sch/i.html?_nkw={}',
    '!fb':      'https://www.facebook.com/s.php?q={}',
    '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
    '!gist':    'https://gist.github.com/search?q={}',
    '!gi':      'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    '!gn':      'https://news.google.com/search?q={}',
    '!ig':      'https://www.instagram.com/explore/tags/{}',
    '!m':       'https://www.google.com/maps/search/{}',
    '!p':       'https://pry.sh/{}',
    '!r':       'https://www.reddit.com/search?q={}',
    '!sd':      'https://slickdeals.net/newsearch.php?q={}&searcharea=deals&searchin=first',
    '!t':       'https://www.thesaurus.com/browse/{}',
    '!tw':      'https://twitter.com/search?q={}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    '!yelp':    'https://www.yelp.com/search?find_desc={}',
    '!yt':      'https://www.youtube.com/results?search_query={}'
}


# Short aliases for open commands
config.bind('o', 'cmd-set-text -s :open ')
config.bind('t', 'cmd-set-text -s :open -t ')
config.bind('w', 'cmd-set-text -s :open -w ')
config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')

c.content.headers.user_agent = "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135"

config.set('content.javascript.enabled', True, '*://*.digikey.com/*')
config.set('content.javascript.enabled', True, 'https://www.digikey.com')
config.set('content.javascript.enabled', True, '*://digikey.com/*')
