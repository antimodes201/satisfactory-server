#!/bin/bash -ex
# Start script for Satisfactory called from docker

build=${BRANCH}


# Move steamcmd install to startup
if [ ! -f /satisfactory/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /satisfactory/steamcmd/
	cd /satisfactory/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi
	
# Fix steamclient check
mkdir -p /home/steamuser/.steam/sdk64
ln -s /satisfactory/steamcmd/linux64/steamclient.so /home/steamuser/.steam/sdk64/steamclient.so

#check if master
if [ ${BRANCH} == "public" ]
then
	/satisfactory/steamcmd/steamcmd.sh +force_install_dir /satisfactory+login anonymous  +app_update 1690800  +quit
else
	# Expermental 
	/satisfactory/steamcmd/steamcmd.sh +force_install_dir /satisfactory +login anonymous +app_update 1690800 -beta ${BRANCH} +quit
fi

if [ ! -d /satisfactory/saves ]
then
	mkdir /satisfactory/saves
fi

mkdir -p /home/steamuser/.config
ln -sf /satisfactory/saves /home/steamuser/.config/Epic


# Launch Server
# Variables pulled from Docker environment
cd /satisfactory
./FactoryServer.sh -ServerQueryPort=${QUERY_PORT} -BeaconPort=${BEACON_PORT} -Port=${GAME_PORT}