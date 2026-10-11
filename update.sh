#!/usr/bin/env bash
set -euo pipefail

REPO="hardbeat920/monocode"
CURRENT_VER=$(sed -n 's/^pkgver=//p' PKGBUILD | tr -d '[:space:]')
echo "Current pkgver: $CURRENT_VER"

# Get latest release tag
LATEST_TAG=$(curl -sSL "https://api.github.com/repos/${REPO}/releases/latest" | jq -r .tag_name)
BASE_VER="${LATEST_TAG#v}"

# Get compare info between release tag and main
COMPARE_JSON=$(curl -sSL "https://api.github.com/repos/${REPO}/compare/${LATEST_TAG}...main")
AHEAD_BY=$(echo "$COMPARE_JSON" | jq -r .ahead_by)
LATEST_SHA=$(curl -sSL "https://api.github.com/repos/${REPO}/commits/main" | jq -r '.sha[:7]')

if [ -z "$BASE_VER" ] || [ -z "$AHEAD_BY" ] || [ -z "$LATEST_SHA" ] || [ "$AHEAD_BY" = "null" ]; then
  echo "Error: failed to query GitHub API for repo comparison" >&2
  exit 1
fi

NEW_PKGVER="${BASE_VER}.r${AHEAD_BY}.g${LATEST_SHA}"
echo "Calculated pkgver: $NEW_PKGVER"

if [ "$CURRENT_VER" = "$NEW_PKGVER" ]; then
  echo "Already up to date."
  if [ -n "${GITHUB_ENV:-}" ]; then
    echo "UPDATED=false" >> "$GITHUB_ENV"
  fi
  exit 0
fi

echo "Updating monocode-git from $CURRENT_VER to $NEW_PKGVER..."

sed -i "s/^pkgver=.*/pkgver=${NEW_PKGVER}/" PKGBUILD
sed -i "s/^pkgrel=.*/pkgrel=1/" PKGBUILD

# Regenerate .SRCINFO
if command -v makepkg >/dev/null 2>&1; then
  makepkg --printsrcinfo > .SRCINFO
elif command -v docker >/dev/null 2>&1; then
  docker run --rm -v "$PWD":/pkg -w /pkg archlinux:base-devel bash -c \
    "useradd -m builder && chown -R builder . && su builder -c 'makepkg --printsrcinfo > .SRCINFO'"
fi

echo "Updated PKGBUILD and .SRCINFO to version $NEW_PKGVER"

if [ -n "${GITHUB_ENV:-}" ]; then
  echo "UPDATED=true" >> "$GITHUB_ENV"
  echo "NEW_VER=$NEW_PKGVER" >> "$GITHUB_ENV"
fi
