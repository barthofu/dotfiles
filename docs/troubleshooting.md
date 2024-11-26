# Troubelshooting

## Bluetooth

If you are having trouble connecting a device, try the following in the terminal:

```bash
bluetoothctl
```

and then type the following commands in the bluetoothctl prompt:

```bash
power on
# make sure your device is in pairing mode
scan on
# grab the MAC address of the device you want to connect to
disconnect <MAC_ADDRESS>
untrust <MAC_ADDRESS>
remove <MAC_ADDRESS>
scan off
power off
power on
scan on
connect <MAC_ADDRESS>
trust <MAC_ADDRESS>
```
