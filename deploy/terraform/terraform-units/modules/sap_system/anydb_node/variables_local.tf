variable "resource-group" {
  description = "Details of the resource group"
}

variable "vnet-sap" {
  description = "Details of the SAP VNet"
}

variable "storage-bootdiag" {
  description = "Details of the boot diagnostics storage account"
}

variable "ppg" {
  description = "Details of the proximity placement group"
}

variable "random-id" {
  description = "Random hex string"
}

variable "region_mapping" {
  type        = map(string)
  description = "Region Mapping: Full = Single CHAR, 4-CHAR"

  // 28 Regions 

  default = {
    westus             = "weus"
    westus2            = "wus2"
    centralus          = "ceus"
    eastus             = "eaus"
    eastus2            = "eus2"
    northcentralus     = "ncus"
    southcentralus     = "scus"
    westcentralus      = "wcus"
    northeurope        = "noeu"
    westeurope         = "weeu"
    eastasia           = "eaas"
    southeastasia      = "seas"
    brazilsouth        = "brso"
    japaneast          = "jpea"
    japanwest          = "jpwe"
    centralindia       = "cein"
    southindia         = "soin"
    westindia          = "wein"
    uksouth2           = "uks2"
    uknorth            = "ukno"
    canadacentral      = "cace"
    canadaeast         = "caea"
    australiaeast      = "auea"
    australiasoutheast = "ause"
    uksouth            = "ukso"
    ukwest             = "ukwe"
    koreacentral       = "koce"
    koreasouth         = "koso"
  }
}

locals {
  region         = try(var.infrastructure.region, "")
  landscape      = lower(try(var.infrastructure.landscape, ""))
  sid            = upper(try(var.application.sid, ""))
  codename       = lower(try(var.infrastructure.codename, ""))
  location_short = lower(try(var.region_mapping[local.region], "unkn"))
  // Using replace "--" with "-"  in case of one of the components like codename is empty
  prefix    = try(var.infrastructure.resource_group.name, upper(replace(format("%s-%s_%s-%s", local.landscape, local.location_short, local.codename, local.sid), "_-", "-")))
  sa_prefix = lower(replace(format("%s%s%sdiag", substr(local.landscape, 0, 5), local.location_short, substr(local.codename, 0, 7)), "--", "-"))

  // DB subnet
  var_sub_db    = try(var.infrastructure.vnets.sap.subnet_db, {})
  sub_db_exists = try(local.var_sub_db.is_existing, false)
  sub_db_arm_id = local.sub_db_exists ? try(local.var_sub_db.arm_id, "") : ""
  sub_db_name   = local.sub_db_exists ? try(split("/", local.sub_db_arm_id)[10], "") : try(local.var_sub_db.name, format("%s_db-subnet", local.prefix))
  sub_db_prefix = local.sub_db_exists ? "" : try(local.var_sub_db.prefix, "")

  // DB NSG
  var_sub_db_nsg    = try(var.infrastructure.vnets.sap.subnet_db.nsg, {})
  sub_db_nsg_exists = try(local.var_sub_db_nsg.is_existing, false)
  sub_db_nsg_arm_id = local.sub_db_nsg_exists ? try(local.var_sub_db_nsg.arm_id, "") : ""
  sub_db_nsg_name   = local.sub_db_nsg_exists ? try(split("/", local.sub_db_nsg_arm_id)[8], "") : try(local.var_sub_db_nsg.name, format("%s_dbSubnet-nsg", local.prefix))

  // Imports database sizing information
  sizes = jsondecode(file("${path.module}/../../../../../configs/anydb_sizes.json"))

  // PPG Information
  ppgId = lookup(var.infrastructure, "ppg", false) != false ? (var.ppg[0].id) : null

  anydb          = try(local.anydb-databases[0], {})
  anydb_platform = try(local.anydb.platform, "NONE")
  anydb_version  = try(local.anydb.db_version, "")

  // Filter the list of databases to only AnyDB platform entries
  // Supported databases: Oracle, DB2, SQLServer, ASE 
  anydb-databases = [
    for database in var.databases : database
    if contains(["ORACLE", "DB2", "SQLSERVER", "ASE"], upper(try(database.platform, "NONE")))
  ]

  // Enable deployment based on length of local.anydb-databases
  enable_deployment = (length(local.anydb-databases) > 0) ? true : false

  // If custom image is used, we do not overwrite os reference with default value
  anydb_custom_image = try(local.anydb.os.source_image_id, "") != "" ? true : false

  anydb_ostype = try(local.anydb.os.os_type, "Linux")
  anydb_size   = try(local.anydb.size, "500")
  anydb_sku    = try(lookup(local.sizes, local.anydb_size).compute.vmsize, "Standard_E4s_v3")
  anydb_fs     = try(local.anydb.filesystem, "xfs")
  anydb_ha     = try(local.anydb.high_availability, "false")
  anydb_sid    = (length(local.anydb-databases) > 0) ? try(local.anydb.instance.sid, lower(substr(local.anydb_platform, 0, 3))) : lower(substr(local.anydb_platform, 0, 3))
  loadbalancer = try(local.anydb.loadbalancer, {})

  authentication = try(local.anydb.authentication,
    {
      "type"     = upper(local.anydb_ostype) == "LINUX" ? "key" : "password"
      "username" = "azureadm"
      "password" = "Sap@hana2019!"
  })

  anydb_cred           = try(local.anydb.credentials, {})
  db_systemdb_password = try(local.anydb_cred.db_systemdb_password, "")

  // Default values in case not provided
  os_defaults = {
    ORACLE = {
      "publisher" = "Oracle",
      "offer"     = "Oracle-Linux",
      "sku"       = "77",
      "version"   = "latest"
    }
    DB2 = {
      "publisher" = "suse",
      "offer"     = "sles-sap-12-sp5",
      "sku"       = "gen1"
      "version"   = "latest"
    }
    ASE = {
      "publisher" = "suse",
      "offer"     = "sles-sap-12-sp5",
      "sku"       = "gen1"
      "version"   = "latest"
    }
    SQLSERVER = {
      "publisher" = "MicrosoftSqlServer",
      "offer"     = "SQL2017-WS2016",
      "sku"       = "standard-gen2",
      "version"   = "latest"
    }
    NONE = {
      "publisher" = "",
      "offer"     = "",
      "sku"       = "",
      "version"   = ""
    }
  }

  anydb_os = {
    "source_image_id" = local.anydb_custom_image ? local.anydb.os.source_image_id : ""
    "publisher"       = try(local.anydb.os.publisher, local.anydb_custom_image ? "" : local.os_defaults[upper(local.anydb_platform)].publisher)
    "offer"           = try(local.anydb.os.offer, local.anydb_custom_image ? "" : local.os_defaults[upper(local.anydb_platform)].offer)
    "sku"             = try(local.anydb.os.sku, local.anydb_custom_image ? "" : local.os_defaults[upper(local.anydb_platform)].sku)
    "version"         = try(local.anydb.os.version, local.anydb_custom_image ? "" : local.os_defaults[upper(local.anydb_platform)].version)
  }

  // Update database information with defaults
  anydb_database = merge(local.anydb,
    { platform = local.anydb_platform },
    { db_version = local.anydb_version },
    { size = local.anydb_size },
    { os = merge({ os_type = local.anydb_ostype }, local.anydb_os) },
    { filesystem = local.anydb_fs },
    { high_availability = local.anydb_ha },
    { authentication = local.authentication },
    { credentials = {
      db_systemdb_password = local.db_systemdb_password
      }
    },
    { dbnodes = local.dbnodes },
    { loadbalancer = local.loadbalancer }
  )

  dbnodes = [for dbnode in try(local.anydb.dbnodes, []) : {
    "name"       = try(dbnode.name, format("%sdb%s", lower(local.sid), lower(local.anydb_sid)))
    "role"       = try(dbnode.role, "worker"),
    "db_nic_ips" = try(dbnode.db_nic_ips, [false, false])
    }
  ]

  anydb_vms = flatten([
    [
      for database in local.anydb-databases : [
        for idx, dbnode in local.dbnodes : {
          platform       = local.anydb_platform,
          name           = format("%s00%s0%s", dbnode.name, upper(local.anydb_ostype) == "WINDOWS" ? "w" : "l", substr(var.random-id.hex, 0, 3))
          db_nic_ip      = dbnode.db_nic_ips[0],
          size           = local.anydb_sku
          os             = local.anydb_ostype,
          authentication = local.authentication
          sid            = local.anydb_sid
        }
      ]
    ],
    [
      for database in local.anydb-databases : [
        for idx, dbnode in local.dbnodes : {
          platform       = local.anydb_platform,
          name           = format("%s01%s1%s", dbnode.name, upper(local.anydb_ostype) == "WINDOWS" ? "w" : "l", substr(var.random-id.hex, 0, 3))
          db_nic_ip      = dbnode.db_nic_ips[1],
          size           = local.anydb_sku,
          os             = local.anydb_ostype,
          authentication = local.authentication
          sid            = local.anydb_sid
        }
      ]
      if database.high_availability
    ]
  ])

  // Ports used for specific DB Versions
  lb_ports = {
    "ASE" = [
      "1433"
    ]
    "ORACLE" = [
      "1521"
    ]
    "DB2" = [
      "62500"
    ]
    "SQLServer" = [
      "59999"
    ]
    "NONE" = [
      "80"
    ]
  }

  loadbalancer_ports = flatten([
    for port in local.lb_ports[upper(local.anydb_platform)] : {
      port = tonumber(port)
    }
  ])

  anydb_disks = flatten([
    for vm_counter, anydb_vm in local.anydb_vms : [
      for storage_type in lookup(local.sizes, local.anydb_size).storage : [
        for disk_count in range(storage_type.count) : {
          vm_index                  = vm_counter
          name                      = format("%s_%s-%s%02d", local.prefix, anydb_vm.name, storage_type.name, (disk_count))
          storage_account_type      = storage_type.disk_type
          disk_size_gb              = storage_type.size_gb
          caching                   = storage_type.caching
          write_accelerator_enabled = storage_type.write_accelerator
        }
      ]
      if storage_type.name != "os"
  ]])
}
