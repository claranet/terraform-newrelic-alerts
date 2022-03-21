terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">= 2.39.0"
    }
  }
  required_version = ">= 0.12.26"
}
