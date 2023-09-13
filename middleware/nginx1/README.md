如果修改了 `docker-compose.yml` 文件中的 `volumes` 部分，您需要重新构建和启动容器，而不仅仅是重新启动容器。
```bash
docker-compose up -d --build
```

├── conf
│   └── nginx.conf
├── certs
│   └── your_certificate_files
└── docker-compose.yml
