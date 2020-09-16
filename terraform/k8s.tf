resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "k8s"
  region  = "blr1"
  version = "1.18.8-do.0"

  node_pool {
    name       = "workers"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

output "cluster-id" {
  value = "${digitalocean_kubernetes_cluster.k8s.id}"
}
