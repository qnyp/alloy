# -*- encoding: utf-8 -*-

require 'colored'

module Alloy::Command

  class Build
    def initialize(platform)
      @platform = platform
    end

    def execute
      if @platform == 'iphone'
        build :device => 'iphone'
      elsif @platform == 'android'
        build :device => 'android'
      else
        raise ArgumentError, "Platform '#{@platform}' is invalid"
      end

      true
    end

    private

    def build(options = {})
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

  end

end
