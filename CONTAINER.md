wget https://github.com/ericchiang/containers-from-scratch/releases/download/v0.1.0/rootfs.tar.gz
sudo tar -zxf rootfs.tar.gz
ls rootfs

sudo chroot rootfs /bin/bash
sudo chroot rootfs python -m SimpleHTTPServer
sudo cp /dev/urandom "rootfs/dev/urandom"

#namespace
top
sudo chroot rootfs /bin/bash
mount -t proc proc /proc
ps aux | grep top
pkill top

Creating namespace is super easy, just a single syscall with one argument, unshare

sudo unshare -p -f --mount-proc=$PWD/rootfs/proc \
    chroot rootfs /bin/bash



#namespaces (Namespaces are a feature of the Linux kernel that isolate and virtualize system resources of a collection of processes)

A powerful aspect of namespaces is their composability; processes may choose to separate some namespaces but share others. For instance it may be useful for two programs to have isolated PID namespaces, but share a network namespace (e.g. Kubernetes pods). This brings us to the setns syscall and the nsentercommand line tool.

ps aux | grep /bin/bash | grep root
sudo ls -l /proc/7754/ns
sudo nsenter --pid=/proc/7754/ns/pid \
    unshare -f --mount-proc=$PWD/rootfs/proc \
    chroot rootfs /bin/bash


#Mounting (without chroot)

mkdir readonlyfiles
echo "hello" > readonlyfiles/hi.txt
sudo mkdir -p rootfs/var/readonlyfiles
sudo mount --bind -o ro $PWD/readonlyfiles $PWD/rootfs/var/readonlyfiles


#Cgroup

sudo su
mkdir /sys/fs/cgroup/memory/demo
echo "100000000" > /sys/fs/cgroup/memory/demo/memory.limit_in_bytes
echo "0" > /sys/fs/cgroup/memory/demo/memory.swappiness
echo $$ > /sys/fs/cgroup/memory/demo/tasks

<!-- f = open("/dev/urandom", "r")
data = ""

i=0
while True:
    data += f.read(10000000) # 10mb
    i += 1
    print "%dmb" % (i*10,)
 -->


cgroups can’t be removed until every processes in the tasks file has exited or been reassigned to another group. Exit the shell and remove the directory with rmdir (don’t use rm -r).