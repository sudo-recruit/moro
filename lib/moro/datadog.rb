require 'statsd'

module Moro
  class Datadog

    def initialize
      @statsd = Statsd.new('localhost', 8125)
    end

    def send(process_usages)
      process_usages.each do |process|
        name=process[:name]
        @statsd.histogram("#{name}.memory", process[:memory])
      end
    end

  end
end
