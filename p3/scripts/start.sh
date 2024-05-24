#!/bin/bash

sudo k3d cluster create iot -p "80:80@loadbalancer"

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl wait --for=condition=available deployments --all -n argocd --timeout 300s

sudo kubectl apply -n argocd -f ./confs/wil-application.yaml

sudo kubectl wait --for=condition=available deployments --all -n dev --timeout 300s

echo "\nargocd login: admin, password: "
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo "\n\nTo access ArgoCD UI: 192.168.56.112:4443"
sudo kubectl -n argocd --address 0.0.0.0 port-forward service/argocd-server 4443:443 &

echo "\nTo access wil-playground app : 192.168.56.112:8888\nEnter: sudo kubectl -n dev --address 0.0.0.0 port-forward service/wil-service 8888:8888 &
