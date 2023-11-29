FROM apteno/alpine-jq:2023-11-26
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
