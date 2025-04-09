#!/bin/bash
sudo xbps-install nano xrandr bluez bluez-alsa blueman vlc uget telegram-desktop -y
sudo ln -s /etc/sv/bluetoothd  /var/service/
sudo ln -s /etc/sv/bluez-alsa  /var/service/
sudo mkdir -p /etc/sv/pulseaudio
echo -e '#!/bin/bash\nexec /usr/bin/pulseaudio --start --log-target=syslog' | sudo tee /etc/sv/pulseaudio/run
sudo chmod +x /etc/sv/pulseaudio/run
sudo ln -s /etc/sv/pulseaudio /var/service/
