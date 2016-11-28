# RabbitMQ

## 安装Erlang
```
$ sudo apt-get install erlang
```

## 添加APT Repository
```
$ echo 'deb http://www.rabbitmq.com/debian/ testing main' |
        sudo tee /etc/apt/sources.list.d/rabbitmq.list

```

```
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
        sudo apt-key add -
```

`sudo apt-get update`

`sudo apt-get install rabbitmq-server`