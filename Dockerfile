FROM apteno/alpine-jq:2023-12-24
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
