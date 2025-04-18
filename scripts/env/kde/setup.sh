echo -e "\033[33mInstalling KDE environment...\033[0m"

# Define packages clearly using a multi-line array-like format
read -r -d '' PkgList <<'EOF'
kde-plasma
dolphin 
NetworkManager 
bluez 
blueman 
libspa-bluetooth 
pipewire wireplumber 
pavucontrol 
ffmpeg 
ffmpegthumbnailer 
kdegraphics-thumbnailers
EOF

sudo xbps-install -S $PkgList

echo "[+] Enabling essential services..."
sudo rfkill unblock bluetooth
sudo ln -sf /etc/sv/NetworkManager /var/service
sudo ln -sf /etc/sv/dbus /var/service
sudo ln -sf /etc/sv/pipewire /var/service
sudo ln -sf /etc/sv/wireplumber /var/service
udo ln -sf /etc/sv/bluetoothd /var/service
sudo ln -sf /etc/sv/sddm /var/service
sudo ln -s /usr/share/applications/pipewire-pulse.desktop /etc/xdg/autostart/pipewire-pulse.desktop
echo -e "\033[33mDone.\033[0m"
