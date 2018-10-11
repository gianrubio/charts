{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus-operator.fullname" -}}
{{- if .Values.prometheusOperator.fullnameOverride -}}
{{- .Values.prometheusOperator.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prometheus-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- /*
prometheus-operator.labels prints the standard prometheus-operator Helm labels.
*/ -}}
{{- define "prometheus-operator.labels.standard" -}}
app: {{ template "prometheus-operator.name" . }}
chart: {{ template "prometheus-operator.chart" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
operator: prometheus
{{- end }}

{{- define "prometheus-operator.labels.global" -}}
chart: {{ template "prometheus-operator.chart" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
{{- end }}


{{- define "alertmanager.serviceAccountName" -}}
{{- if .Values.alertmanager.serviceAccount.create -}}
    {{ default "alertmanager" .Values.alertmanager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.alertmanager.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "alertmanager.fullname" -}}
{{- if .Values.alertmanager.fullnameOverride -}}
{{- .Values.alertmanager.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "alertmanager" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "prometheus-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "prometheus-operator.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "prometheus.fullname" -}}
{{- if .Values.prometheus.fullnameOverride -}}
{{- .Values.prometheus.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "prometheus" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "prometheus.serviceAccountName" -}}
{{- if .Values.prometheus.serviceAccount.create -}}
    {{ default (include "prometheus.fullname" .) .Values.prometheus.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.prometheus.serviceAccount.name }}
{{- end -}}s
{{- end -}}

{{- define "kube-apiserver.fullname" -}}
{{- if .Values.kubeApiServer.fullnameOverride -}}
{{- .Values.kubeApiServer.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "kube-apiserver" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "kube-controller-manager.fullname" -}}
{{- if .Values.kubeControllerManager.fullnameOverride -}}
{{- .Values.kubeControllerManager.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "kube-controller-manager-prometheus-discovery" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "kube-scheduler.fullname" -}}
{{- if .Values.kubeScheduler.fullnameOverride -}}
{{- .Values.kubeScheduler.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "kube-scheduler-prometheus-discovery" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "kube-dns.fullname" -}}
{{- if .Values.kubeDns.fullnameOverride -}}
{{- .Values.kubeDns.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "kube-dns-prometheus-discovery" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "core-dns.fullname" -}}
{{- if .Values.coreDns.fullnameOverride -}}
{{- .Values.coreDns.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "core-dns-prometheus-discovery" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "node-exporter.fullname" -}}
{{- if .Values.nodeexporter.fullnameOverride -}}
{{- .Values.nodeexporter.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "node-exporter" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{/*
Workaround for https://github.com/helm/helm/issues/3117
*/}}
{{- define "prometheus-operator.rangeskipempty" -}}
{{- range $key, $value := . }}
{{- if $value }}
{{ $key }}: {{ $value }}
{{- end }}
{{- end }}
{{- end }}