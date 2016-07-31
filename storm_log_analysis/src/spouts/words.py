from __future__ import absolute_import, print_function, unicode_literals

import re
import time
import itertools
from streamparse.spout import Spout

class WordSpout(Spout):

    def initialize(self, stormconf, context):
        #self.words = ['dog', 'cat','zebra', 'elephant']
        file = '/home/dtz001/auth.log'
        logs = open(file,'rb').read().split('\n')
        self.logs_clean = []
        for log in logs:
            if re.search('Failed password',log):
                self.logs_clean.append(log)
    
    def next_tuple(self):
        for word in self.logs_clean:
            self.emit([word])
