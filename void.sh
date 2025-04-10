#!/bin/bash
# Update
echo "Update Void.."
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib -y
sudo xbps-install -Su -y

echo "Install required packages.."
# Install required packages
sudo xbps-install -S -y nano xrandr bluez bluez-alsa blueman vlc uget redshift redshift-gtk kitty bash-completion pulseaudio

# Set up pulseaudio service
echo "Set up pulseaudio service..."
sudo mkdir -p /var/service/pulseaudio
sudo echo -e '#!/bin/bash\nexec /usr/bin/pulseaudio --start --log-target=syslog' | sudo tee /var/service/pulseaudio/run > /dev/null
sudo chmod +x /var/service/pulseaudio/run

# Enable Bluetooth services
echo "Enable Bluetooth services..."
rfkill unblock bluetooth
sudo ln -s /etc/sv/bluetoothd /var/service/
sudo ln -s /etc/sv/bluez-alsa /var/service/
sudo ln -s /etc/sv/alsa /var/service/
sudo ln -s /etc/sv/pulseaudio /var/service/
sudo sv restart bluetoothd
sudo sv start bluetoothd
sudo sv start pulseaudio
pulseaudio -k
pulseaudio --start

# Add bash completion source line to .bashrc
echo "Add bash completion source line to .bashrc..."
echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc
source ~/.bashrc

# Restore XFCE settings
echo "Restore XFCE settings..."
curl -L -o xfce-settings-backup.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/xfce-settings-backup.tar.gz
sleep 2
sudo tar xzvf xfce-settings-backup.tar.gz
sleep 1
sudo cp -f ~/xfce-perchannel-xml/*.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/

# Redshift Settings
echo "Applying redshift settings..."
sudo mkdir -p .config/redshift
sudo curl -s https://raw.githubusercontent.com/jonls/redshift/master/redshift.conf.sample -o .config/redshift/redshift.conf

# Screen Color Depth
echo "Screen Color Depth..."
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo curl -o /etc/X11/xorg.conf.d/10-monitor.conf https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/10-monitor.conf
