require "get_process_mem"
require "moro/log"

module Moro
  class Process
    attr_reader :name,:pid,:file,:tags

    def initialize(options)
      @name=options[:name]
      @file=options[:file]
      if options[:tags]!=nil
        @tags=options[:tags]
      else
        @tags=[]
      end
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
        {name:name,memory:mem,tags:tags}
      else
        update_pid
        {name:name,memory:0.0,tags:tags}
      end
    end


    private

    def get_pid(filename)
      begin
        f = File.open(filename, "r")
        line = f.gets
      rescue => err
        Moro.logger.error "Exception: #{err}"
        nil
      end
    end

    def update_pid
      @pid=get_pid(@file)
    end

  end
end
