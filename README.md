# Learning infrastructure as code

The first part of a project for learning infrastructure as code.

## Setting up

1. Install [carverlinux](http://www.github.com/jamesla/carverlinux).It's a VM with lots of devopsy tools preinstalled. Get it up and running.

2. Sign up for a free amazon account. (https://aws.amazon.com/free).

3. Configure the aws command line tool in carverlinux (use region ap-southeast-2):
```
aws configure

```
4. Verify the aws command line tool is working correctly with (it works if it doesn't throw an error):
```
aws s3 ls
```

5. Log into Github and make a [fork](http://bfy.tw/JTbVof) this repository to your own account.

6. Clone your forked repository into carverlinux

```
git clone https://github.com/%YOUR_USERNAME%/cloud-project.git
```
7. From the source directory deploy the stack into your aws account:
```
terraform apply
```
8. Log into the AWS console and ensure that the jumpbox has been deployed successfully.

## Part 1 - Connectivity

Although the jumpbox is running you will notice that if you try and ssh into it's public ip address you will get access denied. Your first task is to update the stack so that it deploys the jumpbox with your personal ssh public key installed so that you can connect to the jumpbox.

1. Create your own ssh keypair if you don't already have one. [generate an ssh keypair](http://bfy.tw/JTax)

2. Add your ssh key to the main.tf terraform template. [terraform keypair documentation](https://www.terraform.io/docs/providers/aws/r/key_pair.html)

3. Update main.tf to install your uploaded ssh public key onto the jumpbox upon creation. [terraform instance documentation](https://www.terraform.io/docs/providers/aws/r/instance.html)

4. Deploy the template:
```
terraform apply
```

5. Ensure you can ssh to your jumpbox:
```
ssh -i %YOUR_GENERATED_PRIVATE_KEY% ubuntu@x.x.x.x
```
