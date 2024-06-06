# docker-php

### Introduction
Docker for PHP(Laravel)

In the `app` directory, create PHP programs. If it is a Laravel project, you need to modify the settings to `cron/root` and `nginx/default.conf`.

### Including
 - [PHP 8.3 with FPM](https://hub.docker.com/_/php)
 - [MySQL 8.4](https://hub.docker.com/_/mysql)
 - [Redis 6.0.20](https://hub.docker.com/_/redis)
 - [phpMyAdmin 5.2](https://hub.docker.com/r/phpmyadmin/phpmyadmin)
 - [RedisInsight v2](https://hub.docker.com/r/redislabs/redisinsight)
 - [Nginx 1.25](https://hub.docker.com/_/nginx)

### Usage

```shell
# copy .env and change settings
cp .env.example .env
vi .env

# start docker
docker-compose up -d

# stop docker
docker-compose down

# docker logs
docker-compose logs -f
```

### Port
| service  | port-inside | port-outside  | description |
|---|---|---|---|
| php-app-web-server  | 80 | 35500 | [php-app](http://localhost:35500) |
| php-app-redis | 6379 | - | Redis |
| php-app-db | 3306, 33060 | 35506 | MySQL |
| php-app | 9000 | - | APP |
| php-app-pma | 80 | 35510 | [phpMyAdmin](http://localhost:35510) |
| php-app-ri | 80 | 35520 | [RedisInsight](http://localhost:35520) |

### Password
| Service  | Username | Password  |
|---|---|---|
| php-app-db | root | root |
