**Kubernetes Monitoring Stack (Helm + GCP)**
This branch transitions the monitoring stack from manual YAML manifests to Helm Charts. It is specifically optimized for Google Kubernetes Engine (GKE), featuring automated persistent storage and cloud load balancing.

**🚀 Enhancements over Manual Setup**
Infrastructure as Code (IaC): Managed via values.yaml for repeatable deployments.
Persistence: Automated GCP Persistent Disk provisioning using standard-rwo StorageClass.
Automation: Grafana is pre-configured to connect to Prometheus upon startup.
Cloud Native: Uses GCP Load Balancers for external access.

**🛠️ Prerequisites**
GCP Project with a running GKE Cluster.
gcloud CLI authenticated.
kubectl and helm installed.

**📦 Installation Steps**

**1. Add Helm Repositories**
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

**2. Deploy the Stack**

# Create the namespace
kubectl create namespace monitoring

# Install Prometheus & Node Exporter
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  -f helm/prometheus-values.yaml

# Install Grafana
helm install grafana grafana/grafana \
  --namespace monitoring \
  -f helm/grafana-values.yaml


**🔍 Verification & Access**

**Check Persistent Volumes**
Ensure GKE has successfully provisioned the Google Cloud Disks:
kubectl get pvc -n monitoring

**Access Grafana**
Wait for the GCP Load Balancer to assign an External IP:
kubectl get svc -n monitoring grafana -w

URL: http://<EXTERNAL-IP>
User: admin
Password: prom-operator (as defined in grafana-values.yaml)

**⚙️ Configuration Details**
**Persistence**
The values.yaml files are configured with ReadWriteOnce access modes. This ensures that if a pod is rescheduled to a different node in your GCP zone, the disk follows it, preserving all historical metrics and custom dashboards.

**Data Sources**
Grafana is bootstrapped using the Internal Kubernetes DNS:
http://prometheus-server.monitoring.svc.cluster.local

**🧹 Cleanup**
To delete the stack and release GCP resources (disks and load balancers):
helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring
kubectl delete ns monitoring
