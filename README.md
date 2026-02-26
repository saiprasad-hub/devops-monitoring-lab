# devops-monitoring-lab

# DevOps Monitoring & Alerting Lab (Prometheus + Grafana)

This project demonstrates a real-world monitoring setup connecting an AWS EC2 Prometheus instance to a local Kubernetes (KIND) cluster using SSH Tunnels.

## Architecture
- **Metrics Source:** Node Exporter (DaemonSet in K8s + Binary on EC2)
- **Collector:** Prometheus (Running on EC2)
- **Visualization & Alerting:** Grafana
- **Notification:** Gmail SMTP Integration

## Key Steps Covered
1. **Infrastructure Isolation:** Deployed monitoring tools in a dedicated `monitoring` namespace.
2. **Cross-Network Connectivity:** Established an SSH tunnel to bridge a local KIND cluster with a cloud-based Prometheus server.
3. **SMTP Alerting:** Configured Grafana `grafana.ini` with Gmail App Passwords to enable real-time email notifications.
4. **Incident Simulation:** Used the `stress` tool to trigger CPU alerts and verify the full alerting pipeline (Normal -> Pending -> Firing -> Resolved).

## How to Run
1. Apply K8s manifests: `kubectl apply -f kubernetes/`
2. Run the tunnel script: `./scripts/setup-tunnels.sh`
3. Update Prometheus: Copy `prometheus/prometheus.yml` to your EC2 instance and restart the service.
