require 'moro/monitor'
require 'moro/datadog'

module Moro
  class Daemon

    def initialize(config)
      @monitor=Monitor.new(config)
      @logger = Logger.new STDOUT
      @dog=Datadog.new
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
      @logger.info(start_message)

      at_exit do
        puts stop_message
        @logger.info(stop_message)
      end

      while true
        data=@monitor.monit

        data.each do|d|
          @dog.send(d)
        end

        @logger.info "stats memory"

        sleep(@interval)
      end
    end
  end
end
