local function send_post(path,params)
    local response = ngx.location.capture(path, {
        method = ngx.HTTP_POST,
        args = params
    })
    -- 目标路径不存在，则无法响应客户端
    if not response then
        ngx.exit(404);
    end
    -- 返回响应,只要有响应就返回，直接返回给客户端去处理
    return response.body;
end
local http = {
    send_post = send_post
}
return http;
