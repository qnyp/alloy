require 'spec_helper'

describe Alloy::Config do
  let(:tiapp_xml_path) {
    File.join(File.dirname(__FILE__), '..', 'fixtures', 'tiapp.xml')
  }
  let(:json_path) {
    File.join(File.dirname(__FILE__), '..', 'fixtures', 'config.json')
  }

  describe ".load(path)" do
    let(:config) { nil }

    before { config = Alloy::Config.load(json_path) }
  end

  context "Default values" do
    let(:config) { Alloy::Config.new(tiapp_xml_path) }

    before do
      ENV.stub(:[]).with('ANDROID_SDK') { '' }
    end

    describe "#titanium_sdk_path" do
      subject { config.titanium_sdk_path }
      xit { should eq('/Library/Application\\ Support/Titanium') }
    end

    describe "#titanium_sdk_version" do
      subject { config.titanium_sdk_version }
      xit { should eq('1.8.2') }
    end

    describe "#iphone_sdk_version" do
      subject { config.iphone_sdk_version }
      xit { should eq('5.0') }
    end

    describe "#android_sdk_id" do
      subject { config.android_sdk_id }
      xit { should eq('6') }
    end

    describe "#android_sdk_path" do
      subject { config.android_sdk_path }
      xit { should eq('') }
    end
  end

  context "Environment variable ANDROID_SDK exists" do
    let(:config) { Alloy::Config.new(tiapp_xml_path) }

    before do
      ENV.stub(:[]).with('ANDROID_SDK') { '/path/to/android-sdk' }
    end

    describe "#android_sdk_path" do
      subject { config.android_sdk_path }
      xit { should eq('/path/to/android-sdk') }
    end
  end

end
