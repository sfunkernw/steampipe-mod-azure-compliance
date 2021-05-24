locals {
  pci_v321_common_tags = {
    benchmark   = "pci"
    pci_version = "v3.2.1"
    plugin      = "azure"
  }
}

benchmark "pci_v321" {
  title         = "PCI v3.2.1"
  description   = "The Payment Card Industry Data Security Standard (PCI DSS) standard in Security Hub consists of a set of AWS security best practices controls. Each control applies to a specific AWS resource, and relates to one or more PCI DSS version 3.2.1 requirements. A PCI DSS requirement can be related to multiple controls."
  #documentation = file("./pci_v321/docs/pci-overview.md")
  children = [
    benchmark.pci_v321_10,
    benchmark.pci_v321_11
  ]
  tags = local.pci_v321_common_tags
}
