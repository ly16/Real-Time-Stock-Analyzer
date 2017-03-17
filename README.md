## Real-time Stock Analyzer by big data Frameworks?

Here is my project about real time stock price visualization by using bigdata pipeline. To work with big data, we request frameworks with high availability, high perfermance and high stability. The latest bigdata framework is composed by "SMACK", that is Spark, Mesos, Akka, Cassandra and Kafka. In my project, I connected Zookeeper, Kafka, Cassandra, redis and Nodejs in Docker machine, from the back end to the front end, to realize the stock price visualization. All of the code is in Python version.

## What's the process?
- Set the docker machine environment
- Make a wide range of open-source projects by Zookeeper
- Get client requests from HTML front end
- Kafka starts to Fetch data from google finance and transports data to frameworks
- Kafka Store data to cassandra (optional)
- Spark gets data from Kafka, computes the avaerage value (or other computational processes) and writes back to Kafka
- Kafka sends processed to Redis cache 
- Redis publishes received data to Node.js
- Front end realizes the visualization, and updates front end as data comes in
![P5](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/P5.png)

## Command Line
* Set the Docker Eve and run the follow command

* Fetch multiple stock data by flask-data-producer.py
```
export ENV_CONFIG_FILE=`pwd`/config/dev.cfg
python flask-data-producer.py
```
* Under spark env using spark-submit to do data process 
```
spark-submit --jars spark-streaming-kafka-0-8-assembly_2.11-2.0.0.jar stream-processing.py stock-analyzer average-stock-price 192.168.99.100:9092
```
* Use redis to publish data 
```
python redis-publisher.py average-stock-price 192.168.99.100:9092 average-stock-price 192.168.99.100 6379
```
* Start the webserver at localhost:3000
```
node index.js --port=3000 --redis_host=192.168.99.102 --redis_port=6379 --subscribe_topic=average-stock-price
```
* Add the stock brand you like to see the results
![aapl](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/aapl.png)
![amzn](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/amzn.png)
![goog](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/goog.png)

* command line screen shots
![docker1](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/docker1.png)
![docker2](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/docker2.png)
