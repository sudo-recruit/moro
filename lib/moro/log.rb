require "logger"

module Moro

  def self.initialize_logger(options={})
    log_levels={"debug"=>Logger::DEBUG,"info"=>Logger::INFO,"warn"=>Logger::WARN,
                "error"=>Logger::ERROR,"fatal"=>Logger::FATAL,"unknown"=>Logger::UNKNOWN}
    level=log_levels[options['log-level']]||Logger::WARN
    @logger = Logger.new STDOUT
    @logger.level = level
  end

  def self.logger
    if @logger.nil?
      initialize_logger
    end
    @logger
  end
end
