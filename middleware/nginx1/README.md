## 常用命令

```bash
# 启动
docker-compose up -d
# 
docker cp openresty:/usr/local/openresty /opt/docker/
```

## 说明

如果修改了 `docker-compose.yml` 文件中的 `volumes` 部分，您需要重新构建和启动容器，而不仅仅是重新启动容器。

```bash
docker-compose up -d --build
```

├── conf
│ └── nginx.conf
├── certs
│ └── your_certificate_files
└── docker-compose.yml


如果修改了 nginx.conf 文件，您需要重新加载 Nginx 配置，而不仅仅是重新启动容器。

```bash
docker exec nginx nginx -s reload
```


## nginx.conf

* user nobody : 配置 nginx 的进程用户
* worker_processes: Nginx 的进程数，一般设置为 CPU 核数 - 1
* error_log: 错误日志文件
* pid: Nginx 进程 ID 文件 所处的目录位置
* events: 工作模式及连接数上限
* http: HTTP 服务相关配置，里面的配置项非常多，下面我们来一一介绍

### http

* include: 引入其他配置文件，
* log_format: 日志格式, 用于定义日志的格式

```text
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';
    # $remote_addr 客户端地址
    # $remote_user 客户端用户名称
    # $time_local 访问时间与时区
    # $request 请求的URI和HTTP协议
    # $status HTTP请求状态
    # $body_bytes_sent 发送给客户端的字节数，不包括响应头的大小；该变量与Apache模块mod_log_config里的“%B”参数兼容。
    # $http_referer url跳转来源页面
    # $http_user_agent 客户端浏览器信息
    # $http_x_forwarded_for 客户端的真实IP地址
```

* sendfile : 开启高效文件传输模式，sendfile 指令指定 nginx 是否调用 sendfile 函数来输出文件，对于普通应用设为
  on，如果用来进行下载等应用磁盘IO重负载应用，可设置为 off，以平衡磁盘与网络I/O处理速度，降低系统的负载。
* tcp_nopush: 防止网络阻塞,当数据包准备好时，尽可能快地发送它们，而不是等待发送缓冲区被填满后再发送。
* keepalive_timeout: 长连接超时时间，单位是秒 ,节约资源，提高性能
* gzip: 开启gzip压缩,减少传输内容大小，节约带宽资源
* server: 服务器配置,重中之重,下面来详细介绍

### server
当请求进来，监听到配置的端口并且符合配置的 server_name 时，就会使用这个 server 块中的配置来处理请求。

location: 配置请求的路由，可以配置多个，匹配到第一个就不再匹配后面的了;相当于 Controller 中使用的 RequestMapping 注解

/ : 表示匹配所有请求

proxy_pass: 反向代理的地址，比如 http://tomcat:8080

proxy_set_header: 配置请求头，将请求头中的 Host 改为 $host，将请求头中的 Connection 改为 close

proxy_connect_timeout: 设置代理服务器（nginx）与后端服务器（tomcat）建立连接的超时时间

proxy_read_timeout: 设置代理服务器（nginx）向后端服务器（tomcat）发送请求后，等待响应超时时间

proxy_send_timeout: 设置代理服务器（nginx）向后端服务器（tomcat）发送请求超时时间

proxy_buffer_size: 设置代理服务器（nginx）读取上游响应的第一部分的大小，通常情况下，响应的第一部分不超过这个大小

proxy_buffers: 设置代理服务器（nginx）读取上游响应的第二部分的大小，通常情况下，响应的第二部分不超过这个大小

proxy_busy_buffers_size: 设置代理服务器（nginx）可以使用的内存大小，用于保存上游响应的第一部分和第二部分


