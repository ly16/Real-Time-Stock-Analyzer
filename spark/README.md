## What is Spark?
- Open source cluster computing framework
- Respond to limitations of Apache Hadoop
- Computation optimization
- In memory computing

## stream-process.py

### Reference
pyspark         http://spark.apache.org/docs/latest/api/python/

kafka-python    https://github.com/dpkp/kafka-python


### Command Line
```sh
spark-submit --jars spark-streaming-kafka-0-8-assembly_2.11-2.0.0.jar stream-processing.py stock-analyzer average-stock-price 192.168.99.100:9092
```
