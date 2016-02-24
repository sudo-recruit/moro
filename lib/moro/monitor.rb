require "logger"
require "get_process_mem"
require "moro/process"

module Moro
  class Monitor

    def initialize(config)
      @config=config
      @logger = Logger.new STDOUT
      @logger.info "moro show"
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
        data << p.usage
      end
      data
    end

    def get_processes()
      processes=[]
      @config["processes"].each do|p|
        processes<<Process.new({name:p["name"],file:p["pid"]})
      end
      processes
    end
  end
end
