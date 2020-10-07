resource "newrelic_alert_policy" "main_policy" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.policy_name}"
}

resource "newrelic_nrql_alert_condition" "app_apdex_score_alert" {
  count       = var.app_apdex_score_enabled == true ? 1 : 0
  name        = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.app_apdex_score_message}"
  description = var.app_apdex_score_message
  runbook_url = var.app_apdex_score_runbook_url

  type                 = "static"
  policy_id            = newrelic_alert_policy.main_policy.id
  violation_time_limit = var.app_apdex_score_violation_time_limit
  value_function       = "single_value"
  aggregation_window   = var.app_apdex_score_aggregation_window

  nrql {
    query             = <<-EOQ
      SELECT apdex(duration, t:${var.app_apdex_score_t_threshold}) FROM Transaction WHERE appName like '${local.appname_like}'
EOQ
    evaluation_offset = var.app_apdex_score_evaluation_offset
  }

  critical {
    operator              = "below"
    threshold             = var.app_apdex_score_threshold_critical
    threshold_duration    = var.app_apdex_score_threshold_duration_critical
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "below"
    threshold             = var.app_apdex_score_threshold_warning
    threshold_duration    = var.app_apdex_score_threshold_duration_warning
    threshold_occurrences = "ALL"
  }
}

