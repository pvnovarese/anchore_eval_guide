FROM registry.access.redhat.com/ubi8/ubi:latest
USER 0
EXPOSE 22 80 443
COPY ./secrets.txt /secrets.txt
RUN yum install -y nmap
RUN curl -o /tmp/src.zp https://codeload.github.com/kevinboone/solunar_cmdline/zip/master
CMD /bin/sh
