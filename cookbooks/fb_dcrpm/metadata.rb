# Copyright (c) 2016-present, Facebook, Inc.
name 'fb_dcrpm'
maintainer 'Facebook'
maintainer_email 'oncall+oscore@xmail.facebook.com'
license 'All rights reserved'
description 'Installs/Configures dcrpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
depends 'fb_helpers'
depends 'fb_logrotate'
depends 'fb_timers'
