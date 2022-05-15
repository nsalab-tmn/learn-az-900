resource "azurerm_policy_definition" "allowed-location-definition" {
  name         = "location-policy-definition-${var.tp_name}-${var.instance_id}"
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

# resource "azurerm_policy_definition" "allowed-ostype-definition" {
#   name         = "linux-ostype-definition-${var.tp_name}-${var.instance_id}"
#   policy_type  = "Custom"
#   mode         = "All"
#   display_name  = "linux-ostype-policy"
#   policy_rule = <<POLICY_RULE
#     {
#     "if": {
#       "not": {
#         "field": "osType",
#         "equals": "Linux"
#       }
#     },
#     "then": {
#       "effect": "deny"
#     }
#   }
# POLICY_RULE
# }