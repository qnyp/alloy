require 'alloy'
require 'thor'

module Alloy
  class CLI < Thor
    desc 'build SUBCOMMAND', 'Build the app and run in simulator or emulator'
    subcommand 'build', Task::Build

    desc 'clean SUBCOMMAND', 'Clean up build directory'
    subcommand 'clean', Task::Clean

    desc 'coffee', 'Compile CoffeeScript into JavaScript'
    def coffee
      Chore::CoffeeScript.run
    end
  end
end
