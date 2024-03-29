
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.73"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id = var.AZURE_SUBSCRIPTION_ID
  client_id       = var.AZURE_SERVICE_PRINCIPLE_ID
  client_secret   = var.AZURE_SERVICE_PRICIPLE_PASSWORD
  tenant_id       = var.AZURE_TENANT_ID
}

resource "azurerm_resource_group" "learn" {
  name     = "rg-${var.instance_id}"
  location = "eastus"
  tags     = {
    Environment: "${var.tp_learn_env}"
    Owner: "${var.tp_learn_user}"
  }
}

resource "random_string" "learn" {
  length           = 16
  special          = false
  min_lower        = 2
  min_numeric      = 2
  min_upper        = 2
  min_special      = 1
  override_special = "+-=%#^@"
}

resource "azuread_user" "learn" {
  user_principal_name = "${var.instance_id}@nsalab.org"
  display_name        = "${var.instance_id}"
  mail_nickname       = "${var.instance_id}"
  password            = random_string.learn.result
}

resource "azurerm_role_assignment" "learn" {
  scope                = azurerm_resource_group.learn.id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.learn.object_id
}

resource "azurerm_resource_group_policy_assignment" "allowed-location-assignment" {
  name                 = "policy-location-assignment-${var.instance_id}"
  resource_group_id    = azurerm_resource_group.learn.id
  policy_definition_id = azurerm_policy_definition.allowed-location-definition.id
}
