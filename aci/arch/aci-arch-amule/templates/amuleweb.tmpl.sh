#!/usr/bin/expect -f
spawn amuleweb
expect "Enter password for mule connection:"
send "{{.amule.server.password}}\r"
interact
