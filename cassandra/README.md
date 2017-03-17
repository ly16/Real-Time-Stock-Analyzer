# Cassandra相关的代码

## data-storage.py
实现了一个Cassandra数据存储过程

### 代码依赖
cassandra-driver    https://github.com/datastax/python-driver

cql

```sh
pip install -r requirements.txt
```

### 运行代码
假如你的Cassandra运行在一个叫做bigdata的docker-machine里面, 然后虚拟机的ip是192.168.99.100

利用cqlsh客户端创建一个keyspace和table
```sh
CREATE KEYSPACE "stock" WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1} AND durable_writes = 'true';
USE stock;
CREATE TABLE stock (stock_symbol text, trade_time timestamp, trade_price float, PRIMARY KEY (stock_symbol,trade_time));
```

```sh
python data-storage.py stock-analyzer 192.168.99.100:9092 stock stock 192.168.99.100
```
