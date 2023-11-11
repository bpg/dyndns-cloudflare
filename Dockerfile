FROM apteno/alpine-jq:2023-11-05
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
