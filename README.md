# terraform-gcp-gke

An opinionated Terraform module that can be used to create and manage a GKE cluster in Google Cloud Platform in a simplified way.

## External dependencies

This module depends on the following external tools:
- [gcloud](https://cloud.google.com/sdk/gcloud)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.36.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | terraform-google-modules/kubernetes-engine/google | 30.0.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [external_external.external_ips](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_ip_range_pods"></a> [additional\_ip\_range\_pods](#input\_additional\_ip\_range\_pods) | additional\_ip\_range\_pods | `list(any)` | `[]` | no |
| <a name="input_enable_workload_identity"></a> [enable\_workload\_identity](#input\_enable\_workload\_identity) | Whether to enable workload identity. If enabled, 'netd' is deployed by GKE. | `bool` | `false` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The version of Kubernetes/GKE to use. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the GKE cluster. | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | A map describing the set of node pools to create. | <pre>map(object({<br>    auto_upgrade     = bool<br>    auto_repair      = bool<br>    image_type       = string<br>    instance_type    = string<br>    max_nodes        = number<br>    min_nodes        = number<br>    preemptible      = bool<br>    root_volume_size = number<br>    root_volume_type = string<br>    taints = list(object({<br>      effect = string<br>      key    = string<br>      value  = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_pod_cidr_name"></a> [pod\_cidr\_name](#input\_pod\_cidr\_name) | The name of the secondary CIDR used for pods. Must be created separately as a secondary CIDR on the subnet used for the cluster. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which to create the GKE cluster. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which to create the GKE cluster. | `string` | n/a | yes |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The release channel to use (one of 'STABLE', 'RAPID' or 'REGULAR') | `string` | `"STABLE"` | no |
| <a name="input_service_cidr_name"></a> [service\_cidr\_name](#input\_service\_cidr\_name) | The name of the secondary CIDR used for services. Must be created separately as a secondary CIDR on the subnet used for the cluster. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet in which to create the GKE cluster. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The set of tags to place on the GKE cluster. | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which to create the GKE cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ips"></a> [external\_ips](#output\_external\_ips) | External IPs of the nodes |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_path_to_kubeconfig_file"></a> [path\_to\_kubeconfig\_file](#output\_path\_to\_kubeconfig\_file) | n/a |
| <a name="output_zones"></a> [zones](#output\_zones) | n/a |
<!-- END_TF_DOCS -->

## License

Copyright 2022 Isovalent, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
