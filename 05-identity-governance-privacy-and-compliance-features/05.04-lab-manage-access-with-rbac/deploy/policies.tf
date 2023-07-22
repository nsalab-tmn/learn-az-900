resource "azurerm_policy_definition" "allowed-location-definition" {
  name         = "location-policy-definition-${var.instance_id}"
  policy_type  = "Custom"
  mode         = "All"
  display_name  = "eastus-location-policy"
  policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "location",
        "equals": "eastus"
      }
    },
    "then": {
      "effect": "deny"
    }
  }
POLICY_RULE
}
