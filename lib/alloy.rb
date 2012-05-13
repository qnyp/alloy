# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

module Alloy
  autoload :Config, 'alloy/config'
  autoload :Task, 'alloy/task'

  module Command
    autoload :Build, 'alloy/command/build'
    autoload :Clean, 'alloy/command/clean'
    autoload :CoffeeScript, 'alloy/command/coffee_script'
  end

  PERL_COLOR_FILTER = %Q{| perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}
end
