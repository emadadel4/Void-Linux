### 🚀 Void Linux XFCE - Restore Settings After Reinstallation

1️⃣ unzip
```bash
tar xzvf xfce-settings-backup.tar.gz -C ~/
xfce4-panel --restar
```


2️⃣ Restore Desktop, Panel, and Keyboard Shortcuts

```bash
cp ~/xfce-backup/*.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/
xfce4-panel --restart
```

3️⃣ Restore Installed Packages

```bash
xbps-install -S $(cat installed-packages.txt)
```

🎯 Notes
After running these commands, you may need to log out and log back in for changes to take effect.
