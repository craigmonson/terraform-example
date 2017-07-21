This is a simple example of a terraform template.  It will:
  * Create a vpc
  * Create a public subnet
  * Route it correctly
  * Create a single ec2 instance in the vpc.

The test.tfvars file has 2 entries that must be filled in:
  * the region: it's already set to us-west-2
  * the public_key: you'll need to add the public key for the ssh key you want to use to login to the new instance.

You can then use one of these configuration tools to configure the instance to deploy this site https://github.com/craigmonson/IT-The_human_aspect-deck
  * https://github.com/craigmonson/ansible-example
