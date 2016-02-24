require 'thor'
require 'moro/version'
require 'moro/monitor'
require 'moro/daemon'

module Moro
  # class << self
  class CLI< Thor
    map '--version' => :version

    desc "hello NAME", "say hello to NAME"
    def hello(name, from=nil)
      puts "from: #{from}" if from
      puts "Hello #{name}"
    end

    desc 'version', 'Prints the moro version'
    def version
      puts "#{File.basename($0)} #{VERSION}"
    end

    desc 'show', 'show process resource usage'
    def show
      monitor=Monitor.new
      monitor.show
    end

    desc 'start', 'start monitor process resource usage'
    def start
      daemon=Daemon.new
      daemon.start
    end

  end
end
