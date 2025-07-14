# BogoHTTP

A bogus HTTP server.

# OpenShift on PowerPC - Zero Downtime Demo

To install:

```
oc new-project demo
oc create -f openshift_powerpc_zero_downtime_demo.yaml
echo -n '***** Now Browse to: http://' && oc get route bogohttp -o jsonpath --template='{.status.ingress[].host}' && echo '/ *****'
```

When ready to upgrade to version 2.0:

```
oc patch deployment/bogohttp --patch '{"spec": {"template": {"spec": {"containers": [{"name": "bogohttp", "image": "quay.io/dwinchell_redhat/bogohttp:v2.0.ppcle64"}]}}}}'

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
# amd64
podman build --platform linux/amd64 -t quay.io/dwinchell_redhat/bogohttp:v2.0.amd64 .
podman push quay.io/dwinchell_redhat/bogohttp:v2.0.amd64

# ppcle64
podman build --platform linux/ppc64le -t quay.io/dwinchell_redhat/bogohttp:v2.0.ppcle64 .
podman push quay.io/dwinchell_redhat/bogohttp:v2.0.ppcle64
```

