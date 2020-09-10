locals {

  db_oscode       = upper(var.db_ostype) == "LINUX" ? "l" : "w"
  app_oscode      = upper(var.app_ostype) == "LINUX" ? "l" : "w"
  db_platformcode = substr(var.db_platform, 0, 3)


  //Deployer
  deployer_names = [for idx in range(var.app_server_max_count) :
    format("%s%s%sdeploy%02d", lower(local.env_verified), local.location_short, local.dep_vnet_verified, idx)
  ]

  anydb_server_names = flatten([[for idx in range(var.db_server_max_count) :
    format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(var.db_sid), idx, 0, local.random-id_verifiedvm)
    ],
    [for idx in range(var.db_server_max_count) :
      format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(var.db_sid), idx, 1, local.random-id_verifiedvm)
    ]
    ]
  )

  app_server_names = [for idx in range(var.app_server_max_count) :
    format("%sapp%02d%s%s", lower(var.sap_sid), idx, local.app_oscode, local.random-id_verifiedvm)
  ]

  iscsi_server_names = [for idx in range(var.app_server_max_count) :
    format("%s%s%siscsi%02d", lower(local.env_verified), local.vnet_verified, local.location_short , idx)
  ]


{environment[_map]}{sap_vnet}{region_map}iscsi##
  hana_server_names = flatten([[for idx in range(var.db_server_max_count) :
    format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(var.db_sid), idx, 0, local.random-id_verifiedvm)
    ],
    [for idx in range(var.db_server_max_count) :
      format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(var.db_sid), idx, 1, local.random-id_verifiedvm)
    ]
  ])

  scs_server_names = [for idx in range(var.app_server_max_count) :
    format("%sscs%02d%s%s", lower(var.sap_sid), idx, local.app_oscode, local.random-id_verifiedvm)
  ]

  web_server_names = [for idx in range(var.app_server_max_count) :
    format("%sweb%02d%s%s", lower(var.sap_sid), idx, local.app_oscode, local.random-id_verifiedvm)
  ]

}
