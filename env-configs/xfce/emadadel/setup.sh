#!/bin/bash

Clear

# Update
echo "[+] Update Void.."
sudo xbps-install -Su -y
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib xtools -y

# Define packages clearly using a multi-line array-like format
read -r -d '' PkgList <<'EOF'
nano
xrandr
bluez
blueman
libspa-bluetooth
vlc
uget
redshift
redshift-gtk
kitty
bash-completion
freerdp
font-kacst
SDL2_ttf
unzip
unrar
git
neofetch
mesa-dri-32bit
mesa-vulkan-intel 
mesa-vulkan-intel-32bit 
vulkan-loader-32bit 
gnutls-32bit 
libvulkan-32bit 
libgcc-32bit 
libstdc++-32bit 
libdrm-32bit 
libglvnd-32bit
EOF

# Sync repos then install all packages at once
echo "[+] Install required packages.."
sudo xbps-install -S $PkgList

# Set up pipewire service
#echo "/usr/bin/pipewire &" >> .xinitrc
#echo "/usr/bin/pipewire-pulse &" >> .xinitrc
#echo "/usr/bin/wireplumber &" >> .xinitrc
#echo "while true; do" >> ~/.xinitrc
#echo "   dwm > /dev/null 2>&1" >> .xinitrc
#echo "done" >> ~/.xinitrc

# Enable Bluetooth services
#echo "[+] Enable Bluetooth services..."
#sudo rfkill unblock bluetooth
#sudo ln -s /etc/sv/bluetoothd /var/service/

# Add bash completion source line to .bashrc
#echo "[+] Add bash completion source line to .bashrc..."
#echo "source /usr/share/bash-completion/bash_completion" >> .bashrc
#source ~/.bashrc

# Installing fonts...
#echo "[+] Restore XFCE settings..."
#sudo curl -L -o fonts.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/env-configs/xfce/emadadel/fonts.tar.gz
#sleep 2
#tar -xzvf fonts.tar.gz -C .local/share

# Restore XFCE settings
#echo "[+] Restore XFCE settings..."
#sudo curl -L -o xfce4-config.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/env-configs/xfce/emadadel/xfce4-config.tar.gz
#sleep 2
#tar -xzvf xfce4-config.tar.gz

echo "[i] Do you want Gaming on Void"
sudo xbps-install -S wine wine-32bit winetricks lutris gamemode gamescope 
