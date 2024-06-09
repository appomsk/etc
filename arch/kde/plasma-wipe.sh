#!/bin/bash

#!/usr/bin/env bash
#
#  orginal script by https://github.com/nwvh/PlasmaWiper 
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.#
#
# mogrified for Manjaro by @linux-aarhus
#
# don't run as root
if [[ $(whoami) == "root" ]] ; then
    echo "This script is not for root account"
    exit 1
fi

echo
echo "!----------------------------------------------------------------!"
echo ":: This script will wipe ALL your Plasma settings"
echo ":: You cannot undo without having a backup..."
echo "!----------------------------------------------------------------!"

read -p "Press ENTER to wipe Plasma settings (Ctrl+c to cancel)"

cd ~/
rm -rf .kde 
cd ~/.cache
rm -rf plasmashell* org.kde.dirmodel-qml.kcache kioexec krunner ksycoca5* krunnerbookmarkrunnerfirefoxdbfile.sqlite
cd ~/.local
rm -rf kate/ kded5/ klipper/ knewstuff3/ kscreen/ konsole/ kwalletd/ ksysguard/ kmail2/ kcookiejar/ kactivitymanagerd/
cd ~/.local/share
rm -rf dolphin kate kcookiejar kded5 keyrings klipper kmail2 knewstuff3 konsole kscreen ksysguard kwalletd kxmlgui5 plasma_engine_comic plasma plasma_notes org.kde.gwenview
cd ~/.config
rm -f plasma*
rm -rf kde* akonadi* KDE kconf_updaterc baloo* dolphinrc drkonqirc gwenviewrc kmail2rc k*rc katemetainfos plasma-workspace
echo "Done!"
echo
echo "!----------------------------------------------------------------!"
echo ":: Restore Manjaro Default User Settings"
echo "!----------------------------------------------------------------!"

read -p "Press ENTER to restore Manjaro Default (Ctrl+c to cancel)"

cp /etc/skel/. -r /home/$USER
echo "Done!"
echo

read -p "Press ENTER to restart (Ctrl+c to cancel)"

secs=$((5))
while [ $secs -gt 0 ]; do
   echo -ne "Awaiting restart ... $secs\033[0K\r"
   sleep 1
   : $((secs--))
done

systemctl soft-reboot
