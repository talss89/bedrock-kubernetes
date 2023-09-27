<p align="center">
  <a href="https://roots.io/bedrock/">
    <img alt="Bedrock" src="https://cdn.roots.io/app/uploads/logo-bedrock.svg" height="100">
  </a>
</p>

<p align="center">
  But Kubernetes.
</p>

> :warning: Although you could use this in production, expect to be stabbing around in the dark. I'm working on a set of tools which will further improve the dev, deploy and ops experience. If you have little experience with K8s, WordPress, PHP and Nginx, it's worth waiting until the v1.0.0 release.

## Introduction

This project is a starting point for bootstrapping WordPress (with Bedrock) on Kubernetes.

It provides both a full dev environment (with Visual Studio Code integration), and a deploy mechanism. 

The project uses [Devspace](https://www.devspace.sh/) and the [Bitpoke WordPress runtime](https://github.com/bitpoke/stack-runtimes) to watch and sync your files between your local machine and the cluster, allowing you to develop using your local machine (Windows, Mac, Linux, whatever), but giving you the flexibility to offload onto other hardware if required.

You can choose to run a local Kubernetes cluster (like `minikube`) or point it straight at services like AWS EKS, GKE, Linode LKE or DigitalOcean. Or provision your own cluster on your own hardware another way.

## Why?

Because Kubernetes is 'cool'.

No, there are actually a number of real benefits to this approach:

- **Full parity between development and production.** Your dev environment runs the same stack as production, with the same architecture.
- **Develop locally, or decide to offload onto a cluster at any point.** We all know the frustration of dev environments eating our local resources. We're using this approach to work on a project with ~50,000 Woocommerce products, backed by Elasticsearch. Our local machines can't handle that.
- **Zero downtime deployments with rollback** Deploy a new production release, and if it fails the healthchecks, it's rolled back before serving it's first visitor.
- **Your app is built with scalability in mind from day 0** This approach facilitates scaling - your app is containerised, and running as a deployment on Kubernetes. If / when you need multi-master SQL, horizontal auto-scaling, failover, canary deploys, it's all there waiting.
- **Use your hardware efficiently** Run multiple services on the same hardware - like you do with VMs. But unlike a VM, bring new machines online or scale down your cluster automatically based on load.
- **Declarative backups** Declare backup schedules using established tools like Velero

## Getting Started

### Ingredients

Make sure you have up-to-date versions of the following software:

- [Devspace](https://www.devspace.sh/docs/getting-started/installation)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- Visual Studio Code (**[with CLI enabled, if you're on Mac](https://code.visualstudio.com/docs/setup/mac#:~:text=Launching%20from%20the%20command%20line,executing%20the%20Shell%20Command%3A%20Install%20%27code%27%20command%20in%20PATH%20command.)**)

You will also need a Kubernetes cluster `1.24` or newer. This can be local, or remote. Just make sure you can `kubectl get namespaces` without error. Make sure you have an Ingress controller installed.

If you want to run a local Kubernetes instance, I'd recommend [`minikube`](https://kubernetes.io/docs/tasks/tools/). You can install an ingress controller via `minikube addons enable ingress`.

Make sure you create a namespace `kubectl create ns <yourname>` and switch to it.

### Start a project

1. Download this repo
2. Edit `./devspace.yaml` and change the `name:` property on line 2 to the name of your project. Keep it short, and make it DNS-like.
3. Make sure you have the right Kubernetes context set
4. Run `devspace build` - After answering a few questions, your app container will then be built on the cluster, and hosted in a local registry.
5. Run `devspace dev` - Your app will then be deployed in dev mode, and Visual Studio Code will start.
6. Keep the `devspace dev` process running while you develop in Visual Studio Code

If running locally, you'll need to set up a host record to point to your cluster in order to access your site. For `minikube`, make sure `minikube tunnel` is running, and point your host record at `127.0.0.1`.

**Do not attempt to use HTTPS for local clusters**. I have a feature in the pipeline for this, but it's not ready yet.
