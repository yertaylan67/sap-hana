
variable environment {
  description = "Environment type (Prod, Test, Sand, QA)"
}

variable location {
  description = "Azure region"
}

variable codename {
  description = "Code name of application (optional)"
  default     = ""
}

variable management_vnet_name {
  description = "Name of Management vnet"
  default     = ""
}

variable sap_vnet_name {
  description = "Name of SAP vnet"
  default     = ""
}

variable sap_sid {
  description = "SAP SID"
  default     = ""
}

variable db_sid {
  description = "Database SID"
  default     = ""
}

variable random_id {
  type        = string
  description = "Random hex string"
}

variable db_ostype {
  description = "Database operating system"
  default     = "LINUX"
}

variable app_ostype {
  description = "Application Server operating system"
  default     = "LINUX"
}

variable db_platform {
  description = "AnyDB platform type (Oracle, DB2, SQLServer, ASE)"
  default     = "LINUX"
}

variable anchor_ostype {
  description = "Anchor Server operating system"
  default     = "LINUX"
}

variable app_server_count {
  type    = number
  default = 1
}

variable scs_server_count {
  type    = number
  default = 1
}

variable web_server_count {
  type    = number
  default = 1
}


variable db_server_count {
  type    = number
  default = 1
}

variable iscsi_server_count {
  type    = number
  default = 1
}

variable deployer_vm_count {
  type    = number
  default = 1
}

//Todo: Add to documentation
variable sapautomation_name_limits {
  description = "Name length for automation resources"
  default = {
    environment_variable_length = 5
    sap_vnet_length             = 7
    random_id_length            = 3
    sdu_name_length             = 80
  }
}

//Todo: Add to documentation
variable azlimits {
  description = "Name length for resources"
  default = {
    asr         = 50
    aaa         = 50
    acr         = 49
    afw         = 50
    rg          = 80
    kv          = 24
    stgaccnt    = 24
    vnet        = 38
    nsg         = 80
    snet        = 80
    nic         = 80
    vml         = 64
    vmw         = 15
    vm          = 80
    functionapp = 60
    lb          = 80
    lbrule      = 80
    evh         = 50
    la          = 63
    pip         = 80
    peer        = 80
    gen         = 24
  }
}

variable region_mapping {
  type        = map(string)
  description = "Region Mapping: Full = Single CHAR, 4-CHAR"
  # 42 Regions 
  default = {
    "australiacentral"   = "auce"
    "australiacentral2"  = "auc2"
    "australiaeast"      = "auea"
    "australiasoutheast" = "ause"
    "brazilsouth"        = "brso"
    "brazilsoutheast"    = "brse"
    "brazilus"           = "brus"
    "canadacentral"      = "cace"
    "canadaeast"         = "caea"
    "centralindia"       = "cein"
    "centralus"          = "ceus"
    "eastasia"           = "eaas"
    "eastus"             = "eaus"
    "eastus2"            = "eus2"
    "francecentral"      = "frce"
    "francesouth"        = "frso"
    "germanynorth"       = "geno"
    "germanywestcentral" = "gewc"
    "japaneast"          = "jaea"
    "japanwest"          = "jawe"
    "koreacentral"       = "koce"
    "koreasouth"         = "koso"
    "northcentralus"     = "ncus"
    "northeurope"        = "noeu"
    "norwayeast"         = "noea"
    "norwaywest"         = "nowe"
    "southafricanorth"   = "sano"
    "southafricawest"    = "sawe"
    "southcentralus"     = "scus"
    "southeastasia"      = "soea"
    "southindia"         = "soin"
    "switzerlandnorth"   = "swno"
    "switzerlandwest"    = "swwe"
    "uaecentral"         = "uace"
    "uaenorth"           = "uano"
    "uksouth"            = "ukso"
    "ukwest"             = "ukwe"
    "westcentralus"      = "wcus"
    "westeurope"         = "weeu"
    "westindia"          = "wein"
    "westus"             = "weus"
    "westus2"            = "wus2"
  }
}

//Todo: Add to documentation
variable resource_suffixes {
  type        = map(string)
  description = "Extension of resource name"

  default = {
    "admin_nic"           = "-admin-nic"
    "admin_subnet"        = "_admin-subnet"
    "admin_subnet_nsg"    = "_adminSubnet-nsg"
    "app_alb"             = "_app-alb"
    "app_avset"           = "_app-avset"
    "app_subnet"          = "_app-subnet"
    "app_subnet_nsg"      = "_appSubnet-nsg"
    "db_alb"              = "_db-alb"
    "db_alb_bepool"       = "_dbAlb-bePool"
    "db_alb_feip"         = "_dbAlb-feip"
    "db_alb_hp"           = "_dbAlb-hp"
    "db_alb_rule"         = "_dbAlb-rule_"
    "db_avset"            = "_db-avset"
    "db_nic"              = "-db-nic"
    "db_subnet"           = "_db-subnet"
    "db_subnet_nsg"       = "_dbSubnet-nsg"
    "deployer_rg"         = "-INFRASTRUCTURE"
    "deployer_state"      = "_DEPLOYER.terraform.tfstate"
    "deployer_subnet"     = "_deployment-subnet"
    "deployer_subnet_nsg" = "_deployment-nsg"
    "iscsi_subnet"        = "_iscsi-subnet"
    "iscsi_subnet_nsg"    = "_iscsiSubnet-nsg"
    "library_rg"          = "-SAP_LIBRARY"
    "library_state"       = "_SAP-LIBRARY.terraform.tfstate"
    "kv"                  = ""
    "msi"                 = "-msi"
    "nic"                 = "-nic"
    "osdisk"              = "-OsDisk"
    "pip"                 = "-pip"
    "ppg"                 = "-ppg"
    "storage_nic"        = "-storage-nic"
    "storage_subnet"     = "_storage-subnet"
    "storage_subnet_nsg" = "_storageSubnet-nsg"
    "scs_alb"             = "_scs-alb"
    "scs_alb_bepool"      = "_scsAlb-bePool"
    "scs_alb_feip"        = "_scsAlb-feip"
    "scs_alb_hp"          = "_scsAlb-hp"
    "scs_alb_rule"        = "_scsAlb-rule_"
    "scs_ers_feip"        = "_scsErs-feip"
    "scs_ers_hp"          = "_scsErs-hp"
    "scs_ers_rule"        = "_scsErs-rule_"
    "scs_scs_rule"        = "_scsScs-rule_"
    "sdu_rg"              = ""
    "scs_avset"           = "_scs-avset"
    "vm"                  = ""
    "vnet"                = "-vnet"
    "vnet_rg"             = "-INFRASTRUCTURE"
    "web_alb"             = "_web-alb"
    "web_alb_bepool"      = "_webAlb-bePool"
    "web_alb_feip"        = "_webAlb-feip"
    "web_alb_hp"          = "_webAlb-hp"
    "web_alb_inrule"      = "_webAlb-inRule"
    "web_avset"           = "_web-avset"
    "web_subnet"          = "_web-subnet"
    "web_subnet_nsg"      = "_webSubnet-nsg"

  }
}

variable app_zones {
  type        = list(string)
  description = "List of availability zones for application tier"
  default     = []
}

variable scs_zones {
  type        = list(string)
  description = "List of availability zones for scs tier"
  default     = []
}

variable web_zones {
  type        = list(string)
  description = "List of availability zones for web tier"
  default     = []
}

variable db_zones {
  type        = list(string)
  description = "List of availability zones for db tier"
  default     = []
}

variable custom_prefix {
  type        = string
  description = "Custom prefix"
  default     = ""
}

locals {

  location_short = upper(try(var.region_mapping[var.location], "unkn"))

  env_verified      = upper(substr(var.environment, 0, var.sapautomation_name_limits.environment_variable_length))
  vnet_verified     = upper(trim(substr(var.sap_vnet_name, 0, var.sapautomation_name_limits.sap_vnet_length), "-_"))
  dep_vnet_verified = upper(trim(substr(var.management_vnet_name, 0, var.sapautomation_name_limits.sap_vnet_length), "-_"))

  random_id_verified    = upper(substr(var.random_id, 0, var.sapautomation_name_limits.random_id_length))
  random_id_vm_verified = lower(substr(var.random_id, 0, var.sapautomation_name_limits.random_id_length))

  zones            = distinct(concat(var.db_zones, var.app_zones, var.scs_zones, var.web_zones))
  zonal_deployment = try(length(local.zones), 0) > 0 ? true : false

  //The separator to use between the prefix and resource name
  separator = "_"

}

