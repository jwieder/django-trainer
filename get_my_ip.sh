#!/bin/bash
# Get my public IP
publicIP=$(curl -s whatismyip.akamai.com)
# Update host name
echo DJANGO_ALLOWED_HOSTS=${publicIP}