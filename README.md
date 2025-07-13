# BogoHTTP

A bogus HTTP server.

# PowerPC

```
```

# Version Upgrade Demo

```
podman run -p 8080:8080 --name bogohttp quay.io/dwinchell_redhat/bogohttp:v1.0.amd64

# In another terminal
podman rm -f bogohttp

podman run -p 8080:8080 --name bogohttp quay.io/dwinchell_redhat/bogohttp:v2.0.amd64
```

# Contributing

```
# x86
podman build -t quay.io/dwinchell_redhat/bogohttp:v2.0.amd64 .
podman push quay.io/dwinchell_redhat/bogohttp:v2.0.amd64

# Power Cross-Compile
podman build --platform linux/ppc64le -t quay.io/dwinchell_redhat/bogohttp:v2.0.ppcle64 .
podman push quay.io/dwinchell_redhat/bogohttp:v2.0.ppcle64
```

