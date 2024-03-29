# APM module

## Usage

```terraform
provider "newrelic" {
  account_id    = "123456"
  api_key       = "NRAK-xxx"
  region        = "US"  # or EU
}

resource "newrelic_alert_channel" "pagerduty_bh" {
  name = "PagerDuty BH"
  type = "pagerduty"

  config {
    service_key = "xxx"
  }
}

resource "newrelic_alert_channel" "pagerduty_nbh" {
  name = "PagerDuty NBH"
  type = "pagerduty"

  config {
    service_key = "xxx"
  }
}

module "newrelic_alerts_webfront_bh" {
  source      = "github.com/claranet/terraform-newrelic-alerts//modules/apm"
  environment = "production"
  policy_name = "APM anomalies detected (BH)"

  alert_channel_ids = [newrelic_alert_channel.pagerduty_bh.id]

  app_apdex_score_threshold_duration_critical = 300
  app_apdex_score_threshold_critical          = 0.85
}

module "newrelic_alerts_webfront_nbh" {
  source      = "github.com/claranet/terraform-newrelic-alerts//modules/apm"
  environment = "production"
  policy_name = "APM anomalies detected (NBH)"

  alert_channel_ids = [newrelic_alert_channel.pagerduty_nbh.id]

  app_apdex_score_threshold_duration_critical = 600
  app_apdex_score_threshold_critical          = 0.7
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| newrelic | >= 2.39.0 |

## Providers

| Name | Version |
|------|---------|
| newrelic | >= 2.39.0 |

## Resources

| Name | Type |
|------|------|
| [newrelic_alert_policy.main_policy](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy) | resource |
| [newrelic_alert_policy_channel.main_policy_alert_channels](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy_channel) | resource |
| [newrelic_nrql_alert_condition.app_apdex_score_alert](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alert\_channel\_ids | Alert channels IDs | `list(string)` | `[]` | no |
| app\_apdex\_score\_aggregation\_window | APP Apdex Score aggregation window | `number` | `60` | no |
| app\_apdex\_score\_enabled | Flag to enable APP Apdex Score alert condition | `bool` | `true` | no |
| app\_apdex\_score\_evaluation\_delay\_seconds | APP Apdex Score evaluation delay in seconds | `number` | `180` | no |
| app\_apdex\_score\_message | Custom message for the APP Apdex Score alert condition | `string` | `"Apdex is low"` | no |
| app\_apdex\_score\_runbook\_url | Runbook URL associated to the APP Apdex Score alert condition | `string` | `""` | no |
| app\_apdex\_score\_t\_threshold | APP Apdex Score T threshold | `number` | `0.5` | no |
| app\_apdex\_score\_threshold\_critical | APP Apdex Score critical threshold | `number` | `0.7` | no |
| app\_apdex\_score\_threshold\_duration\_critical | APP Apdex Score critical threshold duration | `number` | `300` | no |
| app\_apdex\_score\_threshold\_duration\_warning | APP Apdex Score warning threshold duration | `number` | `600` | no |
| app\_apdex\_score\_threshold\_warning | APP Apdex Score warning threshold | `number` | `0.85` | no |
| app\_apdex\_score\_violation\_time\_limit\_seconds | APP Apdex Score violation time limit seconds | `number` | `3600` | no |
| appname\_like | Query match appname | `string` | `""` | no |
| environment | Application environment | `string` | n/a | yes |
| policy\_name | Alert policy name | `string` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| alert\_policy | alert policy |
| app\_apdex\_score\_alert | app apdex score alert |
| appname\_like | n/a |
<!-- END_TF_DOCS -->
