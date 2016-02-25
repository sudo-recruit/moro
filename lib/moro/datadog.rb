require 'statsd'

module Moro
  class Datadog

    def initialize
      @statsd = Statsd.new('localhost', 8125)
    end

    def send(data)
      # name=data[:name]
      # @statsd.histogram("#{name}.memory", data[:memory])

      puts "handle data in dog"
    end

  end
end
