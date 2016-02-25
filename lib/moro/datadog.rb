require 'statsd'

module Moro
  class Datadog

    def initialize
      @statsd = Statsd.new('localhost', 8125)
    end

    def send(process_usages)
      process_usages.each do |process|
        name=process[:name]
        tags=process[:tags]
        memory=process[:memory]
        @statsd.histogram("#{name}.memory",memory , :tags =>tags)
      end
    end

  end
end
