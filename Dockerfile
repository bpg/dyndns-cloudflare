FROM docker.io/library/alpine:3.20
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
