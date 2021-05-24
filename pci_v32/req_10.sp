locals {
  pci_v32_10_common_tags = merge(local.pci_v32_common_tags, {
    pci_requirement = "10"
  })
}

locals {
  pci_v32_10_1_common_tags = merge(local.pci_v32_10_common_tags, {
    pci_item_id = "10.1"
  })
}

benchmark "pci_v32_10" {
  title         = "10 Track and monitor all access to network resources and cardholder data"
  #documentation = file("./pci_v32/docs/pci_v32_10.md")
  children = [
    benchmark.pci_v32_10_1,
  ]
  tags          = local.pci_v32_10_common_tags
}

benchmark "pci_v32_10_1" {
  title         = "10.1 Implement audit trails to link all access to system components to each individual user"
  description   = "It is critical to have a process or system that links user access to system components accessed. This system generates audit logs and provides the ability to trace back suspicious activity to a specific user."
  #documentation = file("./pci_v32/docs/pci_v32_10_1.md")
  children = [
    control.pci_v32_10_1_sql_server_auditing_on,
    control.pci_v32_10_1_storage_account_blob_logging_enabled,
    control.pci_v32_10_1_storage_account_queue_logging_enabled
  ]
  tags          = local.pci_v32_10_1_common_tags
}

control "pci_v32_10_1_storage_account_queue_logging_enabled" {
  title         = "Ensure Storage logging is enabled for Queue service for read, write, and delete requests"
  description   = control.cis_v130_3_3.description
  sql           = query.storage_account_queue_services_logging_enabled.sql
  documentation = control.cis_v130_3_3.documentation

  tags = merge(local.pci_v32_10_1_common_tags, {
    resource = "storage_account"
    service  = "storage"
  })
}

control "pci_v32_10_1_storage_account_blob_logging_enabled" {
  title         = "Ensure Storage logging is enabled for Blob service for read, write, and delete requests"
  description   = control.cis_v130_3_10.description
  sql           = query.storage_account_blob_service_logging_enabled.sql
  documentation = control.cis_v130_3_10.documentation

  tags = merge(local.pci_v32_10_1_common_tags, {
    resource = "storage_account"
    service  = "storage"
  })
}

control "pci_v32_10_1_sql_server_auditing_on" {
  title         = "Ensure that 'Auditing' is set to 'On'"
  #title         = "SQL server auditing should be on"
  description   = control.cis_v130_4_1_1.description
  sql           = query.sql_server_auditing_on.sql
  documentation = control.cis_v130_4_1_1.documentation

  tags = merge(local.pci_v32_10_1_common_tags, {
    resource = "sql_server"
    service  = "sql"
  })
}
