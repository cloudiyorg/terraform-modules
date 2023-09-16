#! /bin/bash
aws s3 cp modules s3://cloudiy-terraform-files/ --recursive --profile cloudiy
aws s3 cp infrastructure s3://cloudiy-terraform-files/ --recursive --profile cloudiy