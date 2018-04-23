

<!--     People of the clan, Docker is just a fancy way to run a process, not a virtual machine.
 -->

docker run  -v redis-data:/data  --name r1 -d redis redis-server --appendonly yes



cat data | docker exec -i r1 redis-cli --pipe


#Volume names are verbose

docker run  -v ./redis-data:/backup ubuntu ls /backup

docker run --volumes-from r1 -it ubuntu ls /data
docker run -v ./redis-data:/data:ro -it ubuntu rm -rf /data