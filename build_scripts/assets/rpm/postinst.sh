#!/usr/bin/env bash
# Post install script for the UI .rpm to place symlinks in places to allow the CLI to work similarly in both versions

set -e

ln -s /usr/lib/maize-blockchain/resources/app.asar.unpacked/daemon/maize /usr/bin/maize || true
ln -s /usr/lib/maize-blockchain/resources/app.asar.unpacked/daemon /opt/maize || true
