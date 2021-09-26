## Django auto-provisioning for EC2


#### Description

The included file cloudformation-template-image.yml is a Cloudformation template image. To provision the Django container, web instance and RDS instance, launch a new Cloudformation using the template image.

The provisioning scheme is based on the walkthrough here: https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/ However, I have taken a few liberties (for example, excluding nginx).

#### Prerequisites

Provisioning relies on the custom AMI ami-0ba8868be888e4e18. This AMI is set to public and should be accessed seemlessly.

Select region us-east-1.

