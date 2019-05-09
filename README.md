## kustomize-config-overlays

#### Current Output:

```
Switched to context "docker-for-desktop".

=============================
configmap "nginx-deployment-config" configured
deployment.apps "nginx-deployment" configured
=============================
deployment "nginx-deployment" successfully rolled out
#############################
FOO_BAR value:
base-foobar
#############################

=============================
configmap "nginx-deployment-config" configured
deployment.apps "nginx-deployment" configured
=============================

deployment "nginx-deployment" successfully rolled out
#############################
FOO_BAR value:
base-foobar
#############################
```

#### Desired Output:

```
Switched to context "docker-for-desktop".

=============================
configmap "nginx-deployment-config" configured
deployment.apps "nginx-deployment" unchanged
=============================
deployment.apps "nginx-deployment" env updated
Waiting for rollout to finish: 1 old replicas are pending termination...
Waiting for rollout to finish: 1 old replicas are pending termination...
deployment "nginx-deployment" successfully rolled out
#############################
FOO_BAR value:
base-foobar
#############################

=============================
configmap "nginx-deployment-config" configured
deployment.apps "nginx-deployment" unchanged
=============================

deployment.apps "nginx-deployment" env updated
Waiting for rollout to finish: 1 old replicas are pending termination...
Waiting for rollout to finish: 1 old replicas are pending termination...
deployment "nginx-deployment" successfully rolled out
#############################
FOO_BAR value:
staging-foobar
#############################
```

#### Conclusion

- ENV vars from deployment doesn't get overriden by configmap data
- In order to fully utilise overwrite of env vars, base configmap should be used instead of deployment env.
