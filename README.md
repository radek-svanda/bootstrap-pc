# Bootstraping computer

Repository contains optionated PC configuration.

## Available environments

* [Ubuntu](doc/Ubuntu)
* Windows (TBA)

## TODO

* https://github.com/asdf-vm/asdf
* open snap app links in proper browser group https://askubuntu.com/a/1209485

```
~/.config/Code/User
$ cat settings.json
{
    "sync.gist": "aa"
}

~/.config/Code/User
$ cat syncLocalSettings.json
{
    "ignoreUploadFiles": [
        "state.*",
        "syncLocalSettings.json",
        ".DS_Store",
        "sync.lock",
        "projects.json",
        "projects_cache_vscode.json",
        "projects_cache_git.json",
        "projects_cache_svn.json",
        "gpm_projects.json",
        "gpm-recentItems.json"
    ],
    "ignoreUploadFolders": [
        "workspaceStorage"
    ],
    "ignoreExtensions": [],
    "gistDescription": "Visual Studio Code Settings Sync Gist",
    "version": 343,
    "token": "aa",
    "downloadPublicGist": false,
    "supportedFileExtensions": [
        "json",
        "code-snippets"
    ],
    "openTokenLink": true,
    "disableUpdateMessage": false,
    "lastUpload": null,
    "lastDownload": null,
    "githubEnterpriseUrl": null,
    "askGistDescription": false,
    "customFiles": {},
    "hostName": null,
    "universalKeybindings": false,
    "autoUploadDelay": 20
}
```

Apps

## Disable fingerprint reader on linux

I had the same problem. I think I have it solved by blacklisting the usb device. First run lsusb to find the ID of the device. For XPS 9570 I think the ID of the fingerprint reader is 27c6:5395. Then create a file in /etc/udev/rules.d and put the following text inside

    # Disable fingerprint reader

    SUBSYSTEM=="usb", ATTRS{idVendor}=="27c6", ATTRS{idProduct}=="5395", ATTR{authorized}="0"

Save and reboot. After reboot PowerTOP should display 0.0% on Goodix Fingerprint Device.

I did this on Ubuntu 18.04, I hope the same applies for your kubuntu.

Cheers.

https://www.reddit.com/r/Dell/comments/alwour/xps_9570_disabling_fingerprint_reader_in_linux/?utm_medium=android_app&utm_source=share

## Windows

https://github.com/WillBixler/TwinUI-Fix/blob/master/Reinstall%20Preinstalled%20Apps.ps1
