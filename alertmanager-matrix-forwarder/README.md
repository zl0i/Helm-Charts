# Alertmanager Matrix Forwarder

The [Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/) handles alerts sent by client applications such as the Prometheus server

[Matrix](https://matrix.org/) is a decentralized/distributed real-time communication network that combines the openness and flexibility of solutions like IRC with the user-friendliness of modern centralized communication networks

## Introduction

This chart bootstraps a alertmanager-matrix-forwarder deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Alertmanager
- Matrix

## Installing the Chart

To install the chart with the release name `alertmanager-matrix-forwarder`:

```bash
$ helm repo add zloi.space https://chartmuseum.zloi.space/
$ helm repo update
$ helm upgrade --install alertmanager-matrix-forwarder zloi.space/alertmanager-matrix-forwarder --namespace monitoring
```

These commands deploy alertmanager-matrix-forwarder on the Kubernetes cluster in the default configuration.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `alertmanager-matrix-forwarder` deployment:

```bash
$ helm uninstall alertmanager-matrix-forwarder --namespace monitoring
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

### Config Alertmanager

```yaml
receivers:
- name: 'matrix'
  webhook_configs:
  - url: 'http://alertmanager-matrix-forwarder:3000/alerts?secret=<secret>'
```
