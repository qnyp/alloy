# -*- coding: utf-8 -*-
require 'colored'
require 'fileutils'
require 'shellwords'
require 'thor'

module Alloy::Task
  class Generate < Thor
    include Thor::Actions
    Alloy::Task::Generate.source_root(File.expand_path('../../../templates', __FILE__))

    desc 'project [DEFAULT_WINDOW_NAME]', 'Generate alloy style project'
    def project(window)
      generate_project(window)
    end

    desc 'tab [WINDOW_NAME]', 'Generate tab class'
    def tab(name)
      generate_window(name, false)
      generate_tab(name)
    end

    desc 'window [WINDOW_NAME]', 'Generate window class'
    def window(name)
      generate_window(name, true)
    end

    # TODO: generate_viewを実装します
    # desc 'view [WINDOW_NAME]', 'Generate view class'
    # def view(name)
    #   generate_view(name)
    # end

    private

    def generate_project(window_name)
      copy_images
      copy_app
      copy_vendor
      generate_tabgroup(window_name)
      generate_window(window_name)
      generate_tab(window_name)
    end

    def copy_images
      puts "copy_images".blue

      resources_dir = Dir.pwd + "/Resources/"
      images = Dir.glob(resources_dir + "*.png")

      to = Dir.pwd + "/Resources/images/tabs"
      FileUtils.mkdir_p(to)
      FileUtils.cp_r images, to
      FileUtils.rm_r images
    end

    def copy_app
      directory('app', 'app')
    end

    def copy_vendor
      directory('Resources/vendor', 'Resources/vendor')
    end

    def generate_tabgroup(window_name)
      @window = window_name
      template('erb/ui/TabGroup.coffee.erb', 'app/ui/TabGroup.coffee')
    end

    def generate_tab(window_name)
      @window = window_name
      template('erb/ui/tabs/TemplateTab.coffee.erb', "app/ui/tabs/#{window_name}Tab.coffee")
      setup_tabgroup(window_name)
    end

    def setup_tabgroup(window_name)
      gsub_file './app/ui/TabGroup.coffee', /# global.tabs.add \(don't remove this line\)/ do |match|
        match = "#{window_name}Tab: null\n      #{match}"
      end

      gsub_file './app/ui/TabGroup.coffee', /# global.windows.add \(don't remove this line\)/ do |match|
        match = "#{window_name}Window: null\n      #{match}"
      end

      gsub_file './app/ui/TabGroup.coffee', /# require tabs \(don't remove this line\)/ do |match|
        match = "#{window_name}Tab = require('ui/tabs/#{window_name}Tab')\n  #{match}"
      end

      gsub_file './app/ui/TabGroup.coffee', /# require tabs \(don't remove this line\)/ do |match|
        match = "#{window_name}Tab = require('ui/tabs/#{window_name}Tab')\n  #{match}"
      end

      gsub_file './app/ui/TabGroup.coffee', /# require window \(don't remove this line\)/ do |match|
        match = "#{window_name}Window = require('ui/windows/#{window_name}Window')\n  #{match}"
      end

      gsub_file './app/ui/TabGroup.coffee', /# create new window and tab \(don't remove this line\)/ do |match|
        matches = match
        match = ""
        match << "\n  #{window_name}Win = new #{window_name}Window(global)"
        match << "\n  #{window_name.downcase}Tab = new #{window_name}Tab(#{window_name}Win.window)"
        match << "\n  global.tabs.#{window_name}Tab = #{window_name.downcase}Tab"
        match << "\n  #{window_name}Win.containingTab = #{window_name.downcase}Tab"
        match << "\n  #{matches}"
      end

      gsub_file './app/ui/TabGroup.coffee', /# add tabs to tabGroup \(don't remove this line\)/ do |match|
        match = "self.addTab(#{window_name.downcase}Tab)\n  #{match}"
      end
    end

    def generate_window(window_name, show_notice=false)
      @window = window_name
      template('erb/ui/windows/TemplateWindow.coffee.erb', "app/ui/windows/#{window_name}Window.coffee")
      if show_notice
        puts 'こうやって使ってね'.blue
        puts 'スタイルに値を追加してね'.blue
      end
    end

    # TODO: generate_viewを実装します

  end
end
