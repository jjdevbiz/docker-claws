# Claws Mail - Docker Project #

The purpose of this project is to provide an ephemeral image for anonymous web
browsing.

# Build from Dockerfile #

```
docker build -t claws-mail .
docker run -d -p 55555:22 claws-mail
```

# Use a volume for persisent mail storage locally #

```
docker run -d -v /opt/docker-claws:/home/docker/.claws-mail -p 55555:22 claws-mail
```

## Start ##

*~/.ssh/config entry for easy ssh*
```
Host docker-claws
  User      docker
  Port      55555
  HostName  127.0.0.1
  RemoteForward 64713 localhost:4713
  ForwardX11 yes
```
*use a script or tmux line to start a session*
```
tmux new -s torbrowser -d "ssh docker-claws 'claws-mail'"
```

