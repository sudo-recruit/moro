require 'thor'
require 'moro/version'
require 'moro/monitor'
require 'moro/daemon'

module Moro
  # class << self
  class CLI< Thor
    map '--version' => :version

    desc 'version', 'Prints the moro version'
    def version
      puts "#{File.basename($0)} #{VERSION}"
    end

    desc 'show', 'show process resource usage'
    option :config,:required => true,:banner=>"config.json"
    def show
      monitor=Monitor.new(options)
      monitor.show
    end

    desc 'start', 'start monitor process resource usage'
    option :config,:required => true,:banner=>"config.json"
    def start
      daemon=Daemon.new(options)
      daemon.start
    end

  end
end
