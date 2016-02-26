require "logger"

module Moro

  def self.logger
    if @logger.nil?
      @logger = Logger.new STDOUT
      @logger.level = Logger::DEBUG
    end
    @logger
  end
end
