require 'alloy'
require 'thor'

module Alloy
  class CLI < Thor
    include Thor::Actions

    Alloy::CLI.source_root(File.expand_path('../../templates', __FILE__))

    desc 'build SUBCOMMAND', 'Build the app and run in simulator or emulator'
    subcommand 'build', Task::Build

    desc 'install SUBCOMMAND', 'Install to device'
    subcommand 'install', Task::Install

    desc 'clean SUBCOMMAND', 'Clean up build directory'
    subcommand 'clean', Task::Clean

    desc 'coffee', 'Compile CoffeeScript into JavaScript'
    def coffee
      Chore::CoffeeScript.run
    end

    desc 'init', 'Generate alloy.json'
    def init
      template('alloy.json.erb', 'alloy.json')
    end
  end
end
