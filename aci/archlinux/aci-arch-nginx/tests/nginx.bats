#!/dgr/bin/bats -x

@test "Nginx should be here" {
  run which nginx
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "/usr/sbin/nginx" ]
}

@test "Nginx config should be here" {
  [ -f "/etc/nginx/nginx.conf" ]
}

@test "Nginx should be running" {
  ps -aux
  run bash -c "ps -aux | grep nginx"
  [ "$status" -eq 0 ]
  echo ${lines[0]}
  [[ "${lines[0]}" =~ "/usr/sbin/nginx" ]]
}

@test "Nginx should listen on port: 80" {
  run bash -c "netstat -peanut | grep nginx"
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ ":80" ]]
  [[ "${lines[0]}" =~ "nginx" ]]
}

