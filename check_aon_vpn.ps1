###########################################################################
# Script:    check_aon_vpn.ps1
# Author:    Claudio Kuenzler (www.claudiokuenzler.com)
# Purpose:   Monitor Always On VPN (Remote Access) services on a local 
#            Windows machine, to be executed from remote using NSclient+ 
#            or other remote execution agents
# License:   GPLv2
# GNU General Public Licence (GPL) http://www.gnu.org/
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <https://www.gnu.org/licenses/>
#
# Copyright 2020 Claudio Kuenzler
# Copyright 2020 Remo Cortellucci
#
# History:
# 20200506: Created script
###########################################################################
$Services = @('Server','Vpn Addressing','Vpn Connectivity','Services')
$checkstatus=0
$checkfails=@()

foreach ($Service in $Services) {
    $status = Get-RemoteAccessHealth | Where-Object {$_.Component -eq "$Service"} | Select HealthState
    $status = $status -replace "@{HealthState=(\w*)}",'$1'
    #"$Service is $status" # for debugging
    if ($status -ne "OK") {
      $checkstatus++
      $checkfails += $Service
    }
}

if ($checkstatus -gt 0) {
  "Always On VPN CRITICAL - The following $checkstatus services are NOT OK: $checkfails"
  exit 2
} else {
  "Always On VPN OK - All Services OK ($Services)"
  exit 0
}

"Script should not reach this part. Something went wrong."
exit 3
