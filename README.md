# Hetzner K8S cluster

This repository provides you with a plug-and-play setup to provision a Kubernetes (K8S) cluster,
deployed in the Hetzner cloud.

Terraform is used to set up the VMs, virtual networks, firewall, etc. In turn, an Ansible inventory
file is generated such that Kubespray can be used to configure the Kubernetes cluster. Finally, an
Ansible playbook is used to deploy ArgoCD.

## Getting started

### .env file

First create a copy from the example.env file, renaming it to .env, next
change the environment variables to the correct values.

### DNS zone

If not already done so, create a new DNS zone in the Hetzner portal: https://dns.hetzner.com/

### Execution

To deploy a cluster of 3 nodes, execute the following:

    NUM_NODES=3 ./deploy

To shut it down, execute:

    NUM_NODES=0 ./deploy
