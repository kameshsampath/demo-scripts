#!/bin/bash

set -e 

# https://raw.githubusercontent.com/knative/serving/release-0.2/config/config-autoscaler.yaml

kubectl -n knative-serving get cm config-autoscaler -o yaml | yq w - -s config-autoscaler.yaml | kubectl apply -f -

# Restart import pods
oc scale deployment -n knative-serving activator --replicas 0 
oc scale deployment -n knative-serving activator --replicas 1

oc scale deployment -n knative-serving controller --replicas 0
oc scale deployment -n knative-serving controller --replicas 1

while oc get pods -n knative-serving | grep -v -E "(Running|Completed|STATUS)"; do sleep 5; done