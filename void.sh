#!/bin/bash

# Update
echo "Update Void.."
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib -y
sudo xbps-install -Su -y

# Install required packages
echo "Install required packages.."
sudo xbps-install -S -y nano xrandr bluez blueman libspa-bluetooth vlc uget redshift redshift-gtk kitty bash-completion telegram-desktop freerdp

# Set up pipewire service
#echo "/usr/bin/pipewire &" >> .xinitrc
#echo "/usr/bin/pipewire-pulse &" >> .xinitrc
#echo "/usr/bin/wireplumber &" >> .xinitrc
#echo "while true; do" >> ~/.xinitrc
#echo "   dwm > /dev/null 2>&1" >> .xinitrc
#echo "done" >> ~/.xinitrc

# Enable Bluetooth services
echo "Enable Bluetooth services..."
sudo rfkill unblock bluetooth
sudo ln -s /etc/sv/bluetoothd /var/service/

# Add bash completion source line to .bashrc
echo "Add bash completion source line to .bashrc..."
echo "source /usr/share/bash-completion/bash_completion" >> .bashrc
source ~/.bashrc

# Restore XFCE settings
echo "Restore XFCE settings..."
sudo curl -L -o xfce4-config.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/xfce4-config.tar.gz
sleep 2
tar -xzvf xfce4-config.tar.gz

# Redshift Settings
echo "Applying redshift settings..."
sudo mkdir -p .config/redshift
sudo curl -s https://raw.githubusercontent.com/jonls/redshift/master/redshift.conf.sample -o .config/redshift/redshift.conf

# Screen Color Depth
echo "Screen Color Depth..."
echo 'xrandr --output HDMI-1 --set "Broadcast RGB" "Full"' >> .xprofile

# Terminal Settings
echo "Kitty settings..."
sudo mkdir -p .config/kitty
sudo curl -o .config/kitty/kitty.conf https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/kitty.conf
sudo curl -o .config/kitty/VibrantInk.conf https://raw.githubusercontent.com/kovidgoyal/kitty-themes/refs/heads/master/themes/VibrantInk.conf
