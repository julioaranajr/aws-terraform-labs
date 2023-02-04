# tf-ec2-ssm-lab

<<<<<<< HEAD
Alternative of connecting to instance with SSM instead of SSH
https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-prerequisites.html
=======
Alternative of connecting to instance with SSM instead of SSH, in AWS Systems-Manager/Latest/UserHuide: [prerequisites](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-prerequisites.html)
>>>>>>> 3bd51e8 (update readme.md)

#### Prerequisites
````
brew install session-manager-plugin
````
#### CLI command
```sh
aws ssm start-session --target <INSTANCE-ID>
```
