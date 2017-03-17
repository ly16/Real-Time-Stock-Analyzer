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
- Front end realizes the visualization
![picture1](https://github.com/ly16/real-time-stock-analyzer/blob/master/results/P5.png)

## Command Line
** Set the Docker Eve and run the follow command



