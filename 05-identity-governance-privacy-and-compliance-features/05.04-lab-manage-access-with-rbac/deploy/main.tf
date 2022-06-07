
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
}

resource "azurerm_resource_group" "learn" {
  name     = "rg-${var.tp_name}-${var.instance_id}"
  location = "eastus"
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
  user_principal_name = "${var.tp_name}-${var.instance_id}@nsalab.org"
  display_name        = "${var.tp_name}-${var.instance_id}"
  mail_nickname       = "${var.tp_name}-${var.instance_id}"
  password            = random_string.learn.result
}

resource "azurerm_role_assignment" "learn" {
  scope                = azurerm_resource_group.learn.id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.learn.object_id
}

resource "azurerm_resource_group_policy_assignment" "allowed-location-assignment" {
  name                 = "policy-location-assignment-${var.tp_name}-${var.instance_id}"
  resource_group_id    = azurerm_resource_group.learn.id
  policy_definition_id = azurerm_policy_definition.allowed-location-definition.id
}

resource "azurerm_role_definition" "allow-role-assignments" {
  name        = "allow-role-assignments-${var.instance_id}"
  scope       = azurerm_resource_group.learn.id
  description = "This is a custom role created via Terraform to allow role assignments"

  permissions {
    actions     = ["Microsoft.Authorization/roleAssignments/read", "Microsoft.Authorization/roleAssignments/write"]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_resource_group.learn.id
  ]
}

resource "azurerm_role_assignment" "allow-role-assignments" {
  scope                = azurerm_resource_group.learn.id
  role_definition_name = azurerm_role_definition.allow-role-assignments.name
  principal_id         = azuread_user.learn.object_id
}