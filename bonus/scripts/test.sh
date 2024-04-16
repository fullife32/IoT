k3d cluster create iot --api-port 6443 -p "8080:80@loadbalancer" --wait --agents 4

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=Ready pods --all -n argocd

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace \
  -f ../chart/gitlab-chart.yml \
  --set global.hosts.domain=10.11.1.253.nip.io \
  --set global.hosts.externalIP=10.11.1.253 \
  --set global.edition=ce \
  --timeout 600s

# Reuse p3 environment and only apply gitlab, then change github to iot for app manifest
# Install kubectl, k3d, docker and helm automatic for 42

kubectl wait --for=condition=available deployments --all -n gitlab --timeout 900s