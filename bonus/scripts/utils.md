# To get argocd UI password, login: admin
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# To access argocd UI on localhost:4443
kubectl -n argocd port-forward service/argocd-server 4443:443

# To access wil-playground app on localhost:8888
kubectl -n dev port-forward service/wil-service 8888:8888

# To get gitlab root password, login: root
kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d

<!-- # To access gitlab app on localhost:80
kubectl -n gitlab port-forward service/gitlab-nginx-ingress-controller 8080:80
kubectl -n gitlab port-forward svc/gitlab-webservice-default --address 10.11.1.253 8082:8080 -->