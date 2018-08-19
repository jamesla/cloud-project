# Learning infrastructure as code

The first part of a project for learning infrastructure as code.

## Part 1 - Connectivity

Although the jumpbox is running you will notice that if you try and ssh into it's public ip address you will get access denied. Your first task is to update the stack so that it deploys the jumpbox with your personal ssh public key installed so that you can connect to the jumpbox.

1. Create your own ssh keypair if you don't already have one. http://bfy.tw/JTax

2. Add your ssh key to the main.tf terraform template. [Terraform Keypair Documentation](https://www.terraform.io/docs/providers/aws/r/key_pair.html)

3. Update main.tf to install your uploaded ssh public key onto the jumpbox upon creation. [Terraform Instance Documentation](https://www.terraform.io/docs/providers/aws/r/instance.html)

4. Deploy the template:
```
terraform apply
```

5. Ensure you can ssh to your jumpbox:
```
ssh -i %YOUR_GENERATED_PRIVATE_KEY% ubuntu@x.x.x.x
```
