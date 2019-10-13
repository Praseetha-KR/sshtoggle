<div align="center">
    <img src="sshtoggle/sshtogglepreferences/Resources/icon@3x.png" alt="logo" width="75px" height="75px" style="margin-top: 1em">
    <h1>sshtoggle</h1>
    <h4>A MobileSubstrate tweak to start/stop SSH daemon</h4>
</div>


### Cydia Dependencies
1. PreferenceLoader
2. Sudo


### Install

[sshtoggle](https://cgvi.github.io/cydia-repo/depiction/in.imagineer.sshtoggle/) package is available in Cydia via [CGVI repo](https://cgvi.github.io/cydia-repo).

Once installed, SSH Toggle settings will appear in iOS Settings. You can turn OFF/ON the SSH service.

| Settings  | SSH toggle |
|-----------|------------|
| ![Settings](screenshots/settings.png) | ![Settings](screenshots/settings_sshtoggle.png) |

---

### Development Setup:

#### Tools:
- [theos](https://github.com/theos/theos/wiki/Installation)

#### Initial Setup:

```
sudo ./scripts/setup.sh
```
> Setup script installs [fauxsu](https://github.com/DHowett/fauxsu) inside theos directory, this is equired to set ownership of generated `.deb` files from system user to `root:wheel`

#### build & install:

```
export THEOS_DEVICE_IP=<ip> 

./scripts/install.sh
```
