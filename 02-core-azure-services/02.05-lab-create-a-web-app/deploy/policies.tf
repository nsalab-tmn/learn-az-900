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

resource "azurerm_policy_definition" "allowed-serverfarms-os-definition" {   
  name         = "serverfarms-os-policy-definition-${var.instance_id}"
  policy_type  = "Custom"
  mode         = "All"
  display_name  = "serverfarms-os-policy"
  policy_rule = <<POLICY_RULE
	  {
  	"if": {
           "allOf": [
                       {
                        "field": "type",
                         "equals": "Microsoft.Web/serverfarms"                   
                       },
                        {
                        "not": {
                                "field": "kind",
                                "equals": "linux"                                
                                }
                         } 
                    ]
        },
            "then": {
                "effect": "Deny"
            }
    }
POLICY_RULE
}

resource "azurerm_policy_definition" "allowed-serverfarms-sku-definition" {   
  name         = "serverfarms-sku-policy-definition-${var.instance_id}"
  policy_type  = "Custom"
  mode         = "All"
  display_name  = "serverfarms-sku-policy"
  policy_rule = <<POLICY_RULE
	  {
  	"if": {
           "allOf": [
                       {
                        "field": "type",
                         "equals": "Microsoft.Web/serverfarms"                   
                       },
                        {
                        "not": {
                                "field": "Microsoft.Web/serverfarms/sku.name",
                                "equals": "F1"                              
                                }
                         } 
                    ]
        },
            "then": {
                "effect": "Deny"
            }
    }
POLICY_RULE
}