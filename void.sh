#!/bin/bash

# Install required packages
sudo xbps-install -y curl nano xrandr bluez bluez-alsa blueman vlc uget redshift

# Enable Bluetooth services
sudo ln -sf /etc/sv/bluetoothd /var/service/
sudo ln -sf /etc/sv/bluez-alsa /var/service/

# Set up pulseaudio service
sudo mkdir -p /etc/sv/pulseaudio
echo -e '#!/bin/bash\nexec /usr/bin/pulseaudio --start --log-target=syslog' | sudo tee /etc/sv/pulseaudio/run > /dev/null
sudo chmod +x /etc/sv/pulseaudio/run
sudo ln -sf /etc/sv/pulseaudio /var/service/

# Restore XFCE settings
tar xzvf xfce-settings-backup.tar.gz -C ~/
cp -f xfce-backup/*.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/
xfce4-panel --restart
