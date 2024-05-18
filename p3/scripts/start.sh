#!/bin/bash

k3d cluster create iot -p "80:80@loadbalancer"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=available deployments --all -n argocd --timeout 300s

kubectl apply -n argocd -f ../confs/argocd/wil-application.yaml
# kubectl apply -n argocd -f ../ingress/argocd-ingress.yml

echo "argocd login: admin, password:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo "\nTo access ArgoCD UI: kubectl -n argocd port-forward service/argocd-server 4443:443"

echo "To access wil-playground app on localhost:8888: kubectl -n dev port-forward service/wil-service 8888:8888"