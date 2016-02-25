require 'moro/monitor'
require 'moro/datadog'
require "moro/log"

module Moro
  class Daemon

    def initialize(config)
      @monitor=Monitor.new(config)
      build_handlers(config)
      puts config

      if config["interval"]!=nil
        @interval=config["interval"]
      else
        @interval=30
      end
    end

    def start()
      start_message="start moro daemon"
      stop_message="stop moro daemon"
      puts start_message
      MyLog.log.info start_message

      at_exit do
        puts stop_message
        MyLog.log.info stop_message
      end

      while true
        process_usages=@monitor.monit

        @handlers.each do |handler|
          handler.send(process_usages)
        end

        MyLog.log.info "stats memory"
        sleep(@interval)
      end
    end

    private

    def build_handlers(config)
      @handlers=[]
      if config["datadog"]
        @dog=Datadog.new
        @handlers <<@dog
      end
    end

  end
end
