  k3d cluster create iot --api-port 6443 -p "80:80@loadbalancer" --wait

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace \
  -f ../chart/gitlab-chart.yml \
  --set global.edition=ce \
  --set global.hosts.https=false \
  --timeout 600s

# Reuse p3 environment and only apply gitlab, then change github to iot for app manifest
# Install kubectl, k3d, docker and helm automatic for 42
