#!/bin/bash

k3d cluster create argocd -p "80:80@loadbalancer"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
helm repo add gitlab https://charts.gitlab.io/
helm repo update
# helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace -f chart/gitlab-chart.yml
helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace \
  --timeout 600s \
  --set global.edition=ce \
  --set global.hosts.domain=iot.local \
  --set certmanager-issuer.email=me@example.com \
  --set gitlab-runner.install=false

# kubectl apply -f ingress/gitlab-ingress.yml

# sleep 60
# kubectl apply -n argocd -f ../confs/argocd/wil-application.yaml
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
# kubectl -n argocd port-forward service/argocd-server 4443:443
# kubectl -n gitlab port-forward gitlab-nginx-ingress-controller 80:80