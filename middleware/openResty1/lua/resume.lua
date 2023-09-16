--ngx.say('{"status":5711,"msg":"这是通过openresty自定义！","success":false,"data":null}')
 -- http 协议版本
--ngx.say("HTTP协议版本: ", ngx.req.http_version());
-- 请求方法
ngx.say("请求方法: ", ngx.req.get_method());
