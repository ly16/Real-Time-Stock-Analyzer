
### Virtual env 

eval $(docker-machine env bigdata)


Assume to run kafka in a docker-machine called bigdata, with ip 192.168.99.100
```sh
python fast-data-producer.py stock-analyzer 192.168.99.100:9092
```


## flask-data-producer.py
kafka producer fetches stock data from google finance and sends to kafka. Add/delete by HTTP request

### Reference
googlefinance   https://pypi.python.org/pypi/googlefinance
kafka-python    https://github.com/dpkp/kafka-python
apscheduler     https://github.com/agronholm/apscheduler

### Command Line
ip 192.168.99.100
```sh
export ENV_CONFIG_FILE=`pwd`/config/dev.cfg
python flask-data-producer.py
```