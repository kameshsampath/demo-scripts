#!/bin/bash
command1="istioctl replace -f ../istio-tutorial/istiofiles/virtual-service-recommendation-v1_and_v2_retry.yml -n tutorial"
echo $command1
$command1

