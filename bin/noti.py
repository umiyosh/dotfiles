#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import os
import sys

message = ' '.join(sys.argv[1:])
notification_command = 'osascript -e \'display notification \"%s\"\'' % message
os.system(notification_command)
