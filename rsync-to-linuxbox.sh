#!/bin/bash

rsync -avz --exclude='.idea/' --exclude='.git/' --exclude='gcloud-ssh-portforwarding.ssh' --exclude='rsync-to-linuxbox.sh' \
-e "ssh -i ~/.ssh/google_compute_engine -p 8022" /Users/triettranminh/playground/argo-gitops-demo triettranminh@localhost:/home/triettranminh/
