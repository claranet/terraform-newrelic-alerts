resource "newrelic_alert_policy" "main_policy" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.policy_name}"
}

resource "newrelic_alert_policy_channel" "main_policy_alert_channels" {
  policy_id   = newrelic_alert_policy.main_policy.id
  channel_ids = var.alert_channel_ids
}

resource "newrelic_nrql_alert_condition" "app_apdex_score_alert" {
  count       = var.app_apdex_score_enabled ? 1 : 0
  name        = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.app_apdex_score_message}"
  description = var.app_apdex_score_message
  runbook_url = var.app_apdex_score_runbook_url

  type                         = "static"
  policy_id                    = newrelic_alert_policy.main_policy.id
  violation_time_limit_seconds = var.app_apdex_score_violation_time_limit_seconds
  aggregation_window           = var.app_apdex_score_aggregation_window
  aggregation_method           = "event_flow"
  aggregation_delay            = var.app_apdex_score_evaluation_delay_seconds

  nrql {
    query = <<-EOQ
      SELECT apdex(duration, t:${var.app_apdex_score_t_threshold}) FROM Transaction WHERE appName like '${local.appname_like}'
EOQ
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
