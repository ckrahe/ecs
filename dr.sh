#!/bin/bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].[PrivateIpAddress,State.Name,Tags[?Key==`Name`].Value[]]' \
  --output text | sed 's/None$/None\n/' | sed '$!N;s/\n/ /' | sed 's/running/R/' | sed 's/stopped/./' | \
  sort -k3 | fgrep R