# -*- encoding: utf-8 -*-

require 'colored'
require 'shellwords'

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

      config = Alloy::Config.new('./alloy.json')

      puts "Building with Titanium... (DEVICE_TYPE: #{options[:device]})".blue
      case options[:device]
      when 'android'
        command = 'simulator'
        project_name = config.app_name
        sdk_dir = config.android_sdk_path
        project_dir = config.project_root + '/'
        app_id = config.app_id
        avd_id = config.android_avd_id
        bash_arg = [config.titanium_android_builder,
                    command,
                    project_name,
                    sdk_dir,
                    project_dir,
                    app_id,
                    avd_id].map{|i|Shellwords.escape(i)}.join(' ')
        cmd = %Q{bash -c "#{bash_arg}" #{Alloy::PERL_COLOR_FILTER}}
        puts cmd
        system cmd
      when 'iphone'
        bash_arg = [config.titanium_iphone_builder,
                    'run',
                    config.project_root + '/',
                    config.iphone_sdk_version,
                    config.app_id,
                    config.app_name,
                    options[:device]].map{|i|Shellwords.escape(i)}.join(' ')
        cmd = %Q{bash -c "#{bash_arg}" #{Alloy::PERL_COLOR_FILTER}}
        begin
          system cmd
        rescue => e
          puts e.backtrace.join("\n")
          puts e.message.red
          system %Q{killall "iPhone Simulator"}
        end
      end
    end

  end

end
