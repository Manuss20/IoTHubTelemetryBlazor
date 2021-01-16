# Create an Azure Event Hubs

resource "azurerm_eventhub_namespace" "evhubiotnmspace" {
  name                = "evhubiot"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
}

resource "azurerm_eventhub" "evhubiot" {
  name                = "example-eventhub"
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = azurerm_eventhub_namespace.evhubiotnmspace.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "evhubiotauthorize" {
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = azurerm_eventhub_namespace.evhubiotnmspace.name
  eventhub_name       = azurerm_eventhub.evhubiot.name
  name                = "acctest"
  send                = true
}