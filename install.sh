#!/bin/bash

# Get the synthesia installer.
curl -o synthesia_installer.exe https://www.synthesiagame.com/get?platform=win
wine synthesia_installer.exe
read -p "Press Enter once the installation has succeeded"

# Create the .desktop
mkdir -p $HOME/.local/bin/
# Persist ~/.local/bin in PATH if not already there
if ! grep -q '.local/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.bashrc"
fi
cat <<EOF >$HOME/.local/bin/synthesia
#!/bin/bash
zenity --info --text="Opening Synthesia with Wine."

# Opens Synthesia
cd "$HOME/.wine/drive_c/Program Files (x86)/Synthesia/"
exec wine "$HOME/.wine/drive_c/Program Files (x86)/Synthesia/Synthesia.exe" "$@"
EOF

chmod +x $HOME/.local/bin/synthesia

mkdir -p ~/.local/share/icons/
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/synthesia.png" "$HOME/.local/share/icons/synthesia.png"
mkdir -p ~/.local/share/applications/
cat <<EOF >$HOME/.local/share/applications/synthesia.desktop
[Desktop Entry]
Name=Synthesia
Comment=Piano learning game
Exec=synthesia
Icon=$HOME/.local/share/icons/synthesia.png
Type=Application
Categories=Game;Music;Education;
StartupWMClass=synthesia.exe
Terminal=false
EOF

update-desktop-database ~/.local/share/applications/
