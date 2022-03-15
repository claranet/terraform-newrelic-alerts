#! /usr/bin/env bash

for module in modules/* ; do
    terraform-docs markdown "${module}"
done
