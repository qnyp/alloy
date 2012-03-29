# -*- encoding: utf-8 -*-

require 'colored'
require 'fileutils'

module Alloy

  module Command
    def self.compile_coffee
      puts "Compiling CoffeeScript".blue

      failed = false
      paths = `find app -name '*.coffee'`.split("\n")

      paths.each do |path|
        out_dir = path.gsub(/^app/, 'Resources').gsub(/\/[\w-]*\.coffee$/,"")
        unless system "coffee -c -b -o #{out_dir} #{path}"
          puts "Compilation failed: #{path}".red
          failed = true
        end
      end

      puts "Successfully compiled CoffeeScript".green unless failed
      not failed
    end

    def self.build(options = {})
      return unless compile_coffee
      options[:device] ||= 'iphone'

      config = Alloy::Config.new

      puts "Building with Titanium... (DEVICE_TYPE: #{options[:device]})".blue
      case options[:device]
      when 'android'
        system %Q{bash -c "#{config.titanium_android_builder} run '#{config.project_root}/' #{config.android_sdk_path} #{config.app_id} #{config.app_name} #{options[:device]} " #{Alloy::PERL_COLOR_FILTER}}
      when 'iphone'
        begin
          system %Q{bash -c "#{config.titanium_iphone_builder} run '#{config.project_root}/' #{config.iphone_sdk_version} #{config.app_id} #{config.app_name} #{options[:device]}" #{Alloy::PERL_COLOR_FILTER}}
        rescue => e
          puts e.message.red
          system %Q{killall "iPhone Simulator"}
        end
      end
    end

    def self.clean(options = {})
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
