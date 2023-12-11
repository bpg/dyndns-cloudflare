FROM apteno/alpine-jq:2023-12-10
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
