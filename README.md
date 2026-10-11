# monocode-git

Unofficial PKGBUILD for `monocode-git`, compiling the latest development commit from source for [MonoCode](https://github.com/hardbeat920/monocode).

> **Note**: This package is not yet published to the official AUR (`aur.archlinux.org`) because new user registration on the AUR is currently closed due to a high volume of spam registrations. Once registration reopens, it will be uploaded to the AUR.

---

## Installation

### Prerequisites

Ensure you have `base-devel`, `git`, and build tools installed:

```bash
sudo pacman -S --needed base-devel git
```

`makepkg` will automatically pull build dependencies (`cargo`, `nodejs`, `npm`) and runtime dependencies (`gtk3`, `webkit2gtk-4.1`, etc.).

### Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/YoruAkio/monocode-git.git
   cd monocode-git
   ```

2. **(Optional) Inspect the PKGBUILD:**

   It is always good practice to inspect packaging scripts before building:

   ```bash
   less PKGBUILD
   ```

3. **Build and install:**

   Run `makepkg` with `-s` (install missing dependencies via pacman) and `-i` (install the resulting package):

   ```bash
   makepkg -si
   ```

   *Note: Compiling the Rust and frontend codebase can take several minutes depending on your CPU.*

---

## Updating

To pull the latest commits from upstream and rebuild:

```bash
cd monocode-git
git pull
makepkg -si
```

---

## Uninstallation

To remove the package from your system:

```bash
sudo pacman -R monocode-git
```

---

## Automated updates

A GitHub Actions workflow checks for new commits on upstream `main` every 3 hours and updates `pkgver` in `PKGBUILD` and `.SRCINFO`.
