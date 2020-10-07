locals {
  appname_like = var.appname_like == "" ? format("%%%s%%", var.environment) : var.appname_like
}
