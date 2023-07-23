variable "instance_id" {
    type        = string
    default     = "user01_1111"
}

variable "tp_name" {
    type        = string
    default     = "smpl_lab"
}

variable "tp_learn_env" {
    type        = string
    default     = "dev"
}

variable "tp_learn_user" {
    type        = string
    default     = "user01"
}

variable "AZURE_SUBSCRIPTION_ID" {
    type        = string
}

variable "AZURE_SERVICE_PRINCIPLE_ID" {
    type        = string
}

variable "AZURE_SERVICE_PRICIPLE_PASSWORD" {
    type        = string
}

variable "AZURE_TENANT_ID" {
    type        = string
}
