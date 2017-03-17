# Ansible相关代码

## 安装依赖
```sh
ansible-galaxy install AnsibleShipyard.ansible-zookeeper
```

## Ansible环境设置
首先参照`http://docs.ansible.com/ansible/intro_installation.html`来安装Ansible。 安装完成后, 运行下面的命令来确认安装成功:
```sh
ansible --version
```

Ansible的好多配置文件都位于`/etc/ansible`文件夹下, 一般是禁止改动的, 所以为了后面操作的方便, 运行以下命令来更改`/etc/ansible`文件夹的权限:
```sh
sudo chmod -R 777 /etc/ansible
```

为了使用Ansible Dynamic Inventory, 你需要下载一下两个文件, 并把它们放在`/etc/ansible`文件夹下:
* https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini
* https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py

运行以下命令给`ec2.py`脚本运行的权限:
```sh
chmod +x /etc/ansible/ec2.py
```

更改ansible的默认配置, 将以下文本放置在`/etc/ansible/ansible.cfg`文件中
```ini
inventory = /etc/ansible/ec2.py
host_key_checking = False
```