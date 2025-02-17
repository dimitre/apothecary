#!/bin/bash
set -e
set -o pipefail
# trap any script errors and exit
trap "trapError" ERR

trapError() {
	echo
	echo " ^ Received error ^"
	cat formula.log
	exit 1
}

installPackages(){
    sudo apt-get update -q
    sudo apt-get -y install multistrap unzip coreutils gperf 
    sudo apt-get -y install libasound-dev libjack-dev libpulse-dev oss4-dev #rtaudio
    sudo apt-get update && sudo apt-get install -y autoconf libtool automake
}

createRaspbianImg(){
    mkdir -p raspbian/etc/apt/apt.conf.d/
    echo 'Acquire::AllowInsecureRepositories "true";' | sudo tee raspbian/etc/apt/apt.conf.d/90insecure
    multistrap -a arm64 -d raspbian -f multistrap.conf
}

downloadToolchain(){
    wget https://github.com/openframeworks/openFrameworks/releases/download/tools/cross-gcc-10.3.0-pi_64.tar.gz
    tar xvf cross-gcc-10.3.0-pi_64.tar.gz
    mv cross-pi-gcc-10.3.0-64 rpi_toolchain
    rm cross-gcc-10.3.0-pi_64.tar.gz
}

downloadFirmware(){
    echo "no firmware"
    # wget -nv https://github.com/raspberrypi/firmware/archive/master.zip -O firmware.zip
    # unzip firmware.zip
    # cp -r firmware-master/opt raspbian/
    # rm -r firmware-master
    # rm firmware.zip
}

relativeSoftLinks(){
    for link in $(ls -la | grep "\-> /" | sed "s/.* \([^ ]*\) \-> \/\(.*\)/\1->\/\2/g"); do
        lib=$(echo $link | sed "s/\(.*\)\->\(.*\)/\1/g");
        link=$(echo $link | sed "s/\(.*\)\->\(.*\)/\2/g");
        rm $lib
        ln -s ../../..$link $lib
    done

    for f in *; do
        error=$(grep " \/lib/" $f > /dev/null 2>&1; echo $?)
        if [ $error -eq 0 ]; then
            sed -i "s/ \/lib/ ..\/..\/..\/lib/g" $f
            sed -i "s/ \/usr/ ..\/..\/..\/usr/g" $f
        fi
    done
}

# run install
ROOT=$( cd "$(dirname "$0")" ; pwd -P )
echo $ROOT
cd $ROOT
installPackages
createRaspbianImg
downloadToolchain
downloadFirmware

cp -rn rpi_toolchain/aarch64-linux-gnu/libc/lib/* $ROOT/raspbian/usr/lib/
cp -rn rpi_toolchain/aarch64-linux-gnu/libc/usr/lib/* $ROOT/raspbian/usr/lib/
cp -rn rpi_toolchain/aarch64-linux-gnu/lib/* $ROOT/raspbian/usr/lib/

cd $ROOT/raspbian/usr/lib
relativeSoftLinks
cd $ROOT/raspbian/usr/lib/aarch64-linux-gnu
relativeSoftLinks

sudo apt-get update && sudo apt-get install -y autoconf libtool automake dos2unix
sudo apt-get update && sudo apt-get install -y cmake

# CMAKE_VERSION=3.30.0
# wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-aarch64.sh
# chmod +x cmake-${CMAKE_VERSION}-linux-aarch64.sh
# sudo ./cmake-${CMAKE_VERSION}-linux-aarch64.sh --skip-license --prefix=/usr/local
# export PATH="/usr/local/bin:$PATH"

