// Copyright 2022 Isovalent, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "main" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "30.0.0"

  cluster_resource_labels    = var.tags
  ip_range_pods              = var.pod_cidr_name
  ip_range_services          = var.service_cidr_name
  additional_ip_range_pods   = var.additional_ip_range_pods
  horizontal_pod_autoscaling = true
  http_load_balancing        = true
  identity_namespace         = var.enable_workload_identity ? "enabled" : null
  kubernetes_version         = var.kubernetes_version
  node_metadata              = var.enable_workload_identity ? "GKE_METADATA" : "UNSPECIFIED"
  name                       = var.name
  network                    = replace(var.vpc_id, "projects/${var.project_id}/global/networks/", "")
  network_policy             = false
  project_id                 = var.project_id
  release_channel            = var.release_channel
  remove_default_node_pool   = true
  region                     = var.region
  subnetwork                 = var.subnet_id
  zones                      = []

  node_pools = [
    for key, node_pool in var.node_pools :
    {
      auto_repair        = node_pool.auto_repair
      auto_upgrade       = node_pool.auto_upgrade
      disk_size_gb       = node_pool.root_volume_size
      disk_type          = node_pool.root_volume_type
      image_type         = node_pool.image_type
      initial_node_count = node_pool.min_nodes
      machine_type       = node_pool.instance_type
      max_count          = node_pool.max_nodes
      min_count          = node_pool.min_nodes
      name               = key
      preemptible        = node_pool.preemptible
      pod_range          = node_pool.pod_range
    }
  ]

  node_pools_labels = {
    all = var.tags
  }

  node_pools_taints = {
    for key, node_pool in var.node_pools :
    key => node_pool.taints
  }
}

// Make sure the kubeconfig file always exists.
// This is necessary because running 'terraform init' may replace the directory containing it when run.
resource "null_resource" "kubeconfig" {
  depends_on = [
    module.main.cluster_id // Do not run before the GKE cluster is up.
  ]
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.name} --project ${var.project_id} --region ${var.region}"
    environment = {
      CLUSTER_NAME = var.name,
      KUBECONFIG   = local.path_to_kubeconfig_file,
      REGION       = var.region,
    }
  }
}

data "external" "external_ips" {
  depends_on = [
    module.main
  ]
  program = ["bash", "-c", "gcloud compute instances list --filter=\"name~${var.name}\" --format=\"json(networkInterfaces[0].accessConfigs[0].natIP)\" |  jq 'to_entries | map({key: (.key|tostring), value: (.value|tostring)}) | from_entries'"]
}

locals {
  external_ips = [
    for value in data.external.external_ips.result : jsondecode(value).networkInterfaces[0].accessConfigs[0].natIP
  ]
}