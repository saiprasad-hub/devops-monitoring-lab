# Real-World DevOps PromQL Queries

### CPU Usage % (The standard for alerting)
`100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)`

### Memory Usage % (The "Silent Killer")
`(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100`

### Disk Usage % (The "Most Dangerous")
`100 - (node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100`
