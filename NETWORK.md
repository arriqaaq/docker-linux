#Links

docker run -d --name redis-server redis
//Environmental variables set
docker run --link redis-server:redis alpine env
docker run --link redis-server:redis alpine cat /etc/hosts
docker run --link redis-server:redis alpine ping -c 1 redis


//Alias connect
docker run -it --link redis-server:redis redis redis-cli -h redis













#Networks



docker network create backend-network


#Embedded dns server entry/ not Local entry like links
docker run -d --name=redis --net=backend-network redis

docker run --net=backend-network alpine env

docker run --net=backend-network alpine cat /etc/resolv.conf /127.0.0.11

docker run --net=backend-network alpine ping -c1 redis




#Attach


docker network create frontend-network

docker network connect frontend-network redis

docker run -d -p 3001:5000 --net=frontend-network apptest