#!/bin/bash

# TODO: install directory
INSTALL_DIR="/data/xcelium/"


WORKING_DIR="/mnt/resource"
CADENCE_TOOLS_BLOB=$1
ISCAPE_FILE="IScape04.23-s012lnx86.t.Z"

cd ${WORKING_DIR}

install_required_packages()
{
        echo "----------------------installing required packages."
        apt-get update
        apt-get install -y install ksh
        apt-get install -y install mesa-libGLU
        apt-get install -y install motif
        apt-get install -y redhat-lsb
        apt-get install -y install glibc.i686
        apt-get install -y install elfutils-libelf.i686
        apt-get install -y install mesa-libGL.i686
        apt-get install -y install mesa-libGLU.i686
        apt-get install -y install motif.i686
        apt-get install -y install redhat-lsb.i686
        apt-get install -y install glibc-devel.i686
        apt-get install -y install libXScrnSaver.i686
        apt-get install -y install libXScrnSaver.x86_64
        apt-get install -y install java-1.8.0-openjdk
}

install_iscape()
{
        echo "----------------------installing IScape."
        wget ${CADENCE_TOOLS_BLOB}/${ISCAPE_FILE}
        zcat ${ISCAPE_FILE} | tar -xvf -
}

download_archive()
{
        echo "----------------------downloading archive."
        cd ${WORKING_DIR}
        wget ${CADENCE_TOOLS_BLOB}/XciliumArchive.tgz
        tar -xzvf XciliumArchive.tgz
}

install_from_archive()
{
        echo "---------------------installing from archive."
        cd ${WORKING_DIR}/iscape.04.23-s012/bin
        ./iscape.sh -batch majorAction=installfromarchive ArchiveDirectory=${WORKING_DIR}/XceliumArchive/ InstallDirectory=${INSTALL_DIR}

        # generate configuration scripts
        # no need configuration for xcelium?
        #sudo ./iscape.sh -batch majorAction=configure InstallDirectory=${INSTALL_DIR}

        # complete configuration
        #sudo /bin/sh /data/tempus/installData/SSV201_lnx86/batch_configure.sh
        # test
        ./iscape.sh -batch majorAction=test InstallDirectory=${INSTALL_DIR}
}

install_required_packages
install_iscape
download_archive
install_from_archive

echo "-----------------------DONE."
