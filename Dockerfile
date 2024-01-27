FROM ghcr.io/onedr0p/alpine:rolling@sha256:0e3067295cc20dafbd4cf63789ccc71858ad555f3998200ca10b271328c7285e
ADD ./dyndns.sh .
ENTRYPOINT [ "./dyndns.sh" ]
