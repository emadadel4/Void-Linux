#!/bin/bash

# Update
echo "Update Void.."
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib -y
sudo xbps-install -Su -y

echo "Install required packages.."
# Install required packages
sudo xbps-install -S -y nano xrandr bluez bluez-alsa blueman vlc uget redshift redshift-gtk kitty bash-completion pulseaudio

# Set up pulseaudio service
# echo "Set up pulseaudio service..."
# sudo mkdir -p /etc/sv/pulseaudio
# sudo echo -e '#!/bin/bash\exec /usr/bin/pulseaudio --daemonize --log-target=syslog' | sudo tee /etc/sv/pulseaudio/run > /dev/null
# sudo chmod +x /etc/sv/pulseaudio/run

# Enable Bluetooth services
echo "Enable Bluetooth services..."
rfkill unblock bluetooth
sudo ln -s /etc/sv/bluetoothd /var/service/
sudo ln -s /etc/sv/bluez-alsa /var/service/
sudo ln -s /etc/sv/alsa /var/service/
sudo ln -s /etc/sv/pulseaudio /var/service/
curl -L -o xfce-settings-backup.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/.main.conf
sleep 2
sudo cp -f .main.conf /etc/bluetooth/
sleep 2
sudo sv start bluetoothd
sudo sv start pulseaudio

# Add bash completion source line to .bashrc
echo "Add bash completion source line to .bashrc..."
echo "source /usr/share/bash-completion/bash_completion" >> .bashrc
source ~/.bashrc

# Restore XFCE settings
echo "Restore XFCE settings..."
curl -L -o xfce-settings-backup.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/xfce4-config.tar.gz
sleep 2
sudo tar -xzvf xfce4-config.tar.gz .config/

# Redshift Settings
echo "Applying redshift settings..."
sudo mkdir -p .config/redshift
sudo curl -s https://raw.githubusercontent.com/jonls/redshift/master/redshift.conf.sample -o .config/redshift/redshift.conf

# Screen Color Depth
echo "Screen Color Depth..."
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo curl -o /etc/X11/xorg.conf.d/10-monitor.conf https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/10-monitor.conf
