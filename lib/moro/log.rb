require "logger"

module Moro
  class MyLog

    def self.log
      if @logger.nil?
        @logger = Logger.new STDOUT
        @logger.level = Logger::DEBUG
      end
      @logger
    end
  end
end
