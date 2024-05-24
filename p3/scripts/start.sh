#!/bin/bash

sudo k3d cluster create iot -p "80:80@loadbalancer"

sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl wait --for=condition=available deployments --all -n argocd --timeout 300s

sudo kubectl apply -n argocd -f confs/wil-application.yaml

echo "\nargocd login: admin, password: "
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo "\nTo access ArgoCD UI: sudo kubectl -n argocd port-forward service/argocd-server 4443:443 &"

echo "\nTo access wil-playground app on localhost:8888 : sudo kubectl -n dev port-forward service/wil-service 8888:8888 &"