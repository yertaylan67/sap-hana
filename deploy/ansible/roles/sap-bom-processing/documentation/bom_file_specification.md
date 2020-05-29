### <img src="../../../../../../documentation/assets/UnicornSAPBlack256x256.png" width="64px"> SAP Automation > V2 <!-- omit in toc -->
# Getting Started <!-- omit in toc -->

Master Branch's status: [![Build Status](https://dev.azure.com/azuresaphana/Azure-SAP-HANA/_apis/build/status/Azure.sap-hana.v2?branchName=master)](https://dev.azure.com/azuresaphana/Azure-SAP-HANA/_build/latest?definitionId=6&branchName=master)

<br>

## Table of contents <!-- omit in toc -->
- [Getting Started](#getting-started)
- [Dictionary - billOfMaterials](#dictionary---billofmaterials)

<br>

## Getting Started


## Dictionary - billOfMaterials

| Field       | Type    | Description                                                                              |
| :---        | :---    | :---                                                                                     |
| url         | String  | (Required) Customer Storage Accounmt Location URL                                        |
| filename    | String  | (Required) Target filename after download                                                |
| permissions | String  | (Optional) File permissions in octal;                                   (Default: 0644)  |
| extractDIR  | String  | (Optional) Target directory for file extract)                                            |
| creates     | String  | (Optional) Relative path filename to indicate if extract was performed)                  |
| download    | Boolean | (Optional) Enable / Disable the download of the software to the server  (Default: true)  |
| sourceUrl   | String  | (Optional) SAP media source software URL                                                 |

```
# billOfMaterials:
# - url:            ''          (Required: Source URL)
#   fileName:       ''          (Required: Target filename after download; Full path)
#   permissions:    ''          (Optional: File permissions in octal;         Default: 0644)
#   extractDir:     ''          (Optional: Target directory for file extract)
#   creates:        ''          (Optional: Full path filename to indicate if extract was performed)
#   download:       true/false  (Optional: ; Default: true)
```


```
# /*---------------------------------------------------------------------------8
# |                                                                            |
# |                               BASE INSTALL                                 |
# |                                                                            |
# +------------------------------------4--------------------------------------*/
billOfMaterials:
# SAPCAR 7.21
- url:            'https://zscuslib4ea13ea2fccf9835.blob.core.windows.net/sapbits/sapfiles/SAPCAR_1311-80000935.EXE'
  fileName:       '/usr/sap/install/downloads/SAPCAR'
  permissions:    '0755'
```



