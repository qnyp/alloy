# -*- encoding: utf-8 -*-

require 'thor'

module Alloy

  class Task < Thor
    desc 'coffee', 'Compile CoffeeScript into JavaScript'
    def coffee
      Command.compile_coffee
    end

    desc 'build [PLATFORM]', 'Build the app and run in simulator or emulator'
    def build(platform = 'iphone')
      if platform == 'iphone'
        Command::build :device => 'iphone'
      elsif platform == 'android'
        Command.build :device => 'android'
      else
        raise ArgumentError, "Platform '#{platform}' is invalid"
      end
    end

    desc 'clean [PLATFORM]', 'Clean build directory for specified platform'
    def clean(platform = nil)
      case platform
      when 'android'
        Command.clean :device => 'android'
      when 'iphone'
        Command.clean :device => 'iphone'
      when nil
        Command.clean :device => 'android'
        Command.clean :device => 'iphone'
      else
        raise ArgumentError, "Platform '#{platform}' is invalid"
      end
    end

    desc 'docco', 'Generate documents by Docco'
    def docco
      system %Q{bash -c "find app -name '*.coffee' | xargs docco"}
      system %Q{bash -c "open docs/app.html"}
    end
  end

end
