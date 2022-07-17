{{/*
Expand the name of the chart.
*/}}
{{- define "grafana-matrix-forwarder.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "grafana-matrix-forwarder.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "grafana-matrix-forwarder.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "grafana-matrix-forwarder.labels" -}}
helm.sh/chart: {{ include "grafana-matrix-forwarder.chart" . }}
{{ include "grafana-matrix-forwarder.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "grafana-matrix-forwarder.selectorLabels" -}}
app.kubernetes.io/name: {{ include "grafana-matrix-forwarder.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "grafana-matrix-forwarder.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "grafana-matrix-forwarder.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Homeserver for grafana-matrix-forwarder
*/}}
{{- define "grafana-matrix-forwarder.homeserver" -}}
{{- if .Values.pantalaimon.enabled }}
{{- printf "%s:%s" "http://localhost" .Values.pantalaimon.listenPort }}
{{- else }}
{{- .Values.matrix.homeserver }}
{{- end }}
{{- end }}
