from __future__ import absolute_import, print_function, unicode_literals

import re
from collections import Counter
from streamparse.bolt import Bolt

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

    def process(self, tup):
        word = tup.values[0]
        #word = re.findall('[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+',word)
        if re.search('[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+',word):
            word = re.search('[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+',word).group()
        
        self.counts[word] += 1
        if (self.counts[word] == 1) or (self.counts[word] >= 500):
            self.emit([word, self.counts[word]])
            self.log('%s: %d' % (word, self.counts[word]))
