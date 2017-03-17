# Cassandra 
## What is Cassandra?
An open source distributed storage system that provides

Manage massive amounts of data, fast, without losing sleep

High availability

No single point of failure

## data-storage.py
The code for data storage in Cassandra

### Reference
cassandra-driver    https://github.com/datastax/python-driver


cql

```sh
pip install -r requirements.txt
```

### Command Line
Assume Cassandra is run in a docker-machine called bigdata, with ip: 192.168.99.100

###create keyspace and table by cqlsh
```sh
CREATE KEYSPACE "stock" WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1} AND durable_writes = 'true';
USE stock;
CREATE TABLE stock (stock_symbol text, trade_time timestamp, trade_price float, PRIMARY KEY (stock_symbol,trade_time));
```

```sh
python data-storage.py stock-analyzer 192.168.99.100:9092 stock stock 192.168.99.100

```

Lilis-MacBook-Pro:cs502 liliyu$ python data-producer.py GOOG 192.168.99.101:9092 stock-analyzer
```
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
cDEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
DEBUG:data-producer:start to fetch price for GOOG
DEBUG:data-producer:sent stock price for GOOG, price is [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
^CTraceback (most recent call last):
  File "data-producer.py", line 62, in <module>
    time.sleep(1)
KeyboardInterrupt
DEBUG:data-producer:exiting program
DEBUG:data-producer:kafka producer closed, exiting
```

Lilis-MacBook-Pro:cs502 liliyu$ python data-storage.py stock-analyzer 192.168.99.101:9092 stock stocktable 192.168.99.101
```
2017-02-03 21:17:15,341 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "128.79", "LastTradeDateTime": "2017-02-01T16:00:03Z", "LastTradePrice": "128.79", "Yield": "1.77", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 1, 4:00PM EST", "Dividend": "0.57", "StockSymbol": "AAPL", "ID": "22144"}]
2017-02-03 21:17:15,361 Persistend data to cassandra for symbol: AAPL, price: 128.790000, tradetime: 2017-02-01T16:00:03Z
2017-02-03 21:17:15,361 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "128.79", "LastTradeDateTime": "2017-02-01T16:00:03Z", "LastTradePrice": "128.79", "Yield": "1.77", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 1, 4:00PM EST", "Dividend": "0.57", "StockSymbol": "AAPL", "ID": "22144"}]
2017-02-03 21:17:15,374 Persistend data to cassandra for symbol: AAPL, price: 128.790000, tradetime: 2017-02-01T16:00:03Z
2017-02-03 21:17:15,374 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,380 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,380 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,386 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,386 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,392 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,392 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,400 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,400 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,408 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,409 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,413 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,413 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,418 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,418 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,424 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,424 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,429 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
2017-02-03 21:17:15,430 Start to persist data to cassandra [{"Index": "NASDAQ", "LastTradeWithCurrency": "801.49", "LastTradeDateTime": "2017-02-03T16:00:02Z", "LastTradePrice": "801.49", "Yield": "", "LastTradeTime": "4:00PM EST", "LastTradeDateTimeLong": "Feb 3, 4:00PM EST", "Dividend": "", "StockSymbol": "GOOG", "ID": "304466804484872"}]
2017-02-03 21:17:15,435 Persistend data to cassandra for symbol: GOOG, price: 801.490000, tradetime: 2017-02-03T16:00:02Z
^CTraceback (most recent call last):
  File "data-storage.py", line 123, in <module>
    for msg in consumer:
  File "/Users/liliyu/anaconda/lib/python2.7/site-packages/kafka/vendor/six.py", line 559, in next
    return type(self).__next__(self)
  File "/Users/liliyu/anaconda/lib/python2.7/site-packages/kafka/consumer/group.py", line 925, in __next__
    return next(self._iterator)
  File "/Users/liliyu/anaconda/lib/python2.7/site-packages/kafka/consumer/group.py", line 865, in _message_generator
    self._client.poll(timeout_ms=poll_ms, sleep=True)
  File "/Users/liliyu/anaconda/lib/python2.7/site-packages/kafka/client_async.py", line 512, in poll
    responses.extend(self._poll(timeout, sleep=sleep))
  File "/Users/liliyu/anaconda/lib/python2.7/site-packages/kafka/client_async.py", line 529, in _poll
    ready = self._selector.select(timeout)
  File "/Users/liliyu/anaconda/lib/python2.7/site-packages/kafka/vendor/selectors34.py", line 598, in select
    kev_list = self._kqueue.control(None, max_ev, timeout)
KeyboardInterrupt
2017-02-03 21:24:25,392 Closing Kafka Consumer
2017-02-03 21:24:25,507 Kafka Consumer closed
2017-02-03 21:24:25,507 Closing Cassandra Session
2017-02-03 21:24:25,509 Cassandra Session closed
2017-02-03 21:24:25,509 Existing program
```
##Check in table##
./cqlsh `docker-machine ip bigdata` 9042 Connected to Test Cluster at 192.168.99.101:9042
```
[cqlsh 5.0.1 | Cassandra 3.7 | CQL spec 3.4.2 | Native protocol v4]
Use HELP for help.
```
cqlsh> use stock;

cqlsh:stock> Describe stock;
```

CREATE KEYSPACE stock WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}  AND durable_writes = true;

CREATE TABLE stock.stocktable (
    stock_symbol text,
    trade_time timestamp,
    trade_price float,
    PRIMARY KEY (stock_symbol, trade_time)
) WITH CLUSTERING ORDER BY (trade_time ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
```
cqlsh:stock> SELECT * FROM stocktable;
```
 stock_symbol | trade_time                      | trade_price
--------------+---------------------------------+-------------
         AAPL | 2017-02-01 11:00:03.000000-0500 |   128.78999
         GOOG | 2017-02-03 11:00:02.000000-0500 |   801.48999
```
SELECT * FROM stocktable;
```

 stock_symbol | trade_time                      | trade_price
--------------+---------------------------------+-------------
         AAPL | 2017-02-01 11:00:03.000000-0500 |   128.78999
         GOOG | 2017-02-03 11:00:02.000000-0500 |   801.48999
```

