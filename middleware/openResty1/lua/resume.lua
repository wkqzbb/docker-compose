--ngx.say('{"status":5711,"msg":"这是通过openresty自定义！","success":false,"data":null}')
 -- http 协议版本
--ngx.say("HTTP协议版本: ", ngx.req.http_version());
-- 请求方法
--ngx.say("请求方法: ", ngx.req.get_method());
-- 获取原始请求头信息
--ngx.say("原始请求头信息: " .. ngx.req.raw_header());
-- 获取请求头信息
local myHeader = ngx.req.get_headers();
ngx.say("token：" .. myHeader["token"]);
ngx.say("uid：" .. myHeader["uid"]);
-- 获取请求参数
local args = ngx.req.get_uri_args();
ngx.say("userId：" .. args["userId"]);
ngx.say("resumeId：" .. args["resumeId"]);
-- 获得 json 的请求体
ngx.req.read_body();
local bodyData = ngx.req.get_body_data();
ngx.say(bodyData);
