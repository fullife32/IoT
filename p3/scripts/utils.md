# To get argocd UI password, login: admin
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# To access argocd UI on localhost:4443
kubectl -n argocd port-forward service/argocd-server 4443:443

# To access wil-playground app on localhost:8888
kubectl -n dev port-forward service/wil-service 8888:8888