require "get_process_mem"
require "moro/process"
require "moro/log"

module Moro
  class Monitor

    def initialize(config)
      @config=config
      MyLog.log.info "moro show"
      @processes=get_processes
    end

    def show
      data=monit
      data.each do|d|
        puts "#{d[:name]}:#{d[:memory]}"
      end
    end

    def monit
      data=[]
      @processes.each do |p|
        data << p.usage
      end
      data
    end

    private

    def get_processes()
      processes=[]
      @config["processes"].each do|p|
        processes<<Process.new({name:p["name"],file:p["pid"],tags:p["tags"]})
      end
      processes
    end
  end
end
