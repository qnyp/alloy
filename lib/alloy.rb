# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require "alloy/command"
require "alloy/config"
require "alloy/task"

module Alloy

  PERL_COLOR_FILTER = %Q{| perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}

end
