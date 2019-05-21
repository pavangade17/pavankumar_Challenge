1. Ansible should be installed where you want to run this:

``` 
 ansible-playbook -i hosts default.yml

```

Once cahnges done successfully you can access webserver from DNS endpoint of ELB which you got as terraform output.