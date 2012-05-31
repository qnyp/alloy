# -*- encoding: utf-8 -*-

require 'colored'
require 'fileutils'

module Alloy::Command

  class Clean < Thor
    desc 'clean iphone', 'Clean iPhone build directory'
    def iphone
      execute('iphone')
    end

    desc 'clean android', 'Clean Android build directory'
    def android
      execute('android')
    end

    # def initialize(platform)
    #   @platform = platform
    # end

    private
    def execute(platform)
      case platform
      when 'android'
        clean :device => 'android'
      when 'iphone'
        clean :device => 'iphone'
      when nil
        clean :device => 'android'
        clean :device => 'iphone'
      else
        raise ArgumentError, "Platform '#{platform}' is invalid"
      end

      true
    end

    def clean(options = {})
      case options[:device]
      when 'android'
        FileUtils.rm_r Dir.glob('build/android/*'), :force => true
        puts "Cleaned build/android".blue
      when 'iphone'
        FileUtils.rm_r Dir.glob('build/iphone/*'), :force => true
        puts "Cleaned build/iphone".blue
      end
    end
  end

end
