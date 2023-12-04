FROM apteno/alpine-jq:2023-12-03
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
