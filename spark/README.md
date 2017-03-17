# Spark相关的代码

## stream-process.py

### 代码依赖
pyspark         http://spark.apache.org/docs/latest/api/python/

kafka-python    https://github.com/dpkp/kafka-python


### 运行代码
假如你的Kafka运行在一个叫做bigdata的docker-machine里面, 然后虚拟机的ip是192.168.99.100
```sh
spark-submit --jars spark-streaming-kafka-0-8-assembly_2.11-2.0.0.jar stream-processing.py stock-analyzer average-stock-price 192.168.99.100:9092
```