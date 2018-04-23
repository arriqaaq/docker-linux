docker swarm init --advertise-addr=172.31.8.233

docker service create --replicas 1 --name helloworld alpine ping docker.com

docker service ls

docker service inspect --pretty helloworld

docker service ps helloworld

docker service scale helloworld=5
docker service ps helloworld




docker service rm helloworld




docker service create \
  --replicas 3 \
  --name redis \
  --update-delay 10s \
  redis:3.0.6


docker service update --image redis:3.0.7 redis


docker service create --replicas 3 --name redis --update-delay 10s redis:3.0.6
docker node update --availability drain worker1
docker node update --availability active worker1