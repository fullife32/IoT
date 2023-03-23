#!/bin/bash

k3d cluster create argocd
# k3d cluster create argocd --api-port 6443 -p 8080:80@loadbalancer
# k3d cluster create argocd -p "8888:8888@loadbalancer"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f ../confs/argocd/application.yaml
# kubectl -n argocd apply -f ingress/argocd-ingress.yaml
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
# kubectl -n argocd port-forward service/argocd-server 8080:80
# kubectl -n dev port-forward service/wil-service 8888:8888

# kubectl -n kube-system port-forward pod/traefik(change pod name) 9000:9000
