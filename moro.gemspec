Gem::Specification.new do |s|
  s.name        = 'moro'
  s.version     = '0.0.1'
  s.date        = '2016-02-24'
  s.summary     = "monitor process memory usage"
  s.description = "monitor process memory usage"
  s.authors     = ["ocowchun"]
  s.email       = 'ben.yeh@sudo.com.tw'
  s.files = `git ls-files`.split($/)
  s.homepage    =
    'https://github.com/sudo-recruit/moro'
  s.license       = 'MIT'

  s.add_dependency('get_process_mem',["~> 0.2.0"])
  s.add_dependency('thor',["~> 0.18"])
end