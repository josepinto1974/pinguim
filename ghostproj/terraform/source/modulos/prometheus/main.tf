resource "aws_prometheus_workspace" "pinguimghost" {
    alias = "prometheus-pinguimghost"
}

resource "aws_prometheus_rule_group_namespace" "demo" {
  name         = "rules"
  workspace_id = aws_prometheus_workspace.pinguimghost.id
  data         = <<EOF
groups:
  - name: test
    rules:
    - record: metric:recording_rule
      expr: avg(rate(container_cpu_usage_seconds_total[5m]))
EOF
}