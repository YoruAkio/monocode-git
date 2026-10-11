# Maintainer: yoruakio
pkgname=monocode-git
pkgver=0.12.0.r15.gab5dee1
pkgrel=1
pkgdesc="A GUI for your coding agents"
arch=('x86_64')
url="https://github.com/hardbeat920/monocode"
license=('MIT')
depends=(
  'glibc'
  'gtk3'
  'hicolor-icon-theme'
  'libayatana-appindicator'
  'openssl'
  'webkit2gtk-4.1'
)
makedepends=(
  'cargo'
  'git'
  'nodejs'
  'npm'
)
provides=('monocode')
conflicts=('monocode')
source=(
  "git+https://github.com/hardbeat920/monocode.git"
  "monocode.desktop"
)
sha256sums=(
  'SKIP'
  '2b82316d28c250bd2127b1afbb385451411e33004f0a3fd8a523e7aba3f41e8a'
)

pkgver() {
  cd monocode
  git describe --long --tags --abbrev=7 2>/dev/null | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g' ||
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
}

prepare() {
  cd monocode
  npm ci
}

build() {
  cd monocode
  npm run tauri -- build --no-bundle
}

package() {
  cd monocode
  if [ -f target/release/monocode ]; then
    install -Dm755 target/release/monocode "${pkgdir}/usr/bin/monocode"
  else
    install -Dm755 src-tauri/target/release/monocode "${pkgdir}/usr/bin/monocode"
  fi
  install -Dm644 "${srcdir}/monocode.desktop" "${pkgdir}/usr/share/applications/MonoCode.desktop"
  install -Dm644 src-tauri/icons/32x32.png "${pkgdir}/usr/share/icons/hicolor/32x32/apps/monocode.png"
  install -Dm644 src-tauri/icons/128x128.png "${pkgdir}/usr/share/icons/hicolor/128x128/apps/monocode.png"
  install -Dm644 src-tauri/icons/128x128@2x.png "${pkgdir}/usr/share/icons/hicolor/256x256/apps/monocode.png"
  install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}
