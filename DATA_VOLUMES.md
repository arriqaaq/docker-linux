docker create -v /dump --name dataContainer busybox


docker cp data dataContainer:/dump/

docker run --volumes-from dataContainer ubuntu ls /dump


docker export dataContainer > dataContainer.tar

docker import dataContainer.tar
