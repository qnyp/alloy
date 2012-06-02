require 'colored'
require 'fileutils'
require 'thor'

module Alloy::Task
  class Clean < Thor
    desc 'iphone', 'Clean up iPhone build directory'
    def iphone
      Chore::clean_up_iphone
    end

    desc 'android', 'Clean up Android build directory'
    def android
      Chore::clean_up_android
    end
  end

  class Clean::Chore
    def self.clean_up_iphone
      clean_up('build/iphone')
    end

    def self.clean_up_android
      clean_up('build/android')
    end

    def self.clean_up(path)
      if Dir.exist?(path)
        FileUtils.rm_r Dir.glob("#{path}/*"), :force => true
        puts "Cleaned #{path}".blue
      else
        puts "Directory '#{path}' not found".red
      end
    end
  end
end
