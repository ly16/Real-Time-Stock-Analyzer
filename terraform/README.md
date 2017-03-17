# Terraform相关代码

## AWS相关设置
为了使用Terraform, 首先你比如要有一个AWS key/secret
具体获取方法参见: `http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey`

获取了AWS access key和access key secret以后, 更改`~/.aws/credentials`文件如下:
```ini
[default]
aws_access_key_id = [你的 access key id]
aws_secret_access_key = [你的 access key secret]
```

为了能够远程ssh进入你的ec2实例, 你还需要创建一个ec2 keypair
具体获取方法参见: `http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html`

获取了AWS EC2 private key以后, 请将它保存在本地。保存好以后注意运行下面的命令来更改private key的权限, 不然有可能无法进行ssh连接
```sh
chmod 400 [private key的位置]
```

## Ansible相关设置
参考 [Ansible环境设置!](../ansible/README.md)