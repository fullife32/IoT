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
echo "- Connect with user : root"
echo "  password : "
sudo kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d
echo "\n\n- Create a blank project"
echo "- Project name : wil-app"
echo "- In project URL, choose the group : root"
echo "- Visibility Level : Public"
echo "- Uncheck Initialize repository with a README"
echo "Press Enter when done to continue"

read touche

git clone https://github.com/fullife32/eassouli-iot.git
cd eassouli-iot
git remote remove origin
git remote add origin http://gitlab.$GITLAB_ADDR.nip.io/root/wil-app.git
git push --set-upstream origin main
cd ../

sudo kubectl apply -n argocd -f ./confs/wil-application.yaml

echo "\nTo access wil-playground app : 192.168.56.112:8888\nEnter: sudo kubectl -n dev --address 0.0.0.0 port-forward service/wil-service 8888:8888 &"