# resource "helm_release" "prometheus_operator" {
#   name       = "prometheus-operator"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus-operator"
#   version    = "9.5.0"

#   set {
#     name  = "kubeTargetVersionOverride"
#     value = "1.22"
#   }
# }

# resource "helm_release" "grafana_operator" {
#   name       = "grafana-operator"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana-operator"
#   version    = "5.0.1"
# }

# resource "kubectl_manifest" "service_monitor" {
#   manifest = <<-EOT
#     apiVersion: monitoring.coreos.com/v1
#     kind: ServiceMonitor
#     metadata:
#       name: hello-jenkins-monitor
#       namespace: default
#     spec:
#       selector:
#         matchLabels:
#           app: hello-jenkins
#       endpoints:
#         - interval: 10s
#           port: web
#   EOT
# }
