require 'thor'
require 'moro/version'
require 'moro/monitor'
require 'moro/daemon'
require 'moro/log'
require 'json'


module Moro
  class CLI< Thor
    map '--version' => :version

    desc 'version', 'Prints the moro version'
    def version
      puts "#{File.basename($0)} #{VERSION}"
    end

    desc 'show', 'show process resource usage'
    option :config,:required => true,:banner=>"config.json"
    option :'log-level',:banner=>"warn"
    def show
      config=get_config(options[:config])
      Moro.initialize_logger(options)
      monitor=Monitor.new(config)
      monitor.show
    end

    desc 'start', 'start monitor process resource usage'
    option :config,:required => true,:banner=>"config.json"
    option :'log-level',:banner=>"warn"
    def start
      config=get_config(options[:config])
      Moro.initialize_logger(options)
      daemon=Daemon.new(config)
      daemon.start
    end

    private

    def get_config(file)
      begin
        data = ''
        f = File.open(file, "r")
        f.each_line do |line|
          data += line
        end
        JSON.parse(data)
      rescue => err
        puts "#{err}"
        nil
      end
    end

  end
end
