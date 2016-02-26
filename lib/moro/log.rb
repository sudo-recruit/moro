require "logger"

module Moro

  def self.logger
    if @logger.nil?
      @logger = Logger.new STDOUT
      @logger.level = Logger::INFO
    end
    @logger
  end
end
