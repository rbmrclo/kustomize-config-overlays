#!/bin/bash -eu

# KustomizeVersion:1.0.8

APP_NAME="nginx-deployment"

kubectl config use-context docker-for-desktop

echo
echo "============================="
kustomize build base | kubectl apply -f -
echo "============================="

kubectl set env --all deployment --env="LAST_MANUAL_RESTART=$(date +%s)"
kubectl rollout status deployment/nginx-deployment

sleep 10

POD_INFO_1=$(kubectl get pods -l "app=${APP_NAME}" -o json)
POD_NAME_1="$(echo ${POD_INFO_1} | jq -r '.items[0].metadata.name')"

echo "#############################"
echo "FOO_BAR value:"
kubectl exec $POD_NAME_1 -it -- printenv FOO_BAR
echo "#############################"

echo
echo "============================="
kustomize build apps/overlays/staging | kubectl apply -f -
echo "============================="
echo

# To trigger deployment rollout without deployment.yaml changes
kubectl set env --all deployment --env="LAST_MANUAL_RESTART=$(date +%s)"
kubectl rollout status deployment/nginx-deployment

sleep 10

POD_INFO_2=$(kubectl get pods -l "app=${APP_NAME}" -o json)
POD_NAME_2="$(echo ${POD_INFO_2} | jq -r '.items[0].metadata.name')"

echo "#############################"
echo "FOO_BAR value:"
kubectl exec $POD_NAME_2 -it -- printenv FOO_BAR
echo "#############################"
