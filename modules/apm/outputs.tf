output "appname_like" {
  value = local.appname_like
}

output "alert_policy" {
  description = "alert policy"
  value       = newrelic_alert_policy.main_policy
}

output "app_apdex_score_alert" {
  description = "app apdex score alert"
  value       = newrelic_nrql_alert_condition.app_apdex_score_alert.*
}
