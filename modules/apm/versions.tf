terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">= 2.11.0"
    }
  }
  required_version = ">= 0.12.26"
}
