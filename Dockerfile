FROM ghcr.io/onedr0p/alpine:rolling@sha256:3fbc581cb0fe29830376161ae026e2a765dcc11e1747477fe9ebf155720b8638
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
