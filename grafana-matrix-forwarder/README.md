# Grafana Matrix Forwarder

[Grafana](https://grafana.com/) is the open source analytics & monitoring solution for every database

[Matrix](https://matrix.org/) is a decentralized/distributed real-time communication network that combines the openness and flexibility of solutions like IRC with the user-friendliness of modern centralized communication networks

## Introduction

This chart bootstraps a grafana-matrix-forwarder deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Grafana
- Matrix

## Installing the Chart

To install the chart with the release name `grafana-matrix-forwarder`:

```bash
$ helm repo add zloi.space https://chartmuseum.zloi.space/
$ helm repo update
$ helm upgrade --install grafana-matrix-forwarder zloi.space/grafana-matrix-forwarder --namespace monitoring
```

These commands deploy grafana-matrix-forwarder on the Kubernetes cluster in the default configuration.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `grafana-matrix-forwarder` deployment:

```bash
$ helm uninstall grafana-matrix-forwarder --namespace monitoring
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
