FROM docker.io/library/alpine:3.21
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
