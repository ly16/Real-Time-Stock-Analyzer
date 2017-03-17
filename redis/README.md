# Redis

Open source in-memory data structure store

Database, Cache, Message Queue

## redis-producer.py

Receives data from Kafka topic and published on redis PUB


### Reference
kafka-python    https://github.com/dpkp/kafka-python

redis           https://pypi.python.org/pypi/redis

```sh
pip install -r requirements.txt
```

### Command Line
Assume you run kafka and redis in a docker-machine called bigdata, with ip:192.168.99.100
```sh
python redis-publisher.py average-stock-price 192.168.99.100:9092 average-stock-price 192.168.99.100 6379
```


