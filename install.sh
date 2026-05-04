#!/bin/bash

# Get the synthesia installer.
curl -O synthesia_installer.exe https://www.synthesiagame.com/get?platform=win
wine synthesia_installer.exe
read -p "Press Enter once the installation has succeeded"

# Once Synthesia is installed, I go to the installation
cd $HOME/.wine/drive_c/Program Files (x86)/Synthesia/
wine $HOME/.wine/drive_c/Program Files (x86)/Synthesia/Synthesia.exe

# Opens Synthesia and meanwhile I create the .desktop
mkdir -p $HOME/.local/bin/
export PATH="$HOME/.local/bin:$PATH"
cat << EOF > $HOME/.local/bin/synthesia
#!/bin/bash

zenity --info --text="Opening Synthesia with Wine."

# Opens Synthesia
cd "$HOME/.wine/drive_c/Program Files (x86)/Synthesia/"
exec wine "$HOME/.wine/drive_c/Program Files (x86)/Synthesia/Synthesia.exe" "$@"
EOF

cp $HOME/synthesia-installer-linux/synthesia.png $HOME/.local/share

mkdir -p ~/.local/share/applications/
cat << EOF > $HOME/.local/share/applications/
[Desktop Entry]
Name=Synthesia
Comment=Piano learning game
Exec=synthesia
Icon=$HOME/.local/share/synthesia.png
Type=Application
Categories=Game;Music;Education;
StartupWMClass=synthesia.exe
Terminal=false
EOF

