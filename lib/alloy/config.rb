# -*- encoding: utf-8 -*-

require 'shellwords'
require 'json'
require 'nokogiri'

module Alloy

  class Config
    def self.load(path)
      json = nil
      open(path) do |file|
        json = JSON.parse(file.read)
      end
    end

    def initialize
      open(File.join(project_root, 'tiapp.xml')) do |f|
        doc = Nokogiri::XML(f)
        @app_id = doc.xpath('ti:app/id').text
        @app_name = doc.xpath('ti:app/name').text
      end
    end

    def app_id
      @app_id
    end

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
      # TODO: linux support
      Shellwords.escape('/Library/Application Support/Titanium')
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
      '1.8.2'
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
      '5.0'
    end

    # Public: Returns Android SDK version ID.
    #
    # Examples
    #
    #   android_sdk_id
    #   # => '6'
    #
    # Returns the version String.
    def android_sdk_id
      '6'
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
      ENV['ANDROID_SDK']
    end

    def titanium_assets_path
      "#{titanium_sdk_path}/mobilesdk/osx/#{titanium_sdk_version}"
    end

    def titanium_iphone_path
      "#{titanium_assets_path}/iphone"
    end

    def titanium_android_path
      "#{titanium_assets_path}/android"
    end

    def titanium_iphone_builder
      "#{titanium_iphone_path}/builder.py"
    end

    def titanium_android_builder
      "#{titanium_android_path}/builder.py"
    end

    def project_root
      Dir.getwd
    end

  end

end
