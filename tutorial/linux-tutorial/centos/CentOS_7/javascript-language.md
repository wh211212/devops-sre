# CentOS 7 配置JS语言开发环境（JavaScript）

## 安装ServerSide JavaScript环境“Node.js”

- 安装Node.js和包管理工具npm

```
[root@linuxprobe ~]# yum -y install epel-release
[root@linuxprobe ~]# yum --enablerepo=epel -y install nodejs npm
```
- 创建一个测试工具

```
[root@linuxprobe ~]$ vi helloworld.js
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('listening on http://127.0.0.1:1337/');

# run server
[root@linuxprobe ~]$ node helloworld.js &
# verify (it's OK if following reply is back )
[root@linuxprobe ~]$ curl http://127.0.0.1:1337/
Hello World
```
- 安装Socket.IO并使用WebSocket创建测试

```
[root@linuxprobe ~]$ npm install socket.io express
[root@linuxprobe ~]$ vi chat.js
 var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
  });
});

http.listen(1337, function(){
  console.log('listening on *:1337');
});

[root@linuxprobe ~]$ vi index.html
 <!DOCTYPE html>
<html>
<head>
<title>WebSocket Chat</title>
</head>
<body>
<form action="">
<input id="sendmsg" autocomplete="off" /><button>Send</button>
</form>
<ul id="messages" style="list-style-type: decimal; font-size: 16px; font-family: Arial;"></ul>
<script src="/socket.io/socket.io.js"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script>
  var socket = io();
  $('form').submit(function(){
    socket.emit('chat message', $('#sendmsg').val());
    $('#sendmsg').val('');
    return false;
  });
  socket.on('chat message', function(msg){
    $('#messages').append($('<li style="margin-bottom: 5px;">').text(msg));
  });
</script>
</body>
</html>

[root@linuxprobe ~]$ node chat.js
listening on *:1337
```
- 客户端浏览器访问测试http://10.1.1.53:1337/


![这里写图片描述](http://img.blog.csdn.net/20170411185401789?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 关闭node进程

```
ps -ef | grep -v grep | grep node | awk '{print $2}' | xargs kill -9
```

## 安装ServerSide JavaScript环境Node.js 4（LTS）

- 可以从CentOS SCLo软件存贮库进行安装

```
# install from SCLo
[root@linuxprobe ~]# yum --enablerepo=centos-sclo-rh -y install rh-nodejs4
```

- 设置环境变量

```
# load environment variables
[root@linuxprobe ~]# scl enable rh-nodejs4 bash
[root@linuxprobe ~]# node -v
v4.4.2
[root@linuxprobe ~]# which node
/opt/rh/rh-nodejs4/root/usr/bin/node
```

- 设置登录时自动启用Node.js 4

```
[root@linuxprobe ~]# vi /etc/profile.d/rh-nodejs4.sh
#!/bin/bash
source /opt/rh/rh-nodejs4/enable
export X_SCLS="`scl enable rh-nodejs4 'echo $X_SCLS'`"
```
