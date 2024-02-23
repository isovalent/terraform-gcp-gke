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

variable "enable_workload_identity" {
  default     = false
  description = "Whether to enable workload identity. If enabled, 'netd' is deployed by GKE."
  type        = bool
}

variable "additional_ip_range_pods" {
  description = "additional_ip_range_pods"
  type        = list(any)
  default     = []
}

variable "kubernetes_version" {
  description = "The version of Kubernetes/GKE to use."
  type        = string
}

variable "name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "node_pools" {
  description = "A map describing the set of node pools to create."
  type = map(object({
    auto_upgrade     = bool
    auto_repair      = bool
    image_type       = string
    instance_type    = string
    max_nodes        = number
    min_nodes        = number
    preemptible      = bool
    root_volume_size = number
    root_volume_type = string
    taints = list(object({
      effect = string
      key    = string
      value  = string
    }))
  }))
}

variable "pod_cidr_name" {
  description = "The name of the secondary CIDR used for pods. Must be created separately as a secondary CIDR on the subnet used for the cluster."
  type        = string
}

variable "service_cidr_name" {
  description = "The name of the secondary CIDR used for services. Must be created separately as a secondary CIDR on the subnet used for the cluster."
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which to create the GKE cluster."
  type        = string
}

variable "release_channel" {
  default     = "STABLE"
  description = "The release channel to use (one of 'STABLE', 'RAPID' or 'REGULAR')"
  type        = string
}

variable "region" {
  description = "The region in which to create the GKE cluster."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which to create the GKE cluster."
  type        = string
}

variable "tags" {
  description = "The set of tags to place on the GKE cluster."
  type        = map(string)
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the GKE cluster."
  type        = string
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the GKE cluster."
  type        = bool
  default     = false
}


