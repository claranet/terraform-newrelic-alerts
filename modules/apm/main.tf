#
# Business hours alert policy
#

resource "newrelic_alert_policy" "bh_policy" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.policy_name} (BH)"
}

resource "newrelic_nrql_alert_condition" "app_apdex_score_bh_alert" {
  count       = var.app_apdex_score_enabled && ! var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  name        = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.app_apdex_score_message}"
  description = var.app_apdex_score_message
  runbook_url = var.app_apdex_score_runbook_url

  type                 = "static"
  policy_id            = newrelic_alert_policy.bh_policy.id
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

resource "newrelic_nrql_alert_condition" "app_apdex_score_nbh_alert_warning" {
  count       = var.app_apdex_score_enabled && var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  name        = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.app_apdex_score_message} (warning)"
  description = var.app_apdex_score_message
  runbook_url = var.app_apdex_score_runbook_url

  type                 = "static"
  policy_id            = newrelic_alert_policy.bh_policy.id
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
    threshold             = var.app_apdex_score_threshold_warning
    threshold_duration    = var.app_apdex_score_threshold_duration_warning
    threshold_occurrences = "ALL"
  }
}

resource "newrelic_alert_policy_channel" "app_apdex_bh_alert_channels" {
  count       = var.app_apdex_score_enabled ? 1 : 0
  policy_id   = newrelic_alert_policy.bh_policy.id
  channel_ids = var.bh_alert_channel_ids
}

#
# Non-business hours alert policy
#

resource "newrelic_alert_policy" "nbh_policy" {
  count = var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  name  = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.policy_name} (NBH)"
}

resource "newrelic_nrql_alert_condition" "app_apdex_score_nbh_alert_critical" {
  count       = var.app_apdex_score_enabled && var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  name        = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ${var.app_apdex_score_message} (critical)"
  description = var.app_apdex_score_message
  runbook_url = var.app_apdex_score_runbook_url

  type                 = "static"
  policy_id            = newrelic_alert_policy.nbh_policy[0].id
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
}

resource "newrelic_alert_policy_channel" "app_apdex_nbh_alert_channels" {
  count       = var.app_apdex_score_enabled && var.app_apdex_score_nbh_alerts_enabled ? 1 : 0
  policy_id   = newrelic_alert_policy.nbh_policy[0].id
  channel_ids = var.nbh_alert_channel_ids
}
