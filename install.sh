#!/usr/bin/env bash

set -e

function print_info {
    echo -e "\e[1m\e[38;5;70m> $1\e[0m"
}

function print_error {
    echo -e "\e[1m\e[38;5;160m> ERROR: $1\e[0m"
}

function fail {
    print_error $1
    exit 1
}


if [ "$TYPST_LOCAL_PACKAGES" == "" ]; then
    fail "TYPST_LOCAL_PACKAGES is not defined/empty, stopping."
fi

# Strip any `-dev` that the version might contain, because Typst doesn't *actually* support
# Semver...
install_dir=$TYPST_LOCAL_PACKAGES/reading-group-theme/$(cat VERSION | cut -d '-' -f 1 )
print_info "Installing local Typst package at '$install_dir'..."

if [ -d $install_dir ]; then
    print_info "Directory '$install_dir' already exists. "
    read -p "Overwrite? [yY/nN]: " overwrite

    if [ "$overwrite" == "y" ] || [ "$overwrite" == "Y" ]; then
        rm -rf $install_dir/
    else
        print_info "Not overwriting existing directory."
        exit 0
    fi
fi

mkdir -p $install_dir/

print_info "Installing in offline mode (copying local files)..."
# Just copy local dir to destination.
cp -r . $install_dir
# Remove git stuff and the installer.
rm -rf $install_dir/{.git*,install.sh}

print_info "Done! Package is now in '$install_dir'."
