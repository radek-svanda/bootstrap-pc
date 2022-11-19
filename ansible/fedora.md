# Toolbox

## Android

- adb
- scrcpy
  ```
  sudo dnf copr enable zeno/scrcpy
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install scrcpy mesa-drivers
  ```