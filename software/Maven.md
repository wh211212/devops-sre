# Maven

- 官网：http://maven.apache.org/

## 源码安装

```
http://mirrors.hust.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip -O /usr/local/src/apache-maven-bin.tar.gz
cd /usr/local/src && tar xzvf apache-maven-bin.tar.gz -C /opt
```
## yum安装

```
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
mvn --version
```
