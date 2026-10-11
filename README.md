# monocode-git

PKGBUILD for `monocode-git` (building latest master from source for [MonoCode](https://github.com/hardbeat920/monocode)).

> **Note**: This package is not yet published to the official AUR (`aur.archlinux.org`) because new user registration on the AUR is currently closed due to a high volume of spam registrations. Once registration reopens, it will be uploaded to AUR.

## Installation

Clone this repository and build with `makepkg`:

```bash
git clone https://github.com/YoruAkio/monocode-git.git
cd monocode-git
makepkg -si
```

## Automatic updates

A GitHub Actions workflow checks for new commits and tags on upstream `main` every 3 hours and updates `pkgver` in `PKGBUILD` and `.SRCINFO`.
