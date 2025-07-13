# BogoHTTP

A bogus HTTP server.

# Version Upgrade Demo

podman run -p 8080:8080 --name bogo2 quay.io/dwinchell_redhat/bogohttp:v1.0.amd64

# In another terminal
podman rm -f bogo

podman run -p 8080:8080 --name bogo2 quay.io/dwinchell_redhat/bogohttp:v2.0.amd64

# Contributing

podman build -t quay.io/dwinchell_redhat/bogohttp:v2.0.amd64 .
podman push quay.io/dwinchell_redhat/bogohttp:v2.0.amd64

