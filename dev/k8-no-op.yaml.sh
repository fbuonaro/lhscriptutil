#!/bin/bash
cat <<EOF
# https://github.com/tilt-dev/tilt/issues/4070#issuecomment-1099250184
# This is a no op Job, we're doing this so we can gain the benefits of Tilt
# auto-building the local image for us
---
apiVersion: batch/v1
kind: Job
metadata:
  name: no-op
  namespace: default
spec:
  template:
    spec:
      containers:
      - name: no-op
        image: $1
      restartPolicy: Never
EOF