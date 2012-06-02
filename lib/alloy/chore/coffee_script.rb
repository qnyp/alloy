require 'colored'

module Alloy::Chore

  class CoffeeScript
    def self.run
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
  end

end
