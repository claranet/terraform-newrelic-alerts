output "appname_like" {
  value = local.appname_like
}

output "bh_alert_policy" {
  description = "business hours alert policy"
  value       = newrelic_alert_policy.bh_policy
}

output "nbh_alert_policy" {
  description = "non business hours alert policy"
  value       = newrelic_alert_policy.nbh_policy
}

output "app_apdex_score_bh_alert" {
  #count       = var.app_apdex_score_enabled && ! var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  description = "business hours app apdex score alert"
  value       = newrelic_nrql_alert_condition.app_apdex_score_bh_alert.*
}

output "app_apdex_score_nbh_alert_warning" {
  #count       = var.app_apdex_score_enabled && var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  description = "business hours app apdex score warning alert"
  value       = newrelic_nrql_alert_condition.app_apdex_score_nbh_alert_warning.*
}

output "app_apdex_score_nbh_alert_critical" {
  #count       = var.app_apdex_score_enabled && var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  description = "business hours app apdex score critical alert"
  value       = newrelic_nrql_alert_condition.app_apdex_score_nbh_alert_critical.*
}
