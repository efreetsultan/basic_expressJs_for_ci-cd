#!/bin/bash

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Prometheus",
    "type": "prometheus",
    "url": "http://prometheus-operated.monitoring.svc:9090",
    "access": "proxy"
  }' \
  http://your-grafana-url/api/datasources

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "dashboard": {
      "title": "Hello Jenkins Metrics",
      "annotations": {
        ...
      },
      "panels": [
        ...
      ]
    },
    "overwrite": false
  }' \
  http://your-grafana-url/api/dashboards/import
