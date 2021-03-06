# alloy

[![Code Climate](https://codeclimate.com/github/qnyp/alloy.png)](https://codeclimate.com/github/qnyp/alloy)

CLI Toolbelt for Titanium Mobile development on Mac OS X.

## Prerequisite

* Mac OS X 10.7
* Titanium Studio 2.0
* Ruby 1.9.3
* CoffeeScript

## Usage

### Setup

    $ cd /path/to/titanium-workspace/HelloWorld
    $ alloy init
          create  alloy.json

### Compiling CoffeeScript into JavaScript

You should place `*.coffee` files under the directory named `app`.

    $ mkdir app
    $ echo "Ti.API.console 'Hello'" > app/hello.coffee

Then, run `coffee` task.

    $ alloy coffee
    Compiling CoffeeScript
    Successfully compiled CoffeeScript

JavaScript files generated under the `Resources` directory.

    $ cat Resources/hello.js
    // Generated by CoffeeScript 1.3.1
    
    Ti.API.console('Hello');

### Cleaning up build directory

Run `clean` task to clean up intermediate files (`build/iphone/*` or `build/android/*`).

    $ alloy clean iphone
    $ alloy clean android

### Building app and run in iPhone simulator

    $ alloy build iphone

### Building app and run in Android emulator

Before using alloy, you need to create and setup a [AVD (Android Virtual Devices)](http://developer.android.com/intl/en/guide/developing/devices/index.html) for rapid development process.

#### AVD setup

1.  Launch Android SDK Manager. Install `SDK Platform` and `Google APIs` of any Android versions (at least greater than Android 2.2)`

        $ ANDROID_SDK_HOME/tools/android &

2.  Check what Android target availables

        $ ANDROID_SDK_HOME/tools/android list targets
        Available Android targets:
        ----------
        id: 1 or "android-15"
             Name: Android 4.0.3
             Type: Platform
             API level: 15
             Revision: 3
             Skins: HVGA, QVGA, WQVGA400, WQVGA432, WSVGA, WVGA800 (default), WVGA854, WXGA720, WXGA800
             ABIs : armeabi-v7a, x86
        ----------
        id: 2 or "Google Inc.:Google APIs:15"
             Name: Google APIs
             Type: Add-On
             Vendor: Google Inc.
             Revision: 2
             Description: Android + Google APIs
             Based on Android 4.0.3 (API level 15)
             Libraries:
              * com.google.android.media.effects (effects.jar)
                  Collection of video effects
              * com.android.future.usb.accessory (usb.jar)
                  API for USB Accessories
              * com.google.android.maps (maps.jar)
                  API for Google Maps
             Skins: WVGA854, WQVGA400, WSVGA, WXGA720, HVGA, WQVGA432, WVGA800 (default), QVGA, WXGA800
             ABIs : armeabi-v7a

3.  Create a new AVD

        $ ANDROID_SDK_HOME/tools/android create avd \
          -n my_android-4.0.3 \
          -t 1 \
          --abi armeabi-v7a \
          --skin WVGA800

    `my_android-4.0.3` is AVD name, `1` is ID of Android target.

    AVD created under `~/.android/avd`.

        $ ls -la ~/.android/avd
        total 8
        drwxr-xr-x  4 juno  staff  136  6  1 00:56 .
        drwxr-xr-x  6 juno  staff  204  6  1 00:51 ..
        drwxr-xr-x  4 juno  staff  136  6  1 00:56 my_android-4.0.3.avd
        -rw-r--r--  1 juno  staff   69  6  1 00:56 my_android-4.0.3.ini
    
        $ ANDROID_SDK_HOME/tools/android list avd
        Available Android Virtual Devices:
            Name: my_android-4.0.3
            Path: /Users/juno/.android/avd/my_android-4.0.3.avd
          Target: Android 4.0.3 (API level 15)
             ABI: armeabi-v7a
            Skin: WVGA800
    
    Yay!

4.  Enable SD Card support to install application

        $ echo "sdcard.size=256M" >> ~/.android/avd/my_android-4.0.3.avd/config.ini

#### Running Android emulator

1.  Start adb server

        $ ANDROID_SDK_HOME/platform-tools/adb start-server

2.  Launch Android emulator

        $ ANDROID_SDK_HOME/tools/emulator -avd my_android-4.0.3

    After Android launch, emulator instance appears as a device.

        $ ANDROID_SDK_HOME/platform-tools/adb devices
        List of devices attached
        emulator-5554   device

#### Build and install application to emulator

    $ alloy build android

#### Shutting down Android emulator

1.  Exit Android emulator app

2.  Kill adb server

        $ ANDROID_SDK_HOME/platform-tools/adb kill-server

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
