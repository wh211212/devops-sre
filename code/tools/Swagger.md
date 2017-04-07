# Swagger-Editor

Swagger Editor是一款开源编辑器，用于在Swagger规范中设计，定义和记录RESTful API。 Swagger Editor的源代码可以在GitHub中找到。

GitHub: https://github.com/swagger-api/swagger-editor

## Swagger-Editor Demo

http://editor.swagger.io/#!/

## 在本地机器上使用编辑器

下载并运行Swagger Editor之前，需要在机器上安装以下依赖项

https://nodejs.org/en/

## 先决条件（最新版）

> 参考：http://blog.csdn.net/wh211212/article/details/69523645

Node 6.x
NPM 3.x

---
npm install -g http-server
---
git clone https://github.com/swagger-api/swagger-editor.git
cd swagger-editor
npm install     # 此过程可能较慢（笔者等待）
npm start
nohup npm start &  # 后台启动

## 对于较旧版本的swagger-editor

https://github.com/swagger-api/swagger-editor/tree/2.x
npm install -g http-server
wget https://github.com/swagger-api/swagger-editor/releases/download/v2.10.4/swagger-editor.zip
unzip swagger-editor.zip
http-server swagger-editor

> 如果npm启动不起作用，请删除node_modules文件夹，然后运行npm install和npm start 如果在克隆后dist文件夹有问题，请转到根目录并运行npm运行构建

# Swagger Codegen文档

Swagger Codegen是一个开源代码生成器，用于直接从Swagger定义的RESTful API构建服务器存根和客户端SDK。 Swagger Codegen的源代码可以在GitHub中找到。

GitHub: https://github.com/swagger-api/swagger-codegen

## 安装依赖

下载并运行Swagger Codegen之前，需要在机器上安装以下依赖项。
Java, version 7 or higher

## 从Maven Central安装
所有版本的Swagger Codegen项目都可以在Maven Central（https://oss.sonatype.org/content/repositories/releases/io/swagger/）上找到。访问Maven上的此文件夹，并选择适当的版本（我们建议最新版本）

wget https://oss.sonatype.org/content/repositories/releases/io/swagger/swagger-codegen-cli/2.2.1/swagger-codegen-cli-2.2.1.jar


wget http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.2.2/swagger-codegen-cli-2.2.2.jar -O swagger-codegen-cli.jar




# 为开发环境设置Swagger UI

## 介绍

  本文详细介绍了在Tomcat服务器上安装和配置Swagger UI工具所需的步骤，以便您可以在开发环境中查看和测试CúramREST API。 本文适用于想要使用Swagger UI工具在开发环境中查看和测试其API资源的CúramREST API的开发人员。
  Swagger 是一个规范和完整的框架，用于生成、描述、调用和可视化 RESTful 风格的 Web 服务。总体目标是使客户端和文件系统作为服务器以同样的速度来更新。文件的方法，参数和模型紧密集成到服务器端的代码，允许API来始终保持同步。Swagger 让部署管理和使用功能强大的API从未如此简单。

## 环境准备

nodejs
npm
wget
http-server
swagger-editor





## 下载和安装Swagger UI

从swagger-api GitHub资料库下载Swagger UI工具
网址为：https：//github.com/swagger-api/swagger-ui。 注意：确保下载的Swagger UI版本与Swagger Spec 2.0兼容,因为这是Rest应用程序生成的Swagger规范版本。

git clone https://github.com/swagger-api/swagger-ui.git

##




## 使用Swagger UI
现在可以通过Swagger UI工具查看API的所有资源。 它们根据已配置的标签分组在一起。 如果资源配置中没有包含任何标签，则Swagger UI工具会自动将其分组在“默认”标签下。
