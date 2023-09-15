## 概述
拥有 nginx 里面所有的功能，可以基于 LUA 实现自定义的逻辑处理，针对 Nginx 做了封装。

## Nginx 反向代理 OpenResty 集群


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
```bash
    location / {
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
docker-compose up -d --build
```
