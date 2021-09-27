## Django auto-provisioning for EC2


#### Description

The included file cloudformation-template-image.yml is a Cloudformation template image. To provision the Django container, web instance and RDS instance, launch a new Cloudformation using the template image.

Be sure to enter valid parameters as there is no real input validation. Any SSH key can be used.

The provisioning scheme is based on the walkthrough here: https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/ However, I have taken a few liberties (for example, excluding nginx).

#### Prerequisites

Provisioning relies on the custom AMI ami-0ba8868be888e4e18. This AMI is set to public and should be accessed seemlessly.

Select region us-east-1 when deploying to Cloudformation.

Requires the creation of an IAM role named django-ec2 with AmazonEC2ContainerRegistryPowerUser permission policy assignment. This is a one-time account-level and Global setting that does . See https://testdriven.io/blog/django-docker-https-aws/#iam-role for additional details.


#### Notes

The superuser has not been created. This can be accomplished by using -it exec to run the createsuperuser script manually from within the web container after provisioning.

