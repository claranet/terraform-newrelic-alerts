# APM module

## Usage

```terraform
provider "newrelic" {
  account_id    = "123456"
  api_key       = "NRAK-xxx"
  region        = "US"  # or EU
}

module "newrelic_alerts" {
  source      = "github.com/claranet/terraform-newrelic-alerts//modules/apm"
  environment = "production"
  policy_name = "APM anomalies detected"
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
| app\_apdex\_score\_runbook\_url | Runbook URL associated to the APP Apdex Score alert condition | `string` | `""` | no |
| app\_apdex\_score\_t\_threshold | APP Apdex Score T threshold | `number` | `0.5` | no |
| app\_apdex\_score\_threshold\_critical | APP Apdex Score critical threshold | `number` | `0.7` | no |
| app\_apdex\_score\_threshold\_duration\_critical | APP Apdex Score critical threshold duration | `number` | `300` | no |
| app\_apdex\_score\_threshold\_duration\_warning | APP Apdex Score warning threshold duration | `number` | `600` | no |
| app\_apdex\_score\_threshold\_warning | APP Apdex Score warning threshold | `number` | `0.85` | no |
| app\_apdex\_score\_violation\_time\_limit | APP Apdex Score violation time limit | `string` | `"one_hour"` | no |
| appname\_like | Query match appname | `string` | `""` | no |
| environment | Application environment | `string` | n/a | yes |
| policy\_name | Alert policy name | `string` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_apdex\_score\_alert | app apdex score alert |
| appname\_like | n/a |
| main\_alert\_policy | main alert policy |

