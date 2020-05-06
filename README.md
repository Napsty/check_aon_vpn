# check_aon_vpn
Monitoring plugin to check status of Always On VPN services - to be run on a Windows server

## Defining the service in NSClient++
In your nsclient.ini (or another included ini file included in nsclient.ini) define the service (here `check_aon_vpn`) under the `[/settings/external_scripts/scripts] section:

```
[/settings/external scripts/scripts]
check_aon_vpn=scripts\\check_aon_vpn.ps1
```

And place the script itself into `NSCLIENT_PATH\scripts`, e.g. `C:\Program Files\NSclient++\scripts`.
