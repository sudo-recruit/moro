lib_dir = File.join(File.dirname(__FILE__),'lib')
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)
require 'moro/version'

Gem::Specification.new do |s|
  s.name        = 'moro'
  s.version =  Moro::VERSION
  s.date        = '2016-02-24'
  s.summary     = "moro is a simple daemon to monitor process memory usage"
  s.description = "moro is a simple daemon to monitor process memory usage"
  s.authors     = ["ocowchun"]
  s.email       = 'ben.yeh@sudo.com.tw'
  s.executables = ["moro"]
  s.files = `git ls-files`.split($/)
  s.homepage    =
  'https://github.com/sudo-recruit/moro'
  s.license       = 'MIT'

  s.add_dependency('get_process_mem',["~> 0.2.0"])
  s.add_dependency('thor',["~> 0.18"])
  s.add_dependency('dogstatsd-ruby',["~> 1.6.0"])
end