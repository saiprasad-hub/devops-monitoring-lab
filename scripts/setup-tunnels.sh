#!/bin/bash
# Replace these variables
KEY_PATH="~/Downloads/your-key.pem"
EC2_IP="50.18.133.118"

echo "Step 1: Port-forwarding Kubernetes Service..."
kubectl port-forward -n monitoring svc/node-exporter 19100:9100 &

echo "Step 2: Establishing SSH Tunnel to EC2..."
ssh -i $KEY_PATH -N -L 9101:localhost:19100 ubuntu@$EC2_IP &

echo "Tunnels active. Press Ctrl+C to stop."
wait
