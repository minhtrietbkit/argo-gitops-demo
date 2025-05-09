# GitOps + ArgoCD + Kustomize + Helm

This is the accompanying repository for [this blog](https://www.linkedin.com/posts/trietminhtran_opentowork-activity-7326606924307746817-S3dj?utm_source=share&utm_medium=member_desktop&rcm=ACoAAB7X4-IBxQ71Wu4_Wyp8doHugmm31UJEZtE).

ArgoCD is the de facto GitOps CD tool for K8s. This blog post explores:

* Structure GitOps repo for ArgoCD for various usecases
* Use ArgoCD with Kustomize and Helm
* Keep ArgoCD manifests DRY with Applicationset
* ArgoCD App of Apps - how much nesting is enough

The following is note for whoever wants to launch this project on their own.

## Create kind clusters

```bash
kind create cluster --config 
```

## Install calico first cluster
```
kubectl kustomize manifests/calico/ --enable-helm | kubectl apply -f -
```
This command can fail to create some resources because kubectl doesn't wait for operator to run before creating CRD.
Just apply again several times.

## Install argocd first cluster
```
kubectl kustomize manifests/argocd/ --enable-helm | kubectl create -f -
```
## ArgoCD login
### To be run on your laptop
```
argocd login localhost:55769 --skip-test-tls --insecure
```
### To be run on the remote host

1. Change API server hosts in kubeconfig to controller docker ip and port 6443
2. `argocd login --kube-context kind-dev1 --port-forward  --port-forward-namespace argocd`

## Add cluster

Kubeconfig on remote host must specify kind container local address and port 6443. You can still use `kubectl` on remote host with that kubeconfig.

To be run on the remote host

1. Login to argocd server
2. `argocd cluster --kube-context kind-dev1 --port-forward --port-forward-namespace argocd --grpc-web add kind-dev3`
