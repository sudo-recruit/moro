require "get_process_mem"

module Moro
  class Process
    attr_reader :name,:pid,:file

    def initialize(options)
      log_file="app.log"
      @logger = Logger.new log_file
      @name=options[:name]
      @file=options[:file]
      update_pid
    end

    def usage
      if pid!=nil
        pm=GetProcessMem.new(pid)
        #pid need to change
        if pm.bytes==0
          update_pid
        end
        pm=GetProcessMem.new(pid)
        mem = pm.mb
        {name:name,memory:mem}
      else
        update_pid
        {name:name,memory:0.0}
      end
    end


    private

    def get_pid(filename)
      begin
        f = File.open(filename, "r")
        line = f.gets
      rescue => err
        @logger.error "Exception: #{err}"
        nil
      end
    end

    def update_pid
      @pid=get_pid(@file)
    end

  end
end
