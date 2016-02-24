require "logger"
require 'json'
require "get_process_mem"

module Moro
  class Monitor

    def initialize
      log_file="app.log"
      @logger = Logger.new log_file
      @logger.info "momo show"
      @processes=get_processes
    end

    def show
      data=monit
      data.each do|d|
        puts "#{d[:name]}:#{d[:memory]}"
      end
    end

    private

    def monit
      data=[]
      @processes.each do |p|
        mem = GetProcessMem.new(p[:pid]).mb
        data<<{name:p[:name],memory:mem}
      end
      data
    end

    def get_config
      begin
        data = ''
        f = File.open("config.json", "r")
        f.each_line do |line|
          data += line
        end
        JSON.parse(data)
      rescue => err
        @logger.error "Exception: #{err}"
        puts "#{err}"
        nil
      end
    end

    def get_pid(filename)
      begin
        f = File.open(filename, "r")
        line = f.gets
      rescue => err
        @logger.error "Exception: #{err}"
        nil
      end
    end

    def get_processes()
      config=get_config()
      processes=[]
      config["processes"].each do|p|
        pid=get_pid(p["pid"])
        processes<<{name:p["name"],pid:pid} if pid!=nil
      end
      processes
    end
  end
end
