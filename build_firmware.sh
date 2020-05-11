#
# NOTICE: This script is *NOT* designed to be used in a standalone fashion.
# It is designed to be used as part of an Appveyor build, and only works if the
# preliminaries from the appveyor.yml 'install' section have been run first.
#
make -C edk2/BaseTools || exit 1
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
export WORKSPACE=$PWD
export PACKAGES_PATH=$WORKSPACE/edk2:$WORKSPACE/edk2-platforms:$WORKSPACE/edk2-non-osi
source edk2/edksetup.sh || exit 1
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi3/RPi3.dsc -b DEBUG -D SECURE_BOOT_ENABLE=TRUE -D INCLUDE_TFTP_COMMAND=TRUE --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi3" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME (DEBUG)" || exit 1
build -a AARCH64 -t GCC5 -p edk2-platforms/Platform/RaspberryPi/RPi3/RPi3.dsc -b RELEASE -D SECURE_BOOT_ENABLE=TRUE -D INCLUDE_TFTP_COMMAND=TRUE --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"https://github.com/pftf/RPi3" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"UEFI Firmware $APPVEYOR_REPO_TAG_NAME" || exit 1
