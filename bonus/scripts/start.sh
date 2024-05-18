# k3d cluster create iot --api-port 6443 -p "8080:80@loadbalancer"

# kubectl create namespace argocd
# kubectl create namespace dev

# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace \
  -f ../chart/gitlab.yml \
  --set global.hosts.domain=10.18.194.53.nip.io \
  --set global.edition=ce \
  --set global.hosts.https=false \
  --timeout 600s
  # --set postgresql.image.tag=13.6.0 \

# Reuse p3 environment and only apply gitlab, then change github to iot for app manifest
# Install kubectl, k3d, docker and helm automatic for 42
# Change wil app to run on 80
# Automatic change /etc/host or use nip.io

kubectl wait --for=condition=available deployments --all -n gitlab --timeout 900s