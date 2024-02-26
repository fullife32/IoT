#!/bin/bash

k3d cluster create argocd -p "80:80@loadbalancer"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# sleep 30
kubectl apply -n argocd -f ../confs/argocd/wil-application.yaml
kubectl apply -n argocd -f ../ingress/argocd-ingress.yml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
