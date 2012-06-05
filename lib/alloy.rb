module Alloy
  autoload :CLI, 'alloy/cli'
  autoload :Config, 'alloy/config'
  autoload :VERSION, 'alloy/version'

  module Chore
    autoload :CoffeeScript, 'alloy/chore/coffee_script'
  end

  module Task
    autoload :Build, 'alloy/task/build'
    autoload :TestFlight, 'alloy/task/testflight'
    autoload :Clean, 'alloy/task/clean'
  end
end
