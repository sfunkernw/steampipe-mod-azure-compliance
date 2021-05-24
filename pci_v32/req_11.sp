locals {
  pci_v32_11_common_tags = merge(local.pci_v32_common_tags, {
    pci_requirement = "11"
  })
}

locals {
  pci_v32_11_2_common_tags = merge(local.pci_v32_11_common_tags, {
    pci_item_id = "11.2"
  })
}

benchmark "pci_v32_11" {
  title         = "11 Regularly test security systems and processes"
  #documentation = file("./pci_v32/docs/pci_v32_11.md")
  children = [
    benchmark.pci_v32_11_2,
  ]
  tags          = local.pci_v32_11_common_tags
}

benchmark "pci_v32_11_2" {
  title         = "11.2 Run internal and external network vulnerability scans at least quarterly and after any significant change in the network"
  description   = "A vulnerability scan is a combination of automated or manual tools, techniques, and/or methods run against external and internal network devices and servers, designed to expose potential vulnerabilities that could be found and exploited by malicious individuals."
  #documentation = file("./pci_v32/docs/pci_v32_11_2.md")
  children = [
    control.pci_v32_11_2_security_center_provision_monitoring_agent_on
  ]
  tags          = local.pci_v32_11_2_common_tags
}

control "pci_v32_11_2_security_center_provision_monitoring_agent_on" {
  title         = "Ensure that 'Automatic provisioning of monitoring agent' is set to 'On'"
  description   = control.cis_v130_2_11.description
  sql           = query.securitycenter_automatic_provisioning_monitoring_agent_on.sql
  documentation = control.cis_v130_2_11.documentation

  tags = merge(local.pci_v32_11_2_common_tags, {
    resource = "security_center"
    service  = "security_center"
  })
}
