require "logger"
require "get_process_mem"
require 'json'

@log_file="app.log"
@logger = Logger.new @log_file

def get_pid(filename)
  begin
    f = File.open(filename, "r")
    line = f.gets
  rescue => err
    @logger.error "Exception: #{err}"
    nil
  end
end

def get_config()
  begin
    data = ''
    f = File.open("config.json", "r")
    f.each_line do |line|
      data += line
    end
    JSON.parse(data)
  rescue => err
    @logger.error "Exception: #{err}"
    nil
  end
end

def get_processes()
  config=get_config()
  processes=[]
  config["processes"].each do|p|
    pid=get_pid(p["pid"])
    processes<<{name:p["name"],pid:pid} if pid!=nil
  end
  processes
end

def monit_all()
  processes=get_processes()
  while true
    processes.each do |p|
      puts mem = GetProcessMem.new(p[:pid]).inspect
    end
    @logger.info "stats memory"

    sleep(10)
  end
end

monit_all()

at_exit do
  @logger.info "momo stop"
end
