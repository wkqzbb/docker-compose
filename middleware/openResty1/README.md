## 概述

拥有 nginx 里面所有的功能，可以基于 LUA 实现自定义的逻辑处理，针对 Nginx 做了封装。

## Nginx 反向代理 OpenResty 集群

在 Nginx 中配置了一个 upstream，用于配置后端的服务器，然后在 location 中配置 proxy_pass 代理转发请求，这样就可以实现反向代理了。

```config
    upstream backend {
        server 192.168.31.155:60001;
        server 192.168.31.155:60002;
        server 192.168.31.155:60003;
    }
```

负载均衡默认的配置就是轮询，可以通过配置 weight 来设置权重，权重越高，被选中的概率越大, weight 默认为 1, 不同的服务器可以设置不同的权重。

```config
    upstream backend {
        server 192.168.31.155:60001;
        server 192.168.31.155:60002 weight = 2;
        server 192.168.31.155:60003 weight = 5;
    }
```

还有一种负载均衡设置是 IP hash，这种方式会根据客户端的 IP 地址进行 hash
计算，然后根据计算结果进行分配，这样可以保证同一个客户端的请求都会转发到同一个服务器上，这样就可以解决 session 的问题。 现在的应用一般都是无状态的，所以这种方式用的不多了。

```config
    upstream backend {
        ip_hash;
        server 192.168.31.155:60001;
        server 192.168.31.155:60002;
        server 192.168.31.155:60003;
    }
```
还有一种负载均衡设置是 url hash，这种方式会根据客户端的 url 进行 hash 计算，然后根据计算结果进行分配，这样可以保证同一个 url 的请求都会转发到同一个服务器上，可以让特定的请求都转发到同一个服务器上，提高缓存的命中率。缺点是当服务器数量发生变化时，会导致hash计算结果发生变化，这样会导致缓存失效，所以这种方式也用的不多了。

```config
    upstream backend {
        hash $request_uri;
        server 192.168.31.155:60001;
        server 192.168.31.155:60002;
        server 192.168.31.155:60003;
    }
```
### HASH 算法带来的问题
当服务器数量发生变化时，会导致hash计算结果发生变化。

一致性 hash 算法 (Consistent Hashing) 解决了这个问题，它的思想是这样的：将整个哈希值空间组织成一个虚拟的圆环，如下图所示，整个哈希空间按顺时针方向组织，最右边和最左边通过哈希值 0 连接起来。每个服务器节点都对应在这个哈希环上的一个点，这个点的位置由服务器节点的 IP 地址决定。当有新的对象需要缓存时，先计算对象的哈希值，然后找到这个哈希值在哈希环上对应的点，从这个点沿着顺时针方向查找，第一个遇到的服务器节点就是负责缓存这个对象的服务器节点。当服务器节点数量发生变化时，只有受影响的服务器节点和它顺时针方向的下一个服务器节点会受到影响，这样就大大减少了缓存失效的情况。


## LUA

```bash
40dd733f73df:/# cd /usr/local/openresty/
40dd733f73df:/usr/local/openresty# ls
COPYRIGHT    bin          luajit       lualib       nginx        openssl      pcre         pod          resty.index  site
40dd733f73df:/usr/local/openresty# cd lualib/
40dd733f73df:/usr/local/openresty/lualib# ls
cjson.so           librestysignal.so  ngx                rds                redis              resty              tablepool.lua
40dd733f73df:/usr/local/openresty/lualib# pwd
/usr/local/openresty/lualib

# 所有的 .so 和 .lua 文件都可以进行加载到配置文件中，加载后可以直接使用，编写自定义的逻辑处理
```

### 配置lua到config

在 nginx.conf 中配置 lua 的路径

```bash
http {
    include       mime.types;
    default_type  application/octet-stream;
    # 加载 lua 模块
    lua_package_path "/usr/local/openresty/lualib/?.lua;;"; # ? 表示当前目录
    lua_package_cpath "/usr/local/openresty/lualib/?.so;;"; # ? 表示当前目录
    ...
}
```

此时就可以在 nginx.conf 中使用 lua 了，可以写到 server 中，也可以写到 location 中
proxy_pass http://backend; # 通过代理转发请求

# 使用 lua 编写自定义逻辑

# 定义返回的数据类型

default_type 'application/json';

# 返回的数据内容从哪里来

content_by_lua_file /usr/local/openresty/nginx/lua/resume.lua;
}

```
然后在 `/usr/local/openresty/nginx/lua` 目录下创建一个 test.lua 文件
```lua
-- test.lua ngx.say 表示响应
ngx.say("{"status":5711,"msg":"这是通过openresty自定义！","success":false,"data":null}")
```

然后重现构建镜像，启动容器

```bash
## 各种请求参数的获得
ngx.say(ngx.req.http_version()) -- 获取请求的 HTTP 版本号
```
