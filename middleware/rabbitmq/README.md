# RabbitMQ 单节点安装及管理端教程

## 前提条件
- 已安装Docker和Docker Compose
- 已创建并进入一个目录

## 步骤

### 1. 创建Docker Compose文件
在你选择的目录中创建一个名为`docker-compose.yml`的文件，并将以下内容复制到文件中：

```yaml
version: '3'
services:
  rabbitmq:
    image: rabbitmq:3-management
    ports:
      - "5672:5672"
      - "15672:15672"
    volumes:
      - ./data:/var/lib/rabbitmq
    environment:
      - RABBITMQ_DEFAULT_USER=admin
      - RABBITMQ_DEFAULT_PASS=password
```

### 2. 创建数据目录
在你选择的目录中创建一个名为`data`的文件夹，用于挂载RabbitMQ的数据。

### 3. 启动RabbitMQ容器
在命令行中进入你选择的目录，并执行以下命令启动RabbitMQ容器：

```bash
docker-compose up -d
```

### 4. 访问管理端
打开浏览器，输入`http://localhost:15672`进入RabbitMQ的管理端。使用以下默认凭证登录：
- 用户名：admin
- 密码：password

