# -*- encoding: utf-8 -*-

require 'thor'

module Alloy

  class Task < Thor
    desc 'coffee', 'Compile CoffeeScript into JavaScript'
    def coffee
      Command::CoffeeScript.new.execute
    end

    desc 'build [PLATFORM]', 'Build the app and run in simulator or emulator'
    def build(platform = 'iphone')
      return unless coffee
      Command::Build.new(platform).execute
    end

    desc 'clean [PLATFORM]', 'Clean build directory for specified platform'
    subcommand 'clean', Command::Clean
    # def clean(platform = nil)
    #   Command::Clean.new(platform).execute
    # end

    # desc 'docco', 'Generate documents by Docco'
    # def docco
    #   system %Q{bash -c "find app -name '*.coffee' | xargs docco"}
    #   system %Q{bash -c "open docs/app.html"}
    # end
  end

end
