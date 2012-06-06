require 'json'
require 'nokogiri'

module Alloy

  class Config
    # Public: Creates a new config instance.
    #
    # Examples
    #
    #   config = Alloy::Config.new('alloy.json')
    #
    # path - The String represents path to alloy.json
    def initialize(path)
      load_alloy_json(path)
      load_tiapp_xml
    end

    # Public: Returns Application ID
    #
    # Examples
    #
    #   app_id
    #   # => 'com.example.helloworld'
    #
    # Returns the Application ID String.
    def app_id
      @app_id
    end

    # Public: Returns Application Name
    #
    # Examples
    #
    #   app_name
    #   # => 'HelloWorld'
    #
    # Returns the Application Name String.
    def app_name
      @app_name
    end

    # Public: Returns path to Titanium Mobile SDK installation.
    #
    # Examples
    #
    #   titanium_sdk_path
    #   # => '/Library/Application Support/Titanium'
    #
    # Returns the path String.
    def titanium_sdk_path
      File.expand_path(@json['titanium']['sdk_path'])
    end

    # Public: Returns Titanium Mobile SDK version string.
    #
    # Examples
    #
    #   titanium_sdk_version
    #   # => '1.8.2'
    #
    # Returns the version String.
    def titanium_sdk_version
      @titanium_sdk_version
    end

    # Public: Returns iPhone SDK version string.
    #
    # Examples
    #
    #   iphone_sdk_version
    #   # => '5.0'
    #
    # Returns the version String.
    def iphone_sdk_version
      @json['iphone']['sdk_version']
    end

    # Public: Returns path string to Android SDK installation.
    #
    # Examples
    #
    #   android_sdk_path
    #   # => ''
    #
    # Returns the path String.
    def android_sdk_path
      File.expand_path(@json['android']['sdk_path'])
    end

    # Public: Returns AVD ID string.
    #
    # Examples
    #
    #   android_avd_id
    #   # => '1'
    #
    # Returns the AVD ID String.
    def android_avd_id
      @json['android']['avd_id']
    end

    # Public: Returns Titanium assets directory path string.
    #
    # Examples
    #
    #   titanium_assets_path
    #   # => '/Library/Application Support/Titanium/mobilesdk/osx/2.0.2.GA'
    #
    # Returns the AVD ID String.
    def titanium_assets_path
      titanium_sdk_path + '/mobilesdk/osx/' + titanium_sdk_version
    end

    # Public: Returns Titanium iPhone assets directory path string.
    #
    # Examples
    #
    #   titanium_iphone_path
    #   # => '/Library/Application Support/Titanium/mobilesdk/osx/2.0.2.GA/iphone'
    #
    # Returns the AVD ID String.
    def titanium_iphone_path
      titanium_assets_path + '/iphone'
    end

    # Public: Returns Titanium Android assets directory path string.
    #
    # Examples
    #
    #   titanium_android_path
    #   # => '/Library/Application Support/Titanium/mobilesdk/osx/2.0.2.GA/android'
    #
    # Returns the AVD ID String.
    def titanium_android_path
      titanium_assets_path + '/android'
    end

    # Public: Returns Titanium iPhone builder.py path string.
    #
    # Examples
    #
    #   titanium_iphone_builder
    #   # => '/Library/Application Support/Titanium/mobilesdk/osx/2.0.2.GA/iphone/builder.py'
    #
    # Returns the AVD ID String.
    def titanium_iphone_builder
      titanium_iphone_path + '/builder.py'
    end

    # Public: Returns Titanium Android builder.py path string.
    #
    # Examples
    #
    #   titanium_android_builder
    #   # => '/Library/Application Support/Titanium/mobilesdk/osx/2.0.2.GA/android/builder.py'
    #
    # Returns the AVD ID String.
    def titanium_android_builder
      titanium_android_path + '/builder.py'
    end

    # Public: Returns project root directory path string.
    #
    # Examples
    #
    #   project_root
    #   # => '/path/to/titanium-project-root'
    #
    # Returns the AVD ID String.
    def project_root
      @json['project_root']
    end

    # Public: Returns Xcode Build Signing Identity string.
    #
    # Examples
    #
    #   xcode_build_signing_identity
    #   # => "iPhone Distribution: [Author]"
    #
    # Returns build_signing_identity String.
    def xcode_build_signing_identity
      @json['xcode']['build_signing_identity']
    end

    # Public: Returns Xcode Build Mobileprovision Path string.
    #
    # Examples
    #
    #   xcode_build_mobileprovision_path
    #   # => "/Library/MobileDevice/Provisioning Profiles/[AppName].mobileprovision"
    #
    # Returns build_mobileprovision_path String.
    def xcode_build_mobileprovision_path
      @json['xcode']['build_mobileprovision_path']
    end

    # Public: Returns Xcode Build Configuration string.
    #
    # Examples
    #
    #   xcode_build_configuration
    #   # => "Release"
    #
    # Returns build_configuration String.
    def xcode_build_configuration
      @json['xcode']['build_configuration']
    end

    # Public: Returns Xcode Build Dstroot string.
    #
    # Examples
    #
    #   xcode_build_dstroot
    #   # => "dstroot"
    #
    # Returns build_dstroot String.
    def xcode_build_dstroot
      @json['xcode']['build_dstroot']
    end

    # Public: Returns TestFlight Api Token string.
    #
    # Examples
    #
    #   testflight_api_token
    #   # => "********************************_*******"
    #
    # Returns api_token String.
    def testflight_api_token
      @json['testflight']['api_token']
    end

    # Public: Returns TestFlight Team Token string.
    #
    # Examples
    #
    #   testflight_team_token
    #   # => "********************************_******************************************"
    #
    # Returns team_token String.
    def testflight_team_token
      @json['testflight']['team_token']
    end

    private

    def load_alloy_json(path)
      @json = {}
      open(path) do |file|
        @json = JSON.parse(file.read)
      end
    end

    def load_tiapp_xml(filename = 'tiapp.xml')
      path = @json['project_root'] + '/' + filename
      open(path) do |f|
        doc = Nokogiri::XML(f)
        @app_id = doc.xpath('ti:app/id').text
        @app_name = doc.xpath('ti:app/name').text
        @titanium_sdk_version = doc.xpath('ti:app/sdk-version').text
      end
    end
  end

end
