# Alertmanager Matrix Forwarder

Open in [Artifact Hub](https://artifacthub.io/packages/helm/zloi-space/alertmanager-matrix-forwarder)

## What is Alertmanager Matrix Forwarder?

A bot to receive Prometheus Alertmanager webhook events and forward them to chosen rooms.

Main features:

- Uses pre-created Matrix user to send alerts using password.
- Configurable room per alert receiver.
- Automatic joining of configured rooms. Private rooms require an invite.
- Secret key authentication with Alertmanager.
- HTML formatted messages.
- Optionally mentions `@room` on firing alerts

## How to use

### Docker

The [Docker image](https://hub.docker.com/r/zl0i/alertmanager-matrix-forwarder) `zl0i/matrix-alertmanager:v1.0.0` is the easiest way to get the service running. Ensure you set the required environment variables listed in `.env.default` in this repository.

To start the container, use the command

```bash
$ docker run --name forwarder \
    -e APP_ALERTMANAGER_SECRET='secret' \
    -e MATRIX_HOMESERVER_URL='https://matrix.org' \
    -e MATRIX_ROOMS='matrix/!XRMnKmXLQJqjnKCGzU:matrix.org' \
    -e MATRIX_USER='@alertmanager-matrix-forwarder:matrix.org' \
    -e MATRIX_PASSWORD='password' \
    -e MENTION_ROOM='0' \
    zl0i/alertmanager-matrix-forwarder:v1.0.0
```

or by modifying the docker-compose.yml file:

```yaml
services:
  forwarder:
    image: zl0i/alertmanager-matrix-forwarder:v1.0.0
    environment:
      - APP_ALERTMANAGER_SECRET='secret'
      - MATRIX_HOMESERVER_URL='https://matrix.org'
      - MATRIX_ROOMS='matrix/!XRMnKmXLQJqjnKCGzU:matrix.org'
      - MATRIX_USER='@alertmanager-matrix-forwarder:matrix.org'
      - MATRIX_PASSWORD='password'
      - MENTION_ROOM='0'
```

### How to deploy in Kubernetes?

Deploying this applications as Helm Charts is the easiest way to get started with our applications on Kubernetes. Read more about the installation in the Chart GitHub repository.

```bash
$ helm repo add zloi.space https://chartmuseum.zloi.space/
$ helm repo update
$ helm upgrade --install alertmanager-matrix-forwarder zloi.space/alertmanager-matrix-forwarder --namespace monitoring
```

### Alertmanager

You will need to configure a webhook receiver in Alertmanager. It should looks something like this:

```yaml
receivers:
  - name: 'matrix'
    webhook_configs:
      - url: 'http://alertmanager-matrix-forwarder:3000/alerts?secret=secret'
```

The secret key obviously should match the one in the alertmanager configuration.

### Prometheus rules

Add some styling to your prometheus rules

```yaml
rules:
  - alert: High Memory Usage of Container
    annotations:
      description: Container named <strong>{{\$labels.container_name}}</strong> in <strong>{{\$labels.pod_name}}</strong> in <strong>{{\$labels.namespace}}</strong> is using more than 75% of Memory Limit
    expr: |
      ((( sum(container_memory_usage_bytes{image!=\"\",container_name!=\"POD\", namespace!=\"kube-system\"}) by (namespace,container_name,pod_name, instance)  / sum(container_spec_memory_limit_bytes{image!=\"\",container_name!=\"POD\",namespace!=\"kube-system\"}) by (namespace,container_name,pod_name, instance) ) * 100 ) < +Inf ) > 75
    for: 5m
    labels:
      team: dev
```

NOTE! Currently the bot cannot talk HTTPS, so you need to have a reverse proxy in place to terminate SSL, or use unsecure unencrypted connections.
