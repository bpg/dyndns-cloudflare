FROM ghcr.io/onedr0p/alpine:rolling@sha256:51632d23e56ae28a34f8e90df6fe8d02730b5462697ae52e8b01ad6484497819
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
