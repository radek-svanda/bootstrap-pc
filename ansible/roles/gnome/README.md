```
$ update-alternatives --get-selections | grep plymouth
default.plymouth               auto     /usr/share/plymouth/themes/ubuntu-gnome-logo/ubuntu-gnome-logo.plymouth
text.plymouth                  auto     /usr/share/plymouth/themes/ubuntu-gnome-text/ubuntu-gnome-text.plymouth

$ cat /etc/default/grub | grep LINUX_DEFAULT
GRUB_CMDLINE_LINUX_DEFAULT="text mem_sleep_default=deep"
#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```
