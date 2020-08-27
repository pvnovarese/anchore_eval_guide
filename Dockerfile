ROM registry.access.redhat.com/ubi8/ubi:latest
RUN yum update -y && \
    yum install -y nmap git curl gnupg

RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall &&   chmod 755 msfinstall &&   ./msfinstall

EXPOSE 22 80 443


USER root