# satisfactory-server
Docker container for a basic Satisfactory Server

Build to create a containerized version of the dedicated server for Satisfactory
https://www.satisfactorygame.com/
 
 
Build by hand
```
git clone https://github.com/antimodes201/satisfactory-server.git
docker build -t antimodes201/satisfactory-server:latest .
``` 
 
Docker Pull
```
docker pull antimodes201/satisfactory-server
```
 
Docker Run with defaults 
change the volume options to a directory on your node and maybe use a different name then the one in the example
 
```
docker run -it -p 7777:7777/udp -p 15777:15777/udp -p 15000:15000/udp -v /app/docker/temp-vol:/satisfactory \
--name satisfactory \
antimodes201/satisfactory-server:latest
```
 
If you would like to use a different query and game port utilize the GAME_PORT and QUERY_PORT settings.
Note: At this time the BeaconPort(15000) cannot be changed.
```
docker run -it -p 7000:7000/udp -p 8000:8000/udp -p 15000:15000/udp -v /app/docker/temp-vol:/satisfactory \
-e GAME_PORT="7000" \
-e QUERY_PORT="8000" \
--name satisfactory \
antimodes201/satisfactory-server:latest
```
 
You will need to mount /satisfactory as a persistent volume.  This will contain the application data, steamcmd, save data, and configurations.
 
Currently exposed environmental variables and their default values
- GAME_PORT 7777
- QUERY_PORT 15777
- BEACON_PORT 15000
- TZ America/New_York
