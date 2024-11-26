# VPN

## PIA

1. Go to https://www.privateinternetaccess.com/account/ovpn-config-generator
2. Select "Linux" as the platform and then the region you want to connect to
3. Download the config file
4. Move it to `/etc/vpn/pia-<region>.ovpn`
5. Create a file `/etc/vpn/auth-pia.txt` with your username on the first line and your password on the second line
6. Add the following to `/etc/vpn/pia-<region>.ovpn`:
```
auth-user-pass /etc/vpn/auth-pia.txt
auth-nocache
```
7. Remove all the `<crl-verify>` part
8. Run `sudo chown root:root /etc/vpn/*` and `sudo chmod 600 /etc/vpn/*`
9. Add the following to `nixos/system/modules/services/openvpn/default.nix` in the `servers` attribute set:
```nix
pia-<region> = {
    config = ''  config /etc/vpn/pia-region.ovpn '';
    autoStart = false;
    updateResolvConf = false;
};
```