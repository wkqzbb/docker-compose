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
