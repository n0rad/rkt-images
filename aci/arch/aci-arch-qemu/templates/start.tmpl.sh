#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

lsmod | grep '\<kvm\>' > /dev/null || {
  echo >&2 "KVM module not loaded; software emulation will be used"
  exit 1
}

if [ ! -c /dev/kvm ]; then
    mknod /dev/kvm c 10 $(grep '\<kvm\>' /proc/misc | cut -f 1 -d' ') || {
      echo >&2 "Unable to make /dev/kvm node"
      exit 1
    }
fi

dd if=/dev/kvm count=0 2>/dev/null || {
  echo >&2 "Unable to open /dev/kvm"
}

{{- range .vm.drives -}}
if [ ! -f {{.file}} ]; then
    echo_green "Creating vm drive"
    dd if=/dev/zero of={{.file}} bs=1M count={{.sizeInGb}}000
fi
{{- end -}}

echo_green "Starting vm"
qemu-system-x86_64 \
  -boot order={{.vm.boot}} \
  -name vm \
  -m {{.vm.mem}} \
  -machine pc-i440fx-2.1,accel=kvm,usb=off \
  -smp {{.vm.cores}} \
  -realtime mlock=off \
  -rtc base=utc \
  -vga cirrus \
  -nographic \
  -vnc {{.vm.vnc}} \
  -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
  -device usb-tablet,id=input0 \
{{- if .vm.cdrom -}}
  -cdrom {{.vm.cdrom}} \
{{- end -}}
{{- range .vm.drives -}}
  -drive file={{.file}},if=virtio,format={{.type}},cache=none,aio=native \
{{- end -}}
{{- range .vm.nets -}}
  -net nic,model=virtio -net {{.type}},br={{.name}} \
{{- end -}}
  -k fr
