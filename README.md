# docker-php

### Introduction
Docker for PHP(Laravel)

### Including
 - [PHP 8.1 with FPM](https://hub.docker.com/_/php)
 - [MySQL 5.7](https://hub.docker.com/_/mysql)
 - [Redis](https://hub.docker.com/_/redis)
 - [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin)
 - [phpRedisAdmin](https://hub.docker.com/r/erikdubbelboer/phpredisadmin)
 - [soketi](https://github.com/soketi/soketi)
 - [Nginx](https://hub.docker.com/_/nginx)

### Usage

```shell
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
| php-web-server  | 80 | 35500 | [php-app](http://localhost:35500), [soketi(WebSocket)](http://localhost:35501) |
| php-redis | 6379 | - | Redis |
| php-db | 3306, 33060 | 35506 | MySQL |
| soketi | 6001 | 35501 | soketi(WebSocket) |
| php-app | 9000 | - | APP |
| php-pma | 80 | 35510 | [phpMyAdmin](http://localhost:35510) |
| php-pra | 80 | 35520 | [phpRedisAdmin](http://localhost:35520) |

### Password
| Service  | Username | Password  |
|---|---|---|
| php-db | root | root |
