#!/bin/bash
set -e
set -x

die() {
    echo -e "\e[0;31m${@}\e[0m"
	exit 1
}

echo_purple() {
    echo -e "\e[0;35m${@}\e[0m"
}

echo_green() {
    echo -e "\e[0;32m${@}\e[0m"
}

echo_yellow() {
    echo -e "\e[0;93m${@}\e[0m"
}

script_cmdline () {
    local param
    for param in $(< /proc/cmdline); do
        case "${param}" in
            script=*) echo "${param#*=}" ; return 0 ;;
        esac
    done
}

{{range $key,$val := .servers}}
product_uuid[{{$key}}]='{{$val.product_uuid}}'
script_provisioning[{{$key}}]='{{$val.scriptProvisioning}}'

{{end}}

echo "product_uuid is '$(cat /sys/class/dmi/id/product_uuid)'"
for i in "${!product_uuid[@]}"; do
  if [ "${product_uuid[$i]}" == "$(cat /sys/class/dmi/id/product_uuid)" ]; then
      echo_purple "Found matching product_uuid"

      script=$(script_cmdline | sed  "s/provisioning.sh/${script_provisioning[$i]}/g")
      wget "${script}" --retry-connrefused -q -O /tmp/server_script >/dev/null || die "Failed to download script"

      chmod +x /tmp/server_script
      /tmp/server_script || die "provisioning script failed"
  fi
done


sync
#systemctl reboot

