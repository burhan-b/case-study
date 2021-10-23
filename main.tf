terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "migros-resource-group"
  location = "eastus"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["migros-subnet"]
  depends_on          = [azurerm_resource_group.example]
}


module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.example.name
  client_id                        = "MY-client_id"
  client_secret                    = "MY-client_secret"
  kubernetes_version               = "1.22.2"
  orchestrator_version             = "1.22.2"
  prefix                           = "migros"
  cluster_name                     = "mycluster" 
  network_plugin                   = "kubenet"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  os_disk_size_gb                  = 50
  sku_tier                         = "Free"
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = "null"
  rbac_aad_managed                 = false
  private_cluster_enabled          = false
  enable_http_application_routing  = false
  enable_azure_policy              = false
  enable_auto_scaling              = true
  enable_host_encryption           = true ########################################
  agents_min_count                 = 1
  agents_max_count                 = 2
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 80
  agents_pool_name                 = "exnodepool"
  agents_availability_zones        = ["1", "2"]
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "calico"
  net_profile_dns_service_ip     = "11.100.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "11.100.0.0/24"

  depends_on = [module.network]
}


