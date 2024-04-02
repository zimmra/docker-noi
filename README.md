# Work-In-Progress
## Use at Your Own Risk

Can be found at https://hub.docker.com/r/pzubuntu593/docker-noi

Based off LSIO's implementation of (KasmVNC w/ Audacity)[https://github.com/linuxserver/docker-audacity]


## Docker Compose Example
```yaml
---
version: "2.1"
services:
  freecad:
    image: pzubuntu593/docker-noi:latest
    container_name: Noi
    privileged: true
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
      - TITLE=Noi
    volumes:
      - /media/docker/configs/noi:/config
    devices:
      - /dev/dri:/dev/dri 
    ports:
      - 3000:3000
    restart: unless-stopped
```

Also can be used seamlessly with Kasm Workspaces due to using the kasm-vnc base image
