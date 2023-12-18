FROM apteno/alpine-jq:2023-12-17
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
