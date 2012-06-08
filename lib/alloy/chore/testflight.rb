require 'alloy'
require 'colored'

module Alloy::Chore
  class TestFlight
    PERL_COLOR_FILTER = %Q{| perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}

    def self.run
      config = Alloy::Config.new('./alloy.json')
      puts "Takeoff to TestFlight... ".blue
      begin
        Dir.chdir('build/iphone')
        system %Q{bash -c "rm -rf #{Dir::getwd}/#{config.xcode_build_dstroot}" #{PERL_COLOR_FILTER}}
        system %Q{bash -c "mkdir #{config.xcode_build_dstroot}" #{PERL_COLOR_FILTER}}
        system %Q{bash -c "#{build_arg(config)}"  #{PERL_COLOR_FILTER}}
        system %Q{bash -c "#{package_arg(config)}"  #{PERL_COLOR_FILTER}}
        system %Q{bash -c "#{flight_arg(config)}" #{PERL_COLOR_FILTER}}
        system %Q{bash -c "rm -rf #{Dir::getwd}/#{config.xcode_build_dstroot}" #{PERL_COLOR_FILTER}}
      rescue => e
        puts e.backtrace.join("\n")
        puts e.message.red
        system %Q{bash -c "rm -rf ./#{config.xcode_build_dstroot}" #{PERL_COLOR_FILTER}}
        system %Q{killall "TestFlight Faild"}
      end

    end

    def self.build_arg(config)
      "xcodebuild -target '#{config.app_name}' -sdk iphoneos -configuration '#{config.xcode_build_configuration}' install DSTROOT=#{config.xcode_build_dstroot}"
    end

    def self.package_arg(config)
      "xcrun -sdk iphoneos PackageApplication '#{config.xcode_build_dstroot}/Applications/#{config.app_name}.app' -o '#{Dir::getwd}/#{config.xcode_build_dstroot}/#{config.app_name}.ipa' --sign '#{config.xcode_build_signing_identity}' --embed '#{config.xcode_build_mobileprovision_path}'"
    end

    def self.flight_arg(config)
      "curl 'http://testflightapp.com/api/builds.json' -F 'file=@#{Dir::getwd}/#{config.xcode_build_dstroot}/#{config.app_name}.ipa' -F 'api_token=#{config.testflight_api_token}' -F 'team_token=#{config.testflight_team_token}' -F 'notes=`git log -5`' -F 'notify=True'"
    end

  end
end
