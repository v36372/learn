# PART 1 - Overview

## Chapter 1 - Introducing Kubernetes

### Containers vs VMs

## Chapter 2 - First steps with Docker and Kubernetes

### Setup locally

# PART 2 - Core Concepts

## Chapter 3 - Pods

### Why need pods?

- Multiple containers are better than multiple processes in a single container
 - how to make sure those process running correctly?
 - add cost of orchestration, logging & self healing
- Need pod to group containers together as unit
- Containers in the same pod should have some isolation but not too strictly
 - Same network, UTS, loopback network interface
 - Should isolate filesystem
 - Containers in the same pod have the same IP address and port space
- All pods share a flat, no NAT network space
 - All pods can access eather other via IP address
 - network call is cheap because no NAT

- Multi containers in the same pod? Not recommended unless utterly necessary, because:
 - better resource utilization
 - better scaling

- When to consider multiple containers in the same pod:
 - Do they need to be run together or can they run on different hosts?
 - Do they represent a single whole or are they independent components?
 - Must they be scaled together or individually? 


 ### Creating pods

 #### Pods definition

 - Metadata: name, namespace, labels
 - Spec: containers, volume
 - Status: current information, internal IP


 ### Useful commands

 - kubectl explain
 - kubectl get po --show-labels
 - kubectl create -f kubia-manual.yaml
 - kubectl logs [name] -c [container-name]
 - kubectl port-forward [name] [local]:[cluster]
 - kubectl delete po [name] -l [label] -n [namespace]


 ### Labels

- Used for distinguish different type of apps (backend, frontend), evironments (qa, prod)
- Anything in K8s can be labeled
- Can be used to deploy pods to specific node with given label


### Annotations

More or less like description


### Namespaces

Used for isolating resources between non-overlapping groups


