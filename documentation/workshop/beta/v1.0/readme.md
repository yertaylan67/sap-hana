### <img src="../../../../documentation/assets/UnicornSAPBlack256x256.png" width="64px"> SAP Automation > V1.x.x <!-- omit in toc -->
# SDU - SAP Deployment Unit <!-- omit in toc -->

Master Branch's status: [![Build Status](https://dev.azure.com/azuresaphana/Azure-SAP-HANA/_apis/build/status/Azure.sap-hana?branchName=master&api-version=5.1-preview.1)](https://dev.azure.com/azuresaphana/Azure-SAP-HANA/_build/latest?definitionId=6&branchName=master)

<br/>

## Table of contents <!-- omit in toc -->

- [Steps](#steps)
- [Overview](#overview)
- [Close Up](#close-up)
- [Deployer](#deployer)
- [SAP Library](#sap-library)
- [SAP Workload VNET](#sap-workload-vnet)
- [SDU](#sdu)

<br/><br/>

## Steps
1. [Bootstrap - Deployer](01-bootstrap-deployer.md)
2. [Bootstrap - SAP Library](02-bootstrap-library.md)
3. [Bootstrap - Reinitialize](03-reinitialize.md)
4. [Deploy SAP Workload VNET](04-workload-vnet.md)
5. [Deploy SDU](05-sdu.md)

<br/>

---

<br/>

## Overview
![Overview](assets/BlockOverview.png)

Environment
- Subscription
- Deployer
- SAP Library (1 or more regionally distributed)
- SAP Workload VNET (Harbor - Global and/or Logical Partitioning within region)
- SDU - SAP Deployment Unit (Deploys into SAP Workload VNET)

## Close Up
![Block1](assets/Block1.png)


## Deployer
![Block2](assets/Block2.png)


## SAP Library
![Block3](assets/Block3.png)


## SAP Workload VNET
![Block4](assets/Block4.png)


## SDU
![Block5]()

<br/><br/><br/><br/>


# Next: [SAP Deployment Unit - SDU](01-bootstrap-deployer.md) <!-- omit in toc -->