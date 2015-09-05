# docker armhf plex

This is a Dockerfile to run plex on a an arm based server.
This has been tested on https://www.scaleway.com .

## Instructions

```
docker run -d \
    --name plex \
    --restart always \
    -p 32400:32400 \
    -h *your_host_name* \
    -v <your_plex_config_location>:/config \
    -v <your_medias_location>:/media \
    adrienbrault/armhf-plex
```

Once the container has started and plex has created the Preferences.xml file, allow your ip to configure the plex
server:

```
sed -i -e 's#<Preferences MachineIdentifier#<Preferences allowedNetworks="<your_ip_address>/255.255.255.255" ManualPortMappingMode="1" MachineIdentifier#g' <your_config_location>/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml
```

Note that I've had to restart the container after linking my plex account to the server to get Remote Access to work. 

Also see https://github.com/timhaak/docker-plex
