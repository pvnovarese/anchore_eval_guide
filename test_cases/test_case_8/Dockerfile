FROM alpine:latest
HEALTHCHECK --timeout=10s CMD /bin/date || exit 1
USER 65534:65534
ENTRYPOINT while : \ ; do date; sleep 1; done
