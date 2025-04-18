#!/bin/bash
clear

# Update
echo -e "\033[1;33m[+] Update Void..\033[0m"
sudo xbps-install -Su -y
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib -y

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
intel-video-accel
gnutls-32bit 
libvulkan-32bit 
libgcc-32bit 
libstdc++-32bit 
libdrm-32bit 
libglvnd-32bit
xtools
EOF

# Sync repos then install all packages at once
echo -e "\033[1;33m[+] Install required packages..\033[0m"
sudo xbps-install -S $PkgList

#echo "/usr/bin/pipewire &" >> .xinitrc
#echo "/usr/bin/pipewire-pulse &" >> .xinitrc
#echo "/usr/bin/wireplumber &" >> .xinitrc
#echo "while true; do" >> ~/.xinitrc
#echo "   dwm > /dev/null 2>&1" >> .xinitrc
#echo "done" >> ~/.xinitrc

echo -e "\033[1;33m[+] Enable Bluetooth services...\033[0m"
sudo rfkill unblock bluetooth
sudo ln -s /etc/sv/bluetoothd /var/service/

echo -e "\033[1;33m[+] Add bash completion source line to .bashrc...\033[0m"
echo "source /usr/share/bash-completion/bash_completion" >> .bashrc
source ~/.bashrc

echo -e "\033[1;33m[+] Restore XFCE settings...\033[0m"
sudo curl -L -o fonts.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/env-configs/xfce/emadadel/fonts.tar.gz
sleep 2
tar -xzvf fonts.tar.gz -C .local/share

echo -e "\033[1;33m[+] Restore XFCE settings...\033[0m"
sudo curl -L -o xfce4-config.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/env-configs/xfce/emadadel/xfce4-config.tar.gz
sleep 2
#tar -xzvf xfce4-config.tar.gz

echo -e "\033[1;33m[i] Do you want Gaming on Void\033[0m"
sudo xbps-install -S wine wine-32bit winetricks lutris gamemode gamescope 
echo -e "\033[1;33m[+] Done.\033[0m"

echo -e "\033[1;33m[i] Do you want install virt-manager\033[0m"
sudo xbps-install -S libvirt virt-manager virt-manager-tools qemu qemu-ga


echo -e "\033[1;33m[+] Done.\033[0m"
