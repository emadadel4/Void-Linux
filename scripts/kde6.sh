echo "Installing KDE environment..." 

sudo xbps-install -S kde-plasma dolphin NetworkManager bluez blueman libspa-bluetooth pipewire wireplumber pavucontrol ffmpeg ffmpegthumbnailer kdegraphics-thumbnailers

echo "[+] Enabling essential services..."
sudo rfkill unblock bluetooth
sudo ln -sf /etc/sv/NetworkManager /var/service
sudo ln -sf /etc/sv/dbus /var/service
sudo ln -sf /etc/sv/pipewire /var/service
sudo ln -sf /etc/sv/wireplumber /var/service
sudo ln -sf /etc/sv/bluetoothd /var/service
sudo ln -sf /etc/sv/sddm /var/service
sudo ln -s /usr/share/applications/pipewire-pulse.desktop /etc/xdg/autostart/pipewire-pulse.desktop
#echo "rebooting..."
#sudo reboot
