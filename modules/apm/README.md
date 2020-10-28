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

module "newrelic_alerts" {
  source      = "github.com/claranet/terraform-newrelic-alerts//modules/apm"
  environment = "production"
  policy_name = "APM anomalies detected"

  bh_alert_channel_ids               = [newrelic_alert_channel.pagerduty_bh.id]
  nbh_alert_channel_ids              = [newrelic_alert_channel.pagerduty_nbh.id]
  app_apdex_score_nbh_alerts_enabled = true
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| newrelic | >= 2.11.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_apdex\_score\_aggregation\_window | APP Apdex Score aggregation window | `number` | `60` | no |
| app\_apdex\_score\_enabled | Flag to enable APP Apdex Score alert condition | `bool` | `true` | no |
| app\_apdex\_score\_evaluation\_offset | APP Apdex Score evaluation offset | `number` | `3` | no |
| app\_apdex\_score\_message | Custom message for the APP Apdex Score alert condition | `string` | `"Apdex is low"` | no |
| app\_apdex\_score\_nbh\_alerts\_enabled | Flag to enable APP Apdex Score critals alerts on NBH channels | `bool` | `false` | no |
| app\_apdex\_score\_runbook\_url | Runbook URL associated to the APP Apdex Score alert condition | `string` | `""` | no |
| app\_apdex\_score\_t\_threshold | APP Apdex Score T threshold | `number` | `0.5` | no |
| app\_apdex\_score\_threshold\_critical | APP Apdex Score critical threshold | `number` | `0.7` | no |
| app\_apdex\_score\_threshold\_duration\_critical | APP Apdex Score critical threshold duration | `number` | `300` | no |
| app\_apdex\_score\_threshold\_duration\_warning | APP Apdex Score warning threshold duration | `number` | `600` | no |
| app\_apdex\_score\_threshold\_warning | APP Apdex Score warning threshold | `number` | `0.85` | no |
| app\_apdex\_score\_violation\_time\_limit | APP Apdex Score violation time limit | `string` | `"one_hour"` | no |
| appname\_like | Query match appname | `string` | `""` | no |
| bh\_alert\_channel\_ids | BH alert channels IDs | `list` | `[]` | no |
| environment | Application environment | `string` | n/a | yes |
| nbh\_alert\_channel\_ids | NBH alert channels IDs | `list` | `[]` | no |
| policy\_name | Alert policy name | `string` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_apdex\_score\_bh\_alert | business hours app apdex score alert |
| app\_apdex\_score\_nbh\_alert\_critical | business hours app apdex score critical alert |
| app\_apdex\_score\_nbh\_alert\_warning | business hours app apdex score warning alert |
| appname\_like | n/a |
| bh\_alert\_policy | business hours alert policy |
| nbh\_alert\_policy | non business hours alert policy |

