#moro
>monitor process memory usage

##Install
```bash
$ gem install moro
```

##Show process memory usage
```bash
$ moro show --config="config.example.json"
```

##Start a daemon to show process memory usage
```bash
$ moro start --config="config.example.json"
```

###config example
```json
{
	"processes": [{
		"name": "my_awesome_server",
		"pid": "/tmp/pids/server.pid"
	}],
	// monitor interval
	"interval": 30,
	// enable datadog statsd
	"datadog": true
}
```

MIT
