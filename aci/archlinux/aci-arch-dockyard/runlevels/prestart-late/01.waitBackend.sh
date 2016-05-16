#!/dgr/bin/busybox sh

echo "[wait-proxy] Wait for redis to start"

max_sleep=60
sleep_interval=5
total_sleep=0

while true ; do
    echo "[wait-proxy] Waiting..."
    (/dgr/bin/busybox netstat -lataupen | grep ':6379') > /dev/null 2>&1 && break

    sleep ${sleep_interval}

    if [ ${total_sleep} -ge ${max_sleep} ]; then
        echo "[wait-redis] Max sleep has been reached"
        break
    fi

    total_sleep=$(($total_sleep + $sleep_interval))
done

mkdir -p /var/log /root/osserrlog /root/ossdata