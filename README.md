# docker-php

### Introduction
Docker for PHP

### Including
 - [PHP 7.3 with FPM](https://hub.docker.com/_/php)
 - [MySQL 5.7](https://hub.docker.com/_/mysql)
 - [Redis](https://hub.docker.com/_/redis)
 - [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin)
 - [phpRedisAdmin](https://hub.docker.com/r/erikdubbelboer/phpredisadmin)
 - [Laravel Echo Server](https://github.com/tlaverdure/laravel-echo-server)
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
| web-server  | 12001 | 12001 | 12001: [app](http://localhost:12001), [Laravel Echo Server(WebSocket)](http://localhost:12001/ws/) | 
| app-redis | 6379 | - | Redis |
| app-db | 3306, 33060 | 12006 | MySQL |
| laravel-echo-server | 6001 | - | Laravel Echo Server(WebSocket) | 
| app | 9000 | - | app |
| app-pma | 80 | 12010 | [phpMyAdmin](http://localhost:12010) |
| app-pra | 80 | 12011 | [phpRedisAdmin](http://localhost:12011) |

### Password
| Service  | Username | Password  | 
|---|---|---|
| app-db | root | root |
