// Output IP Addresses

output "anydb_vm_names" {
  value = module.anydb_node.anydb_vm_names
}

output "anydb_computer_names" {
  value = module.anydb_node.anydb_computer_names
}

output "anydb_lb_name" {
  value = module.anydb_node.db_lb_name
}

output "anydb_admin_ip" {
  value = module.anydb_node.anydb_admin_ip
}

output "anydb_db_ip" {
  value = module.anydb_node.anydb_db_ip
}

output "anydb_lb_ip" {
  value = module.anydb_node.anydb_lb_ip
}

output "app_ip" {
  value = module.app_tier.app_ip
}

output "app_admin_ip" {
  value = module.app_tier.app_admin_ip
}

output "scs_ip" {
  value = module.app_tier.scs_ip
}

output "scs_admin_ip" {
  value = module.app_tier.scs_admin_ip
}


output "web_ip" {
  value = module.app_tier.web_ip
}

output "web_admin_ip" {
  value = module.app_tier.web_admin_ip
}

output "web_lb_ip" {
  value = module.app_tier.web_lb_ip
}

output "scs_lb_ip" {
  value = module.app_tier.scs_lb_ip
}

output "ers_lb_ip" {
  value = module.app_tier.ers_lb_ip
}

output "app_vm_names" {
  value = module.app_tier.app_vm_names
}

output "app_computer_names" {
  value = module.app_tier.app_computer_names
}

output "scs_vm_names" {
  value = module.app_tier.scs_vm_names
}

output "scs_computer_names" {
  value = module.app_tier.scs_computer_names
}

output "web_vm_names" {
  value = module.app_tier.web_vm_names
}

output "web_computer_names" {
  value = module.app_tier.web_computer_names
}

output "scs_lb_name" {
  value = module.app_tier.scs_lb_name
}

output "web_lb_name" {
  value = module.app_tier.web_lb_name
}

output "app_nics_app" {
  value = module.app_tier.nics-app
}

output "app_nics_scs" {
  value = module.app_tier.nics-scs
}

output "app_nics_web" {
  value = module.app_tier.nics-web
}

output "app_nics_app_admin" {
  value = module.app_tier.nics-app-admin
}

output "app_nics_scs_admin" {
  value = module.app_tier.nics-scs-admin
}

output "app_nics_web_admin" {
  value = module.app_tier.nics-web-admin
}

output "anydb_nics_db" {
  value = module.anydb_node.nics-anydb
}

output "anydb_nics_db_admin" {
  value = module.anydb_node.nics-anydb-admin
}


output "dns_info" {
  value = concat(
    flatten([for idx, vm in module.anydb_node.anydb_vm_names :
      {
        "${vm}" = module.anydb_node.anydb_db_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.anydb_node.anydb_vm_names :
      {
        "${vm}" = module.anydb_node.anydb_admin_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.app_tier.app_vm_names :
      {
        "${vm}" = module.app_tier.app_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.app_tier.app_vm_names :
      {
        "${vm}" = module.app_tier.app_admin_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.app_tier.scs_vm_names :
      {
        "${vm}" = module.app_tier.scs_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.app_tier.scs_vm_names :
      {
        "${vm}" = module.app_tier.scs_admin_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.app_tier.web_vm_names :
      {
        "${vm}" = module.app_tier.web_ip[idx]
      }
    ]),
    flatten([for idx, vm in module.app_tier.web_vm_names :
      {
        "${vm}" = module.app_tier.web_admin_ip[idx]
      }
    ]),
    flatten([for idx, lb in module.anydb_node.db_lb_name :
      {
        "${lb}" = module.anydb_node.anydb_lb_ip[idx]
      }
    ]),
    flatten([for idx, lb in module.app_tier.scs_lb_name :
      {
        "${lb}" = module.app_tier.scs_lb_ip[idx]
      }
    ]),
    flatten([for idx, lb in module.app_tier.scs_lb_name :
      {
        "${lb}" = module.app_tier.ers_lb_ip[idx]
      }
    ]),
    flatten([for idx, lb in module.app_tier.web_lb_name :
      {
        "${lb}" = module.app_tier.web_lb_ip[idx]
      }
    ])

  )
}
