#!/bin/sh

#cd $CI_WORKSPACE # change working directory to the root of your cloned repo.

# Fail this script if any subcommand fails.
set -e

# Navigate to the root of the cloned repo.
cd $CI_PRIMARY_REPOSITORY_PATH

# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 -b 3.19.5 $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios).
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Navigate to the `ios` directory.
cd ios

# Deintegrate CocoaPods and then reinstall dependencies to ensure compatibility.
pod deintegrate
pod install

exit 0