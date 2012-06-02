require 'alloy'
require 'colored'
require 'shellwords'
require 'thor'

module Alloy::Task
  class Build < Thor
    desc 'iphone', 'Build the iPhone app and run in simulator'
    def iphone
      Chore::build_and_run_iphone
    end

    desc 'android', 'Build the Android app and run in emulator'
    def android
      Chore::build_and_run_android
    end
  end

  class Build::Chore
    PERL_COLOR_FILTER = %Q{| perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}

    def self.build_and_run_iphone
      config = Alloy::Config.new('./alloy.json')
      puts "Building with Titanium... (DEVICE_TYPE: iphone)".blue
      bash_arg = [config.titanium_iphone_builder,
                  'run',
                  config.project_root + '/',
                  config.iphone_sdk_version,
                  config.app_id,
                  config.app_name,
                  'iphone'].map{|i|Shellwords.escape(i)}.join(' ')
      cmd = %Q{bash -c "#{bash_arg}" #{PERL_COLOR_FILTER}}
      begin
        system cmd
      rescue => e
        puts e.backtrace.join("\n")
        puts e.message.red
        system %Q{killall "iPhone Simulator"}
      end
    end

    def self.build_and_run_android
      config = Alloy::Config.new('./alloy.json')
      puts "Building with Titanium... (DEVICE_TYPE: android)".blue
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
      cmd = %Q{bash -c "#{bash_arg}" #{PERL_COLOR_FILTER}}
      puts cmd
      system cmd
    end
  end
end
