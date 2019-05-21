1. Export cess key and secret of user which having proper admin pervilege.

```
export AWS_ACCESS_KEY_ID=<access_key_id>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
```
2. You need to have aws-cli,jq,openssl and terraform install on these machine from where you want to run terraform.


3. Generate self signed cert which being used by ELB.

```
openssl genrsa 2048 > privatekey.pem
openssl req -new -key privatekey.pem -out csr.pem -subj "/C=US/ST=LA/L=LA/O=Dummy Corp/OU=Systems/CN=Local Certificate Authority/"
openssl x509 -req -days 365 -in csr.pem -signkey privatekey.pem -out server.crt
```

This should create a self-signed SSL certificate that can be used to configure
SSL on our ELB.

4. Upload cert to AWS IAM

```bash
aws iam upload-server-certificate --server-certificate-name elb-cert-x509 --certificate-body file://server.crt --private-key file://privatekey.pem
```
Copy ARN from output and paste it to arn place in `elb.tf`.

5. Generate an SSH RSA key pair

```
ssh-keygen -t rsa -N "" -f $PWD/ec2-key
```

The `ec2-key.pub` key should be used by the AWS launch configuration.

4. Run Terraform

Run below commands to launch infra using terraform

```bash
terraform init
terraform plan
terraform apply
```

Once it completes you should see terraform output the ELB DNS name through which you later access you website once deployment completed.

