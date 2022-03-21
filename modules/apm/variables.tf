# Global Terraform
variable "environment" {
  description = "Application environment"
  type        = string
}

# NewRelic module specific

variable "appname_like" {
  description = "Query match appname"
  type        = string
  default     = ""
}

variable "policy_name" {
  description = "Alert policy name"
  type        = string
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list(string)
  default     = []
}

variable "alert_channel_ids" {
  description = "Alert channels IDs"
  type        = list(string)
  default     = []
}

#
# APP Apdex Score
#

variable "app_apdex_score_aggregation_window" {
  description = "APP Apdex Score aggregation window"
  type        = number
  default     = 60
}

variable "app_apdex_score_enabled" {
  description = "Flag to enable APP Apdex Score alert condition"
  type        = bool
  default     = true
}

variable "app_apdex_score_evaluation_delay_seconds" {
  description = "APP Apdex Score evaluation delay in seconds"
  type        = number
  default     = 180
}

variable "app_apdex_score_message" {
  description = "Custom message for the APP Apdex Score alert condition"
  type        = string
  default     = "Apdex is low"
}

variable "app_apdex_score_runbook_url" {
  description = "Runbook URL associated to the APP Apdex Score alert condition"
  type        = string
  default     = ""
}

variable "app_apdex_score_t_threshold" {
  description = "APP Apdex Score T threshold"
  type        = number
  default     = 0.5
}

variable "app_apdex_score_threshold_duration_critical" {
  description = "APP Apdex Score critical threshold duration"
  type        = number
  default     = 300
}

variable "app_apdex_score_threshold_duration_warning" {
  description = "APP Apdex Score warning threshold duration"
  type        = number
  default     = 600
}

variable "app_apdex_score_threshold_critical" {
  description = "APP Apdex Score critical threshold"
  type        = number
  default     = 0.7
}

variable "app_apdex_score_threshold_warning" {
  description = "APP Apdex Score warning threshold"
  type        = number
  default     = 0.85
}

variable "app_apdex_score_violation_time_limit_seconds" {
  description = "APP Apdex Score violation time limit seconds"
  type        = number
  default     = 3600
}
