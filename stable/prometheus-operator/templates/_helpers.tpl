{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "prometheus-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
The longest name that gets created adds and extra 28 charachters, so trunc should be 63-28=35, 
which gives 16 charachters for a release name without it being trimmed
*/}}
{{- define "prometheus-operator.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "prometheus-operator.chartref" -}}
{{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end }}

{{/* Generate basic labels */}}
{{- define "prometheus-operator.labels" }}
chart: {{ template "prometheus-operator.chartref" . }}
release: {{ .Release.Name | quote }}
heritage: {{ .Release.Service | quote }}
{{- if .Values.commonLabels}}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end }}

{{/* Workaround for https://github.com/helm/helm/issues/3117 */}}
{{- define "prometheus-operator.rangeskipempty" -}}
{{- range $key, $value := . }}
{{- if $value }}
{{ $key }}: {{ $value }}
{{- end }}
{{- end }}
{{- end }}