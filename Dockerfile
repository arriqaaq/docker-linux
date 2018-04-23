FROM golang:1.6.1-alpine
ADD . /go/src/go-with-compose
WORKDIR /go/src/go-with-compose
#CMD ["go", "run","main.go"]
CMD ["/bin/sh"]




#docker run -it -v $PWD:/go/src/go-with-compose goco sh
