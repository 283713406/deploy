### nfs部署方法
1.克隆该项目进入该文件夹操作
```bash
git clone https://gitlab.kylincloud.org/solution/ha/nfs.git

#对于x86机器
cd nfs
git checkout production-x86

#对于arm64机器
cd nfs
git checkout production-arm64
```
2.执行脚本设置防火墙
```bash
bash setup_nfs_firewall.sh
```
3.执行脚本开始安装nfs服务
```bash
sh nfs-script.sh
```
4.查看NFS服务端共享目录是否正常
```bash
showmount -e <NFS服务器IP>
```
5.检查`NFS服务器路径`的权限掩码
   
   ```sh
   cd <NFS服务器路径>
   umask -S 
   # 若返回:u=rwx,g=rx,o=rx,表明umask为0022
   ```
   
   如果不为0022，请设置为0022:
   
   ```sh
   cd <NFS服务器路径>
   umask 0022
   ```

6.证书设置

    **待KIM服务器搭建完成后，执行以下操作**

    在部署KIM的服务器`/var/lib/ipa/certs/`目录下执行：

    ```sh
    openssl pkey -passin file:/var/lib/ipa/passwds/{server-hostname}-443-RSA -in /var/lib/ipa/private/httpd.key > /var/lib/ipa/certs/ssl.key


    # 将/var/lib/ipa/certs/httpd.crt 和 /var/lib/ipa/certs/ssl.key 复制到NFS服务器上
    # NFS服务器路径见第三步脚本打印的内容

    scp /var/lib/ipa/certs/httpd.crt <NFS服务器用户名>@<NFS服务器IP>：<NFS服务器路径>/crt/ssl.crt

    scp /var/lib/ipa/certs/ssl.key <NFS服务器用户名>@<NFS服务器IP>：<NFS服务器路径>/crt/ssl.key
    ```
