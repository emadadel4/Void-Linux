#!/bin/bash

# Update
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib -y
xbps-install -Su -y

# Install required packages
sudo xbps-install -S -y nano xrandr bluez bluez-alsa blueman vlc uget redshift redshift-gtk kitty bash-completion

# Enable Bluetooth services
sudo ln -sf /etc/sv/bluetoothd /var/service/
sudo ln -sf /etc/sv/bluez-alsa /var/service/
sudo ln -sf /etc/sv/alsa /var/service/


# Set up pulseaudio service
sudo mkdir -p /etc/sv/pulseaudio
echo -e '#!/bin/bash\nexec /usr/bin/pulseaudio --start --log-target=syslog' | sudo tee /etc/sv/pulseaudio/run > /dev/null
sudo chmod +x /etc/sv/pulseaudio/run
sudo ln -sf /etc/sv/pulseaudio /var/service/

# Add bash completion source line to .bashrc
echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc
source ~/.bashrc

# Restore XFCE settings
tar xzvf xfce-settings-backup.tar.gz -C ~/
cp -f xfce-backup/*.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/
xfce4-panel --restart

# Redshift Settings
mkdir -p ~/.config/redshift
touch ~/.config/redshift/redshift.conf
nano ~/.config/redshift/redshift.conf
curl -s https://raw.githubusercontent.com/jonls/redshift/master/redshift.conf.sample -o ~/.config/redshift/redshift.conf

# Terminal Settings
curl -o ~/.config/kitty/kitty.conf https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/kitty.conf
curl -o /etc/X11/xorg.conf.d/10-monitor.conf  https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/10-monitor.conf
