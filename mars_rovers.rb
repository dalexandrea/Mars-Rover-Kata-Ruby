#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

# This file acts as the entry-point executable to the project.

require 'controller'

MarsRoversCLI.execute
