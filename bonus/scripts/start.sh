helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace \
  -f ../chart/gitlab.yml \
  --set global.hosts.domain="192.168.43.48.nip.io" \
  --set global.hosts.externalIP="192.168.43.48" \
  --set global.edition=ce \
  --set global.hosts.https=false \
  --timeout 600s

kubectl wait --for=condition=available deployments --all -n gitlab --timeout 900s

echo "gitlab URL: gitlab.192.168.43.48.nip.io"
echo "login: root, password:"
kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d

# Install kubectl, k3d, docker and helm automatic for 42
# Change wil app to run on 80