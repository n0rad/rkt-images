#!/usr/bin/expect -f
spawn amuled --ec-config -c /config
expect "Enter password for mule connection:"
send "{{.amule.server.password}}\r"
interact
