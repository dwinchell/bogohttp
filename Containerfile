FROM registry.access.redhat.com/ubi9/ubi-minimal:9.6
RUN microdnf update && microdnf install -y nmap-ncat && microdnf clean all
COPY index.html /app/index.html
EXPOSE 8080
CMD while true; do \
    (echo -e "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n"; cat /app/index.html) | ncat -l -p 8080; \
done;
