# Redis相关的代码

## redis-producer.py
Redis producer, 从一个Kafka topic接收到消息后publish到redis PUB

### 代码依赖
kafka-python    https://github.com/dpkp/kafka-python

redis           https://pypi.python.org/pypi/redis

```sh
pip install -r requirements.txt
```

### 运行代码
假如你的Kafka和Redis运行在一个叫做bigdata的docker-machine里面, 然后虚拟机的ip是192.168.99.100
```sh
python redis-publisher.py average-stock-price 192.168.99.100:9092 average-stock-price 192.168.99.100 6379
```


