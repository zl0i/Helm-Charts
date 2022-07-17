# ClickHouse

[ClickHouse](https://clickhouse.yandex/) is an open source column-oriented database management system capable of real time generation of analytical data reports using SQL queries.

## Introduction
This chart bootstraps a [ClickHouse](https://clickhouse.yandex/) replication cluster deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.10+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `clickhouse`:

```bash
$ helm repo add zloi.space https://chartmuseum.zloi.space/
$ helm repo update
$ helm upgrade --install clickhouse zloi.space/clickhouse
```
These commands deploy Clickhouse on the Kubernetes cluster in the default configuration. 

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `clickhouse` deployment:

```bash
$ helm uninstall clickhouse
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


