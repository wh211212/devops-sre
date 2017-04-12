# CentOS 7 配置Java语言开发环境

> 初始化设置参考：http://blog.csdn.net/wh211212/article/details/52923673

## 安装JDK8

> 安装Java SE开发工具包8（JDK8）并构建Java环境

- 下载并安装JDK 8
- [确保Oracle下载站点上JDK的最新版本和源URL]http://www.oracle.com/technetwork/java/javase/downloads/index.html

```
[root@linuxprobe ~]# curl -L "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm" -H "Cookie: oraclelicense=accept-securebackup-cookie"  -H "Connection: keep-alive" -O
# 采用yum或者rpm方式安裝jdk（這裡一yum為例）
[root@linuxprobe ~]# yum localinstall jdk-8u121-linux-x64.rpm -y
Loaded plugins: fastestmirror
Examining jdk-8u121-linux-x64.rpm: 2000:jdk1.8.0_121-1.8.0_121-fcs.x86_64
Marking jdk-8u121-linux-x64.rpm to be installed
Resolving Dependencies
--> Running transaction check
---> Package jdk1.8.0_121.x86_64 2000:1.8.0_121-fcs will be installed
--> Finished Dependency Resolution

Dependencies Resolved

===============================================================================================================================================================================================================================================================================
 Package                                                         Arch                                                      Version                                                               Repository                                                               Size
===============================================================================================================================================================================================================================================================================
Installing:
 jdk1.8.0_121                                                    x86_64                                                    2000:1.8.0_121-fcs                                                    /jdk-8u121-linux-x64                                                    263 M

Transaction Summary
===============================================================================================================================================================================================================================================================================
Install  1 Package

Total size: 263 M
Installed size: 263 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 2000:jdk1.8.0_121-1.8.0_121-fcs.x86_64                                                                                                                                                                                                                      1/1
Unpacking JAR files...
	tools.jar...
	plugin.jar...
	javaws.jar...
	deploy.jar...
	rt.jar...
	jsse.jar...
	charsets.jar...
	localedata.jar...
  Verifying  : 2000:jdk1.8.0_121-1.8.0_121-fcs.x86_64                                                                                                                                                                                                                      1/1

Installed:
  jdk1.8.0_121.x86_64 2000:1.8.0_121-fcs

Complete!
[root@linuxprobe ~]# java -version
java version "1.8.0_121"
Java(TM) SE Runtime Environment (build 1.8.0_121-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.121-b13, mixed mode)
# 設置jdk環境變量
[root@linuxprobe ~]# vi /etc/profile
# add follows to the end
export JAVA_HOME=/usr/java/default
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
[root@linuxprobe ~]# source /etc/profile
```

> 参考链接：http://blog.csdn.net/gsls200808/article/details/52336745（使用curl和wget下载最新版JDK）

- 如果安装了另一个版本的JDK，请更改默认值，如下所示：

```
# 以java-1.8.0-openjdk為例
[root@linuxprobe ~]# yum install java-1.8.0-openjdk -y
[root@linuxprobe ~]# alternatives --config java

There are 2 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
   1           /usr/java/jdk1.8.0_121/jre/bin/java
*+ 2           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.121-0.b13.el7_3.x86_64/jre/bin/java)
# 选择通过yum安装的最新版的Oracle JDK
Enter to keep the current selection[+], or type selection number: 1
```

- 创建测试程序确保java环境正常

```

[root@linuxprobe ~]# vi day.java
 import java.util.Calendar;

class day {
    public static void main(String[] args) {
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DATE);
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);
        System.out.println(year + "/" + month + "/" + day + " " + hour + ":" + minute);
    }
}

# compile
[root@linuxprobe ~]# javac day.java
[root@linuxprobe ~]# java day
2017/4/12 21:49
```
