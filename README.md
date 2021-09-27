## Django auto-provisioning for EC2


#### Description

The provisioning scheme is based on the walkthrough here: https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/ However, I have taken a few liberties (for example, excluding nginx).

#### Prerequisites

Provisioning relies on the custom AMI ami-0ba8868be888e4e18. This AMI is set to public and can be accessed seemlessly.

Select region us-east-1 when deploying to Cloudformation.

Requires the creation of an IAM role named django-ec2 with AmazonEC2ContainerRegistryPowerUser permission policy assignment. This is a one-time account-level and Global setting that does not require recreation each time the CloudFormation is provisioned. See https://testdriven.io/blog/django-docker-https-aws/#iam-role for additional details.

#### Cloudformation Deployment Walkthrough

The included file cloudformation-template-image.yml is a Cloudformation template image. Download this repository to your local PC or copy + paste the cloudformation-template-image.yml into a text editor to save it to your local PC.

To provision the Django container, web instance and RDS instance, launch a new Cloudformation using the template image:

Select "template is ready" and "Upload a file Template". In the menu that appears, navigate to the cloudformation-template-image.yml from this repo. Click Next.

On the next page, enter any valid stack name. Be sure to enter valid parameters as there is no real input validation. Select any valid EC2 keypair. Avoid using a DBPort value that is likely to be used by another service (like 80, 22, etc). Click Next.

On the Configure stack options, leave the default options (it is okay to add Tags for asset tracking or SNS for notification, but timeout values and role assignment are part of the template). Click Next.

Double check your parameter values and the click Create stack.

Be patient with the provisioning process - the template assigns small instances and there are some slow deployment options involved in the template and docker configuration (for example, to accommodate Ubuntu 18.04 it was neccessary to manually provision aws-cfn-bootstrap-py3 from userdata). The full deployment can take 10 minutes (!). To easily monitor the deployment, click on the Events tab from within the new stack formation window. When finished, there should be a final CREATE_COMPLETE message.

To verify application availability, navigate to AWS Services -> EC2 -> Instances and select the new instance from the Cloudformation Deploy (it should be named syn-app01). Copy the Public IPv4 address and use it to navigate to a Django login page. For example, if the IP was 192.168.0.1, navigate to: http://192.168.0.1:8000 to see the debug screen and http://192.168.0.1:8000/admin to see the admin login. 

#### Notes

The superuser has not been created. This can be accomplished by using -it exec to run the createsuperuser script manually from within the web container after provisioning.

#### Additional Notes

Unfortunately, I ran out of time before I had a chance to complete the "extra credit" assignment. There were two elements to that, deploying an EBS that forwards SSL traffic to port 8000 and introducing IP limiting. The IP limiting component would be trivial to accomplish by introducing a new Parameter to the cloudformation-template-image.yml file to request users provide an IP prior to initialization, then using that value to update the EC2 Security Policy that is dynamically generated toward the end of the script - instead of allowing web ports from 0.0.0.0/0, allow web ports from the input of the new parameter. Deploying an EBS through CloudFormation is likewise fairly easy, but the SSL component would require me to introduce nginx, letsencrypt and most importantly DNS to the autoprovisioning process.

Finally, because this was a POC I left out some things I would ordinarily not leave out: regex input validation for user parameters, perhaps generating WAF rules during initialization. Overall I had a lot of fun doing this!
