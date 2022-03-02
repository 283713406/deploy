### nfs部署方法
1.克隆该项目进入该文件夹操作

    $ git clone https://gitlab.kylincloud.org/solution/ha/nfs.git

    $ cd nfs

2.执行脚本设置防火墙

    $ bash setup_nfs_firewall.sh

3.执行脚本开始安装nfs服务

    $ https://gitlab.kylincloud.org/solution/tianyu.git

    $ cat tianyu/values.yaml | grep nfsServerPath

    $ bash nfs-script.sh <NFS_PATH, 该值为上条命令查询出的nfsServerPath的值> 

4.查看NFS服务端共享目录是否正常

    $ showmount -e <NFS服务器IP>

5.检查`NFS服务器路径`的权限掩码 

    $ cd <NFS服务器路径>
    $ umask -S 
    # 若返回:u=rwx,g=rx,o=rx,表明umask为0022
   
   如果不为0022，请设置为0022:

    $ cd <NFS服务器路径>
    $ umask 0022

6.证书设置

    **待KIM服务器搭建完成后，执行以下操作**

    在部署KIM的服务器`/var/lib/ipa/certs/`目录下执行：
    $ openssl pkey -passin file:/var/lib/ipa/passwds/{server-hostname}-443-RSA -in /var/lib/ipa/private/httpd.key > /var/lib/ipa/certs/ssl.key

    # 将/var/lib/ipa/certs/httpd.crt 和 /var/lib/ipa/certs/ssl.key 复制到NFS服务器上
    # NFS服务器路径见第三步脚本打印的内容
    $ scp /var/lib/ipa/certs/httpd.crt <NFS服务器用户名>@<NFS服务器IP>：<NFS服务器路径>/data/crt/ssl.crt

    $ scp /var/lib/ipa/certs/ssl.key <NFS服务器用户名>@<NFS服务器IP>：<NFS服务器路径>/data/crt/ssl.key
   
