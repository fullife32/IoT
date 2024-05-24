GITLAB_ADDR="192.168.56.112"

sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update

sudo helm upgrade --install gitlab gitlab/gitlab -n gitlab --create-namespace \
  -f chart/gitlab.yml \
  --set global.hosts.domain="$GITLAB_ADDR.nip.io" \
  --set global.hosts.externalIP="$GITLAB_ADDR" \
  --set global.edition=ce \
  --set global.hosts.https=false \
  --timeout 600s

sudo kubectl wait --for=condition=available deployments --all -n gitlab --timeout 900s

echo "\n\nGo to gitlab.$GITLAB_ADDR.nip.io"
echo "Connect with user : root"
echo "password : "
sudo kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d
echo "Create a public repository under the name wil-app"
echo "Press Enter when done to continue"

read touche

git clone https://github.com/fullife32/eassouli-iot.git
cd eassouli-iot
git remote set-url origin http://gitlab.$GITLAB_ADDR.nip.io/root/wil-app.git
git push --set-upstream origin main
cd ../

sudo kubectl apply -n argocd -f ./confs/wil-application.yaml
