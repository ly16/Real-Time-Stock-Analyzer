## What is Node.js?
-Open source platform for service-side web applications

-Event-driven architecture

-Async IO


## index.js
Real-time data application by front end

### Reference
socket.io       http://socket.io/

redis           https://www.npmjs.com/package/redis

smoothie        https://www.npmjs.com/package/smoothie

minimist        https://www.npmjs.com/package/minimist

```sh
npm install
```

### Command Line
Run servers in docker machine called bigdata with ip 192.168.99.100
```sh
node index.js --port=3000 --redis_host=192.168.99.100 --redis_port=6379 --subscribe_topic=average-stock-price
```
