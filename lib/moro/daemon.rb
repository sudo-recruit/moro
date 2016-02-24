require 'moro/monitor'

module Moro
  class Daemon

    def initialize
      @monitor=Monitor.new
      log_file="app.log"
      @logger = Logger.new log_file
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
        @monitor.show
        @logger.info "stats memory"

        sleep(10)
      end
    end
  end
end
