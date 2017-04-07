# 如何在CentOS/RHEL 7/6/上安装最新的Nodej和NPM

> Node.js是一个建立在Chrome的JavaScript运行时的平台，用于轻松构建快速，可扩展的网络应用程序。 最新版本的node.js yum存储库由其官方网站维护。 我们可以将此yum存储库添加到我们的CentOS/RHEL 7/6系统中，并使用简单的命令安装node.js。

## 添加Node.js yum源

> 首先我们将在nodejs官方网站提供的系统中添加node.js yum库。您还需要开发工具来构建要在系统上安装的本机插件。

```
yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
```

## 安装Node.js 和NPM

> 在您的系统中添加yum存储库后，可以安装Nodejs软件包。 NPM也将与node.js.一起安装。此命令还将在系统上安装许多其他相关软件包。

```
yum erase nodejs npm -y   # 卸载旧版本的nodejs
rpm -qa 'node|npm' | grep -v nodesource # 确认nodejs是否卸载干净
yum install nodejs -y
```

## 检查Node.js和NPM版本

```
node -v
npm -v
```

## 创建演示Web服务器

> 这是一个可选的步骤。如果你想测试你的node.js安装。让我们创建一个带有“Welcome Node.js”文本的Web服务器。创建一个文件demo_server.js

```
vim demo_server.js

var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Welcome Node.js');
}).listen(3001, "127.0.0.1");
console.log('Server running at http://127.0.0.1:3001/');
```

> 现在使用以下命令启动Web服务器，建议把127.0.0.1改为本机ip

```
node --debug demo_server.js
```

- Web服务器已经在端口3001上启动。现在在浏览器中访问http://127.0.0.1:3001/url
