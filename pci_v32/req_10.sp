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
  title         = "Storage account queue logging should be enabled"
  description   = "Storage account queue logging should be enabled."
  sql           = query.storage_account_queue_services_logging_enabled.sql
  #documentation = file("./pci_v32/docs/pci_v32_10_1_storage_account_queue_logging_enabled.md")

  tags = merge(local.pci_v32_10_1_common_tags, {
    resource = "storage_account"
    service  = "storage"
  })
}

control "pci_v32_10_1_storage_account_blob_logging_enabled" {
  title         = "Storage account blob logging should be enabled"
  description   = "Storage account blob logging should be enabled."
  sql           = query.storage_account_blob_service_logging_enabled.sql
  #documentation = file("./pci_v32/docs/pci_v32_10_1_storage_account_blob_logging_enabled.md")

  tags = merge(local.pci_v32_10_1_common_tags, {
    resource = "storage_account"
    service  = "storage"
  })
}

control "pci_v32_10_1_sql_server_auditing_on" {
  title         = "SQL server auditing should be on"
  description   = "SQL server auditing should be on."
  sql           = query.sql_server_auditing_on.sql
  #documentation = file("./pci_v32/docs/pci_v32_10_1_sql_server_auditing_on.md")

  tags = merge(local.pci_v32_10_1_common_tags, {
    resource = "sql_server"
    service  = "sql"
  })
}
