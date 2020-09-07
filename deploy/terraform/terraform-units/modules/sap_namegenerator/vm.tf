locals {

  db_oscode       = upper(var.db_ostype) == "LINUX" ? "l" : "w"
  app_oscode      = upper(var.app_ostype) == "LINUX" ? "l" : "w"
  db_platformcode = substr(var.db_platform, 0, 3)


    //Deployer
  deployer_names = [for idx in range(var.app_server_max_count) :
    lower(format("%s%s%sdeploy%02d", local.env_verified, local.location_short, local.dep_vnet_verified, idx))
  ]

  anydb_server_names = flatten([[for idx in range(var.db_server_max_count) :
    lower(format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(local.db_sid), idx, 0, substr(var.random-id, 0, 3)))
    ],
    [for idx in range(var.db_server_max_count) :
      lower(format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(local.db_sid), idx, 1, substr(var.random-id, 0, 3)))
    ]
    ]
  )

  app_server_names = [for idx in range(var.app_server_max_count) :
    lower(format("%sapp%02d%s%s", lower(var.sap_sid), idx, local.app_oscode, substr(var.random-id, 0, 3)))
  ]

  hana_server_names = flatten([[for idx in range(var.db_server_max_count) :
    lower(format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(var.db_sid), idx, 0, substr(var.random-id, 0, 3)))
    ],
    [for idx in range(var.db_server_max_count) :
      lower(format("%sd%s%02dl%d%s", lower(var.sap_sid), lower(var.db_sid), idx, 1, substr(var.random-id, 0, 3)))
    ]
  ])

  scs_server_names = [for idx in range(var.app_server_max_count) :
    lower(format("%sscs%02d%s%s", lower(var.sap_sid), idx, local.app_oscode, substr(var.random-id, 0, 3)))
  ]

  web_server_names = [for idx in range(var.app_server_max_count) :
    lower(format("%sweb%02d%s%s", lower(var.sap_sid), idx, local.app_oscode, substr(var.random-id, 0, 3)))
  ]

}
