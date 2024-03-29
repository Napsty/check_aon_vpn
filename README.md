# check_aon_vpn
Monitoring plugin to check status of Always On VPN services - to be run on a Windows server

## Defining the service in NSClient++
In your nsclient.ini (or another included ini file included in nsclient.ini) define the service (here `check_aon_vpn`) under the `[/settings/external_scripts/scripts]` section:

```
[/settings/external scripts/scripts]
check_aon_vpn = cmd /c echo scripts\check_aon_vpn.ps1; exit($lastexitcode) | powershell.exe -command -
```

And place the script itself into `NSCLIENT_PATH\scripts`, e.g. `C:\Program Files\NSclient++\scripts`.

## Running the plugin from remote using check_nrpe
The defined NRPE command `check_aon_vpn` can now be remotely executed with `check_nrpe`:

```
$ /usr/lib/nagios/plugins/check_nrpe -H aonserver -c check_aon_vpn
Always On VPN OK - All Services OK (Server Vpn Addressing Vpn Connectivity Services)
```

