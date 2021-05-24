locals {
  pci_v321_11_common_tags = merge(local.pci_v321_common_tags, {
    pci_requirement = "11"
  })
}

locals {
  pci_v321_11_2_common_tags = merge(local.pci_v321_11_common_tags, {
    pci_item_id = "11.2"
  })
}

benchmark "pci_v321_11" {
  title         = "11 Regularly test security systems and processes"
  #documentation = file("./pci_v321/docs/pci_v321_11.md")
  children = [
    benchmark.pci_v321_11_2,
  ]
  tags          = local.pci_v321_11_common_tags
}

benchmark "pci_v321_11_2" {
  title         = "11.2 Run internal and external network vulnerability scans at least quarterly and after any significant change in the network"
  description   = "A vulnerability scan is a combination of automated or manual tools, techniques, and/or methods run against external and internal network devices and servers, designed to expose potential vulnerabilities that could be found and exploited by malicious individuals."
  #documentation = file("./pci_v321/docs/pci_v321_11_2.md")
  children = [
    control.pci_v321_11_2_network_watcher_enabled,
  ]
  tags          = local.pci_v321_11_2_common_tags
}

control "pci_v321_11_2_network_watcher_enabled" {
  title         = "Network watcher should be enabled"
  description   = "Network watcher should be enabled."
  sql           = query.network_watcher_enabled.sql
  #documentation = file("./pci_v321/docs/pci_v321_11_2_network_watcher_enabled.md")

  tags = merge(local.pci_v321_11_2_common_tags, {
    resource = "network_watcher"
    service  = "network"
  })
}
